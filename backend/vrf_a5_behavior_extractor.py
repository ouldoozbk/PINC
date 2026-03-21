"""
VRF A.5: Behavior Extractor — Parse generated P4 code and produce actual_behavior.json.

Code is parsed into typed structural segments (header type names, action bodies,
table names, table key blocks, control names, extern calls) and each segment is
matched against CODE_BUCKET_SIGNALS from vrf_a5_bucket_taxonomy.py to assign the
program to one or more of the nine taxonomy buckets.

This replaces the old _table_to_behavior_id regex heuristic that mapped tables to
an ad-hoc 12-entry behavior list.
"""

from __future__ import annotations

import json
import re
import uuid
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional, Set, Tuple

from vrf_a5_bucket_taxonomy import CODE_BUCKET_SIGNALS


# Comment stripping (prevents false matches from commented-out code)
def _strip_p4_comments(code: str) -> str:
    """Remove /* */ block comments and // line comments from P4 source."""
    code = re.sub(r'/\*.*?\*/', '', code, flags=re.DOTALL)
    code = re.sub(r'//[^\n]*', '', code)
    return code


# Structural segment extractors
# Each extractor operates on comment-stripped source and returns a list of
# text strings that correspond to exactly one AST signal type.
def _extract_header_type_names(code: str) -> List[str]:
    """
    header_type signal: names of header type definitions.
    Matches 'header name_t { ... }' — returns the type name tokens only.
    """
    return re.findall(r'\bheader\s+(\w+)\s*\{', code)


def _extract_block_body(code: str, open_brace_pos: int) -> Tuple[str, int]:
    """
    Read from the opening '{' at open_brace_pos to its matching '}'.
    Returns (body_text_inside_braces, position_after_closing_brace).
    """
    depth = 1
    i = open_brace_pos + 1
    while i < len(code) and depth:
        if code[i] == '{':
            depth += 1
        elif code[i] == '}':
            depth -= 1
        i += 1
    return code[open_brace_pos + 1:i - 1], i


def _extract_action_bodies(code: str) -> List[Tuple[str, str]]:
    """
    action_call / action_body signals: extract (action_name, body_text) for every
    action definition.  Both signal types look at action bodies:
      - action_call patterns match MethodCallExpression syntax inside the body.
      - action_body  patterns match AssignmentStatement LHS syntax inside the body.
    """
    results: List[Tuple[str, str]] = []
    for m in re.finditer(r'\baction\s+(\w+)\s*\([^)]*\)\s*\{', code):
        name = m.group(1)
        brace_pos = code.index('{', m.start())
        body, _ = _extract_block_body(code, brace_pos)
        results.append((name, body))
    return results


def _extract_table_blocks(code: str) -> List[Tuple[str, str]]:
    """
    table_name / table_key signals: extract (table_name, body_text) pairs.
    table_name patterns match against the name; table_key patterns match the
    key { } sub-block text.
    """
    results: List[Tuple[str, str]] = []
    for m in re.finditer(r'\btable\s+(\w+)\s*\{', code):
        name = m.group(1)
        brace_pos = code.index('{', m.start())
        body, _ = _extract_block_body(code, brace_pos)
        results.append((name, body))
    return results


def _extract_control_names(code: str) -> List[str]:
    """
    control_name signal: names of control block definitions.
    """
    return re.findall(r'\bcontrol\s+(\w+)\s*\(', code)


def _extract_extern_text(code: str) -> str:
    """
    extern_call signal: collects text from two sources:
      1. Extern type instantiation declarations:  counter(...) cnt; / meter(...) m;
      2. Direct method calls anywhere in the code: clone(...), clone3(...),
         clone_preserving_field_list(...), cnt.count(...), etc.
    Returns a single joined string to match against extern_call patterns.
    """
    fragments: List[str] = []

    # Extern instance declarations: 'counter(N, t) name;' / 'register<T>(N) name;'
    for m in re.finditer(
        r'\b(counter|meter|register)\s*(?:<[^>]*>)?\s*\([^)]*\)\s+\w+\s*;', code
    ):
        fragments.append(m.group(1))

    # clone / clone3 / clone_preserving_field_list calls
    for m in re.finditer(r'\b(clone\w*)\s*\(', code):
        fragments.append(m.group(1))

    # Extern method calls on instances: name.count(...) / name.execute(...)
    for m in re.finditer(r'\b\w+\.(count|execute|read|write)\s*\(', code):
        # Surface the instance access as the extern type via the method name context;
        # we just need the surrounding type name for pattern matching.
        fragments.append(m.group(0))

    return ' '.join(fragments)


