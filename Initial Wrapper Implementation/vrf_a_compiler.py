"""
VRF A: P4 Code Compiler — Clean LLM-generated P4 code and validate compilation via p4c (Docker).

Extracts from the former network_intent_to_p4.py.  The shell script that actually
runs the Docker p4c container is ``vrf_a_compile.sh``.
"""

import os
import re
import subprocess
from typing import Tuple, Optional


# P4 code cleanup helpers
def clean_p4_code(raw_code: str) -> str:
    """Clean up the generated P4 code by removing markdown formatting and extra content."""
    # Find the P4 code block
    p4_block = re.search(r'```(?:P4|p4)?\n(.*?)```', raw_code, re.DOTALL)
    if p4_block:
        code = p4_block.group(1).strip()
    else:
        # If no code block found, try to find the first #include
        code = raw_code.strip()
        if '#include' in code:
            code = code[code.find('#include'):]

    # Remove any text before the first #include
    if '#include' in code:
        code = code[code.find('#include'):]

    # Remove any "p4" or "P4" line at the start of the file
    code = re.sub(r'^[pP]4\s*\n', '', code)

    # P4-16 uses "const", not "constant" (P4-14). Fix common LLM mistake.
    code = re.sub(r'\bconstant\b', 'const', code)

    # P4-16 uses table_name.apply(), not apply_table(table_name) (P4-14).
    code = re.sub(r'\bapply_table\s*\(\s*(\w+)\s*\)', r'\1.apply()', code)

    # Fix common LLM mistake: using struct type name "metadata" instead of
    # the parameter name "meta" inside control blocks.
    # Negative lookbehind for "struct " avoids mangling the struct definition line.
    code = re.sub(r'(?<!struct )(?<!\w)metadata\.', 'meta.', code)

    # Fix "table name.apply();" → "name.apply();"  (LLM confuses table declaration with apply call)
    code = re.sub(r'\btable\s+(\w+)\.apply\s*\(\s*\)', r'\1.apply()', code)

    # Remove duplicate V1Switch(...) main; lines — keep only the first
    v1_lines = list(re.finditer(r'^V1Switch\s*\(.*?\)\s*main\s*;', code, re.MULTILINE | re.DOTALL))
    if len(v1_lines) > 1:
        # Remove all but the first
        for m in reversed(v1_lines[1:]):
            code = code[:m.start()] + code[m.end():]

    # Fix tables defined at file level (outside any control block).
    # Detect "table <name> {" that appears at indentation 0 (file level) and
    # is NOT inside a control block. This is a structural error — we cannot
    # reliably move them, but we can wrap them inside a dummy comment so the
    # next regeneration prompt shows the compiler error clearly.
    # Actually, the more practical fix: ensure actions are NOT inside table blocks.
    # Pull "action ... { ... }" out of table blocks and place them before the table.
    code = _fix_actions_inside_tables(code)

    # Fix common LLM mistake: calling ControlName.apply() as if it were a table.
    # In P4-16, .apply() is only valid on tables, never on control blocks.
    v1_control_names = _extract_v1switch_control_names(code)
    for ctrl_name in v1_control_names:
        code = re.sub(
            r'^\s*' + re.escape(ctrl_name) + r'\s*\.\s*apply\s*\(\s*\)\s*;\s*$',
            '',
            code,
            flags=re.MULTILINE
        )

    # Remove extra control blocks not part of V1Switch (e.g. MyForwarding).
    if v1_control_names:
        code = _remove_unused_controls(code, v1_control_names)

    # Move tables out of apply {} blocks — tables must be at control-block level,
    # not inside apply { }.  The LLM sometimes nests them incorrectly.
    code = _move_tables_out_of_apply(code)

    # Move orphaned tables/actions (at file level) into the control block that uses them.
    code = _move_orphaned_tables_into_controls(code)

    # Ensure V1Switch(...) main; is the very last line (after all control definitions).
    code = _move_v1switch_to_end(code)

    # Remove any leading/trailing whitespace
    code = code.strip()

    return code


