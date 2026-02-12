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

    # Remove any leading/trailing whitespace
    code = code.strip()

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