def _extract_apply_block_text(code: str) -> str:
    """
    Collect the text inside all apply { } blocks (control body apply sections).
    Used as supplementary source for extern_call signals that appear in apply blocks.
    """
    fragments: List[str] = []
    for m in re.finditer(r'\bapply\s*\{', code):
        brace_pos = code.index('{', m.start())
        body, _ = _extract_block_body(code, brace_pos)
        fragments.append(body)
    return ' '.join(fragments)


# Bucket classifier
def _classify_buckets(code: str) -> Set[str]:
    """
    Apply CODE_BUCKET_SIGNALS to the structured segments extracted from *code*.
    Returns the set of matched bucket names.

    Signal-type → text source mapping mirrors the AST node types described in
    the proposal (Table 2):
      header_type  → Type_Header node names
      control_name → P4Control node names
      table_name   → P4Table node names
      table_key    → P4Table key element field expressions
      action_call  → MethodCallExpression text inside action bodies
      action_body  → AssignmentStatement text inside action bodies
      extern_call  → extern instantiation + clone/counter/meter call sites
    """
    clean = _strip_p4_comments(code)

    header_names = _extract_header_type_names(clean)
    control_names = _extract_control_names(clean)
    action_pairs = _extract_action_bodies(clean)
    table_pairs = _extract_table_blocks(clean)
    extern_text = _extract_extern_text(clean) + ' ' + _extract_apply_block_text(clean)

    # Build one concatenated string per signal type.
    # Include action names as well as bodies so taxonomy patterns can match
    # semantic naming conventions (e.g., encap_tunnel, push_vlan, set_nexthop).
    action_text = ' '.join(f"{name} {body}" for name, body in action_pairs)

    table_key_text = ' '.join(
        km.group(1)
        for _, tbody in table_pairs
        for km in re.finditer(r'\bkey\s*=\s*\{([^}]+)\}', tbody)
    )

    signal_sources: Dict[str, str] = {
        "header_type":  ' '.join(header_names),
        "control_name": ' '.join(control_names),
        "table_name":   ' '.join(name for name, _ in table_pairs),
        "table_key":    table_key_text,
        "action_call":  action_text,   # MethodCallExpression lives in action bodies
        "action_body":  action_text,   # AssignmentStatement also in action bodies
        "extern_call":  extern_text,
    }

    buckets: Set[str] = set()
    for signal_type, pattern, bucket in CODE_BUCKET_SIGNALS:
        text = signal_sources.get(signal_type, "")
        if text and re.search(pattern, text, re.IGNORECASE):
            buckets.add(bucket)

    # Heuristic recovery: many generated programs implement core intent logic
    # via direct header validity or metadata assignments across apply/control
    # blocks. Capture the most common missed patterns.
    if "encapsulation" not in buckets and re.search(
        r"\bhdr\.\w*(gre|vxlan|geneve|ipip|tunnel|outer|mpls)\w*\.set(Valid|Invalid)\s*\(",
        clean,
        re.IGNORECASE,
    ):
        buckets.add("encapsulation")

    if "forwarding" not in buckets and re.search(
        r"\bstandard_metadata\.egress_spec\s*=",
        clean,
        re.IGNORECASE,
    ):
        buckets.add("forwarding")

    if "group_service" not in buckets and re.search(
        r"\bstandard_metadata\.(mcast_grp|egress_rid)\s*=",
        clean,
        re.IGNORECASE,
    ):
        buckets.add("group_service")

    return buckets