def _move_tables_out_of_apply(code: str) -> str:
    """Move table/action definitions from inside apply { } blocks to the
    control block level (before apply). In P4-16, tables and actions must be
    at the top level of a control block, not nested inside apply {}."""

    def _extract_block(src, start_pos):
        """Given source and position of opening '{', return end position (after '}')."""
        d = 1
        i = start_pos + 1
        while i < len(src) and d > 0:
            if src[i] == '{': d += 1
            elif src[i] == '}': d -= 1
            i += 1
        return i

    changed = True
    while changed:
        changed = False
        # Find "apply {" that contains a table or action definition
        for am in re.finditer(r'\bapply\s*\{', code):
            brace_pos = code.index('{', am.start())
            end_pos = _extract_block(code, brace_pos)
            apply_body = code[brace_pos + 1:end_pos - 1]

            # Collect blocks (table or action) to extract
            blocks_to_extract = []
            scan = apply_body
            for bm in re.finditer(r'\b(table|action)\s+\w+[^{]*\{', scan):
                block_brace = scan.index('{', bm.start())
                block_end = _extract_block(scan, block_brace)
                block_text = scan[bm.start():block_end]
                blocks_to_extract.append(block_text)

            if not blocks_to_extract:
                continue

            # Remove blocks from apply body
            new_body = apply_body
            for bt in blocks_to_extract:
                new_body = new_body.replace(bt, '', 1)
            new_body = re.sub(r'\n{3,}', '\n', new_body)

            # Reconstruct: insert extracted blocks before apply { }
            indent = '    '
            extracted = '\n'.join(
                '\n'.join(indent + line if line.strip() else '' for line in bt.split('\n'))
                for bt in blocks_to_extract
            )
            new_apply = 'apply {' + new_body + '}'
            replacement = extracted + '\n' + indent + new_apply

            # Replace the original "apply { ... }" in code
            code = code[:am.start()] + replacement + code[end_pos:]
            changed = True
            break  # Restart since positions shifted

    return code


def _move_v1switch_to_end(code: str) -> str:
    """Ensure the V1Switch(...) main; instantiation is the very last statement
    in the file. The LLM sometimes places it before control definitions."""
    m = re.search(r'^V1Switch\s*\(.*?\)\s*main\s*;[ \t]*$', code, re.MULTILINE | re.DOTALL)
    if not m:
        return code
    v1_line = m.group(0)
    rest_after = code[m.end():].strip()
    if not rest_after:
        return code  # Already at the end
    # Check if there's meaningful code after V1Switch (control definitions)
    if re.search(r'\b(control|parser)\b', rest_after):
        code = code[:m.start()] + code[m.end():]
        code = code.rstrip() + '\n\n' + v1_line + '\n'
    return code


def _fix_actions_inside_tables(code: str) -> str:
    """Move action definitions that are incorrectly nested inside table blocks
    to just before the table (at the control block level where they belong)."""
    result = code
    # Find table blocks: table name { ... }
    for tm in list(re.finditer(r'(table\s+\w+\s*\{)', code)):
        table_start = tm.start()
        brace_start = code.index('{', tm.start())
        depth = 1
        i = brace_start + 1
        while i < len(code) and depth > 0:
            if code[i] == '{':
                depth += 1
            elif code[i] == '}':
                depth -= 1
            i += 1
        table_block = code[brace_start + 1:i - 1]

        # Find any action definitions inside this table block
        actions_to_extract = []
        for am in re.finditer(r'(\baction\s+\w+\s*\([^)]*\)\s*\{)', table_block):
            action_start = am.start()
            ab_start = table_block.index('{', am.start())
            d = 1
            j = ab_start + 1
            while j < len(table_block) and d > 0:
                if table_block[j] == '{':
                    d += 1
                elif table_block[j] == '}':
                    d -= 1
                j += 1
            action_text = table_block[action_start:j]
            actions_to_extract.append(action_text)

        if actions_to_extract:
            # Remove the actions from the table block
            new_table_block = table_block
            for action_text in actions_to_extract:
                new_table_block = new_table_block.replace(action_text, '', 1)
            # Clean up blank lines
            new_table_block = re.sub(r'\n{2,}', '\n', new_table_block)

            # Replace the old table block content with the cleaned one
            old_full = code[brace_start + 1:i - 1]
            result = result.replace(old_full, new_table_block, 1)

            # Insert extracted actions before the table
            actions_text = '\n'.join(actions_to_extract) + '\n    '
            table_line = tm.group(0)
            result = result.replace(table_line, actions_text + table_line, 1)

    return result


def _move_orphaned_tables_into_controls(code: str) -> str:
    """Move table and action definitions found at file scope into the control
    block that references them.  This fixes the common LLM mistake
    of defining tables/actions outside of control blocks."""

    def _find_orphaned_blocks(src: str):
        """Return list of (start_line, end_line, block_text, kind, name) for
        table/action definitions at brace-depth 0 (file scope)."""
        found = []
        lines = src.split('\n')
        depth = 0
        i = 0
        while i < len(lines):
            line = lines[i]
            prev_depth = depth
            depth += line.count('{') - line.count('}')
            if prev_depth <= 0:
                stripped = line.lstrip()
                kind = None
                if stripped.startswith('table '):
                    kind = 'table'
                elif stripped.startswith('action '):
                    kind = 'action'
                if kind:
                    name_m = re.match(r'\s*(?:table|action)\s+(\w+)', line)
                    name = name_m.group(1) if name_m else ''
                    block_lines = [line]
                    block_depth = line.count('{') - line.count('}')
                    j = i + 1
                    while j < len(lines) and (block_depth > 0 or '{' not in ''.join(block_lines)):
                        block_lines.append(lines[j])
                        block_depth += lines[j].count('{') - lines[j].count('}')
                        j += 1
                    found.append((i, j, '\n'.join(block_lines), kind, name))
                    i = j
                    depth = prev_depth
                    continue
            i += 1
        return found

    def _get_control_blocks(src: str):
        """Return list of (ctrl_name, ctrl_match, ctrl_body) for each control block."""
        controls = []
        for cm in re.finditer(r'(control\s+(\w+)\s*\([^)]*\)\s*\{)', src):
            ctrl_start = cm.end()
            d = 1
            k = ctrl_start
            while k < len(src) and d > 0:
                if src[k] == '{': d += 1
                elif src[k] == '}': d -= 1
                k += 1
            controls.append((cm.group(2), cm, src[ctrl_start:k-1]))
        return controls

    def _find_target_for_table(table_name: str, src: str):
        """Find the control that calls table_name.apply()."""
        pattern = re.escape(table_name) + r'\s*\.\s*apply\s*\('
        for ctrl_name, cm, body in _get_control_blocks(src):
            if re.search(pattern, body):
                return ctrl_name
        return None

    def _find_target_for_action(action_name: str, src: str):
        """Find the control whose tables list this action in actions = { ... }."""
        pattern = r'actions\s*=\s*\{[^}]*\b' + re.escape(action_name) + r'\b'
        for ctrl_name, cm, body in _get_control_blocks(src):
            if re.search(pattern, body):
                return ctrl_name
        # Fallback: if there's only one control with an apply block, use it
        controls = _get_control_blocks(src)
        ingress = [c for c in controls if 'Ingress' in c[0]]
        if ingress:
            return ingress[0][0]
        return None

    def _insert_into_control(src: str, ctrl_name: str, block_text: str) -> str:
        """Insert block_text inside the named control, just after the opening brace."""
        cm = re.search(r'(control\s+' + re.escape(ctrl_name) + r'\s*\([^)]*\)\s*\{)', src)
        if not cm:
            return src
        insert_pos = cm.end()
        indent = '    '
        indented = '\n'.join(indent + l if l.strip() else l for l in block_text.split('\n'))
        return src[:insert_pos] + '\n' + indented + src[insert_pos:]

    # Process orphaned blocks: tables first, then actions
    orphaned = _find_orphaned_blocks(code)
    if not orphaned:
        return code

    # Process in reverse order to maintain positions
    for _, _, block_text, kind, name in reversed(orphaned):
        if kind == 'table':
            target = _find_target_for_table(name, code)
        else:  # action
            target = _find_target_for_action(name, code)

        if target:
            code = code.replace(block_text, '', 1)
            code = re.sub(r'\n{3,}', '\n\n', code)
            code = _insert_into_control(code, target, block_text)

    return code