# Legacy structural helpers (kept for headers_defined / control_blocks fields
# that the semantic comparator still reads)
def _extract_headers(code: str) -> List[str]:
    """Extract header type names from header definitions (preserves insertion order)."""
    return list(dict.fromkeys(
        re.findall(r'\bheader\s+(\w+)\s*\{', _strip_p4_comments(code))
    ))


def _extract_control_blocks(code: str) -> Dict[str, List[str]]:
    """Extract ingress / egress control names from V1Switch and control declarations."""
    result: Dict[str, List[str]] = {"ingress": [], "egress": []}
    clean = _strip_p4_comments(code)

    v1_match = re.search(r'V1Switch\s*\(([^)]+(?:\([^)]*\)[^)]*)*)\)', clean, re.DOTALL)
    if v1_match:
        controls = re.findall(r'(\w+)\s*\(\s*\)', v1_match.group(1))
        if len(controls) >= 4:
            result["ingress"].append(controls[2])
            result["egress"].append(controls[3])

    for m in re.finditer(r'\bcontrol\s+(\w+)\s*\([^)]*\)\s*\{', clean):
        name = m.group(1)
        if "Ingress" in name and name not in result["ingress"]:
            result["ingress"].append(name)
        elif "Egress" in name and name not in result["egress"]:
            result["egress"].append(name)

    return result


def _detect_suspicious_patterns(code: str) -> List[str]:
    """Detect patterns matching prohibited_behaviors in the intent spec."""
    suspicious: List[str] = []
    clean = _strip_p4_comments(code)
    if re.search(r'default_action\s*=\s*\w*drop\w*\s*', clean, re.IGNORECASE):
        suspicious.append("packet_drop_by_default")
    if re.search(r'\b(hardcoded|static\s+route)\b', clean, re.IGNORECASE):
        suspicious.append("static_routing")
    return suspicious


# Public API
def extract_behavior_from_code(p4_code: str, code_id: Optional[str] = None) -> dict:
    """
    Parse P4 code and return actual_behavior.json structure.

    The primary output is the *buckets* field — the set of 9-taxonomy buckets
    detected in the code via CODE_BUCKET_SIGNALS.  detected_behaviors is built
    from that set so the semantic comparator (which reads behavior_id fields)
    remains compatible.
    """
    if not p4_code or not p4_code.strip():
        return _empty_actual_behavior(code_id)

    buckets = _classify_buckets(p4_code)
    headers_defined = _extract_headers(p4_code)
    control_blocks = _extract_control_blocks(p4_code)
    suspicious_patterns = _detect_suspicious_patterns(p4_code)

    # Build detected_behaviors from buckets so the comparator can match
    # against required_behaviors[].behavior_id (which now uses bucket names).
    detected_behaviors = [
        {
            "behavior_id": bucket,
            "evidence": {"source": "bucket_classification"},
        }
        for bucket in sorted(buckets)
    ]

    return {
        "code_id": code_id or f"code_{uuid.uuid4().hex[:12]}",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "buckets": sorted(buckets),
        "detected_behaviors": detected_behaviors,
        "headers_defined": headers_defined,
        "control_blocks": control_blocks,
        "suspicious_patterns": suspicious_patterns,
    }


def _empty_actual_behavior(code_id: Optional[str] = None) -> dict:
    return {
        "code_id": code_id or "unknown",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "buckets": [],
        "detected_behaviors": [],
        "headers_defined": [],
        "control_blocks": {"ingress": [], "egress": []},
        "suspicious_patterns": [],
    }


def save_actual_behavior(actual: dict, path: str = "actual_behavior.json") -> None:
    """Write actual behavior JSON to file."""
    with open(path, "w") as f:
        json.dump(actual, f, indent=2)


if __name__ == "__main__":
    import sys
    path = sys.argv[1] if len(sys.argv) > 1 else "test.p4"
    try:
        with open(path) as f:
            code = f.read()
    except FileNotFoundError:
        code = ""
    out = extract_behavior_from_code(code)
    save_actual_behavior(out)
    print(json.dumps(out, indent=2))