def _extract_v1switch_control_names(code: str) -> set:
    """Extract the control names used in the V1Switch(...) instantiation."""
    m = re.search(r'V1Switch\s*\(([^;]+)\)\s*main\s*;', code, re.DOTALL)
    if not m:
        return set()
    inner = m.group(1)
    return set(re.findall(r'(\w+)\s*\(\s*\)', inner))


def _remove_unused_controls(code: str, v1switch_names: set) -> str:
    """Remove control block definitions that are not referenced in V1Switch."""
    result = code
    for m in list(re.finditer(r'control\s+(\w+)\s*\([^)]*\)\s*\{', code)):
        name = m.group(1)
        if name not in v1switch_names:
            start = m.start()
            brace_start = code.index('{', m.start())
            depth = 1
            i = brace_start + 1
            while i < len(code) and depth > 0:
                if code[i] == '{':
                    depth += 1
                elif code[i] == '}':
                    depth -= 1
                i += 1
            block = code[start:i]
            result = result.replace(block, '', 1)
    result = re.sub(r'\n{3,}', '\n\n', result)
    return result


# VRF A: Compilation validation
def validate_p4_code(p4_code: str, filename: str, attempt: int) -> Tuple[bool, Optional[str]]:
    """Clean, save, and compile P4 code. Returns (success, error_feedback)."""
    cleaned_code = clean_p4_code(p4_code)

    with open(filename, 'w') as f:
        f.write(cleaned_code)

    # Note: do NOT use shell=True with list args — it ignores extra elements on Unix.
    subprocess.run(['./vrf_a_compile.sh', str(attempt)])

    try:
        with open('validation_status.txt', 'r') as f:
            status = f.read().strip()

        if status == "SUCCESS":
            return True, None

        with open('error_summary.txt', 'r') as f:
            error_feedback = f.read()
        return False, error_feedback

    except FileNotFoundError:
        return False, "Validation process failed to create status file"


def validate_p4_compilation(p4_code: str, filename: str = "test.p4", attempt: int = 1) -> Tuple[bool, Optional[str]]:
    """Run compilation-only validation (VRF A). Returns (success, error_feedback_string)."""
    cleaned = clean_p4_code(p4_code)
    with open(filename, "w") as f:
        f.write(cleaned)
    subprocess.run(["./vrf_a_compile.sh", str(attempt)])
    try:
        with open("validation_status.txt", "r") as f:
            status = f.read().strip()
        if status == "SUCCESS":
            return True, None
        with open("error_summary.txt", "r") as f:
            return False, f.read()
    except FileNotFoundError:
        return False, "Validation process failed to create status file"


def read_error_summary() -> str:
    """Read the error summary file and return its contents."""
    try:
        with open("error_summary.txt", "r") as f:
            content = f.read()
            # Only return the last 3 attempts to keep the context size manageable
            attempts = content.split("=== Attempt")
            if len(attempts) > 4:  # Keep header + last 3 attempts
                return "=== P4 Code Validation Error History ===\n" + "=== Attempt".join(attempts[-3:])
            return content
    except FileNotFoundError:
        return "No error history available."
