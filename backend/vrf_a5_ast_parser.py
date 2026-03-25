"""
VRF A.5: P4 AST Parser — Step 1 of AST-based bucket classification.

Reads the p4c JSON IR (--toJSON ir.json) and walks the node tree to extract
typed signal streams. Input is always a valid, type-checked IR from VRF A.

p4c JSON IR structure
---------------------
Every node has a "Node_Type" key (e.g. "P4Control", "Type_Header").
Ordered collections are wrapped in {"vec": [...]} and unwrapped transparently.

Node types extracted
--------------------
  Type_Header          → header_type
  P4Control            → control_name
  P4Table              → table_name, table_key (from key block)
  P4Action             → action_call, action_body
  MethodCallStatement  → action_call
  AssignmentStatement  → action_body (LHS)
  Declaration_Instance → extern_call (counter/meter/register)
  MethodCallExpression → extern_call (clone/digest/etc.)

Signal dict keys: header_type, control_name, table_name, table_key,
                  action_call, action_body, extern_call  — all List[str]

Ref: https://github.com/p4lang/p4c/blob/main/ir/ir.def
"""

from __future__ import annotations

import json
from typing import Any, Dict, Generator, List


SignalDict = Dict[str, List[str]]

_EXTERN_TYPES = {"counter", "meter", "register", "Counter", "Meter", "Register"}


# JSON IR walker
def _walk(obj: Any) -> Generator[dict, None, None]:
    """
    Recursively yield every dict that has a 'Node_Type' field.
    Unwraps p4c's {"vec": [...]} list wrapper transparently.
    """
    if isinstance(obj, dict):
        if "Node_Type" in obj:
            yield obj
        for v in obj.values():
            yield from _walk(v)
    elif isinstance(obj, list):
        for item in obj:
            yield from _walk(item)


# Expression → dotted-string helpers
def _expr_to_str(node: Any) -> str:
    """
    Convert a p4c expression node to its dotted identifier string.

    Handles:
      PathExpression  → "varName"
      Member          → "expr.member"  (recursive)
      ArrayIndex      → "expr[n]"  (simplified to "expr")
    Returns "" for unrecognised node shapes.
    """
    if not isinstance(node, dict):
        return ""
    ntype = node.get("Node_Type", "")

    if ntype == "PathExpression":
        path = node.get("path", {})
        if isinstance(path, dict):
            return path.get("name", "")
        return ""

    if ntype == "Member":
        expr = node.get("expr", {})
        member = node.get("member", "")
        parent = _expr_to_str(expr)
        return f"{parent}.{member}" if parent else member

    if ntype == "ArrayIndex":
        # e.g. hdr.mpls[0] — just surface the base expression
        return _expr_to_str(node.get("left", {}))

    # Some versions wrap the callee in a "MethodCallExpression" node when chaining
    if ntype == "MethodCallExpression":
        return _expr_to_str(node.get("method", {}))

    return ""


# Per-node-type signal extractors
def _extract_type_header(node: dict, signals: SignalDict) -> None:
    name = node.get("name", "")
    if name:
        signals["header_type"].append(name)


def _extract_p4_control(node: dict, signals: SignalDict) -> None:
    name = node.get("name", "")
    if name:
        signals["control_name"].append(name)
    # Tables, actions, and apply-block statements inside the control body are
    # visited separately when _walk yields them; no need to recurse manually here.


def _extract_p4_table(node: dict, signals: SignalDict) -> None:
    name = node.get("name", "")
    if name:
        signals["table_name"].append(name)

    # Key block: properties is a vec of P4Property nodes.
    # The "key" property's value is a Key node with keyElements.
    for prop_node in _walk(node.get("properties", {})):
        if prop_node.get("Node_Type") != "P4Property":
            continue
        if prop_node.get("name") != "key":
            continue
        key_node = prop_node.get("value", {})
        if not isinstance(key_node, dict):
            continue
        for elem in _walk(key_node.get("keyElements", {})):
            if elem.get("Node_Type") != "KeyElement":
                continue
            expr_str = _expr_to_str(elem.get("expression", {}))
            if expr_str:
                signals["table_key"].append(expr_str)


def _extract_p4_action(node: dict, signals: SignalDict) -> None:
    name = node.get("name", "")
    if name:
        # Action name itself is a useful signal (e.g. "ipv4_forward", "push_vlan").
        signals["action_call"].append(name)
    # Statements are visited by _walk when it encounters them inside the body.


def _extract_method_call_statement(node: dict, signals: SignalDict) -> None:
    """
    MethodCallStatement wraps a MethodCallExpression.
    Extracts the callee dotted name as an action_call signal.
    """
    mc = node.get("methodCall", {})
    if not isinstance(mc, dict):
        return
    callee = _expr_to_str(mc.get("method", {}))
    if callee:
        signals["action_call"].append(callee)

    # Check if the callee is a clone / extern call for extern_call signal.
    base = callee.split(".")[-1] if callee else ""
    if base and any(base.lower().startswith(k) for k in ("clone", "digest", "recirculate", "resubmit")):
        signals["extern_call"].append(callee)


def _extract_assignment_statement(node: dict, signals: SignalDict) -> None:
    """
    AssignmentStatement: left is the LHS expression.
    Extracts the dotted LHS path as an action_body signal.
    """
    lhs = _expr_to_str(node.get("left", {}))
    if lhs:
        signals["action_body"].append(lhs)


def _extract_declaration_instance(node: dict, signals: SignalDict) -> None:
    """
    Declaration_Instance: extern type instantiation (counter, meter, register).
    Also covers clone_preserving_field_list and similar externs.
    """
    type_node = node.get("type", {})
    if not isinstance(type_node, dict):
        return

    # The type might be a Type_Name wrapping a Path, or a Type_Specialized wrapping
    # a base Type_Name.  Walk one level to find the base type name.
    type_name = ""
    nt = type_node.get("Node_Type", "")
    if nt == "Type_Name":
        path = type_node.get("path", {})
        type_name = path.get("name", "") if isinstance(path, dict) else ""
    elif nt == "Type_Specialized":
        base = type_node.get("baseType", {})
        if isinstance(base, dict) and base.get("Node_Type") == "Type_Name":
            path = base.get("path", {})
            type_name = path.get("name", "") if isinstance(path, dict) else ""

    if type_name and (type_name in _EXTERN_TYPES or type_name.lower() in _EXTERN_TYPES):
        signals["extern_call"].append(type_name.lower())


# Main signal extractor
_DISPATCH = {
    "Type_Header":           _extract_type_header,
    "P4Control":             _extract_p4_control,
    "P4Table":               _extract_p4_table,
    "P4Action":              _extract_p4_action,
    "MethodCallStatement":   _extract_method_call_statement,
    "AssignmentStatement":   _extract_assignment_statement,
    "Declaration_Instance":  _extract_declaration_instance,
}


def extract_signals_from_ir(ir: dict) -> SignalDict:
    """
    Walk a p4c JSON IR dict and return the typed signal dict.

    Args:
        ir: Parsed JSON object from ir.json (output of p4c --toJSON).

    Returns:
        SignalDict with keys: header_type, control_name, table_name, table_key,
        action_call, action_body, extern_call.  Values are lists of string tokens
        (possibly with duplicates — the classifier uses re.search so duplicates
        are harmless).
    """
    signals: SignalDict = {
        "header_type":  [],
        "control_name": [],
        "table_name":   [],
        "table_key":    [],
        "action_call":  [],
        "action_body":  [],
        "extern_call":  [],
    }

    for node in _walk(ir):
        ntype = node.get("Node_Type", "")
        handler = _DISPATCH.get(ntype)
        if handler:
            handler(node, signals)

    return signals


# Public API
def load_ir(path: str = "ir.json") -> dict:
    """
    Load the p4c JSON IR written by VRF A.

    Raises:
        RuntimeError: if ir.json is missing (VRF A Docker run did not execute)
                      or cannot be parsed as JSON.
    """
    try:
        with open(path) as fh:
            return json.load(fh)
    except FileNotFoundError:
        raise RuntimeError(
            f"p4c IR file not found at {path!r}. "
            "VRF A.5 requires p4c to run via Docker (vrf_a_compile.sh) before "
            "bucket classification. Ensure Docker is running and VRF A has "
            "completed successfully."
        )
    except json.JSONDecodeError as exc:
        raise RuntimeError(
            f"p4c IR file at {path!r} is not valid JSON: {exc}. "
            "Re-run VRF A to regenerate ir.json."
        )


def signals_from_ir_file(path: str = "ir.json") -> SignalDict:
    """
    Load ir.json and return the typed signal dict.

    Raises:
        RuntimeError: if ir.json is missing or malformed (see load_ir).
    """
    return extract_signals_from_ir(load_ir(path))


# CLI smoke-test  (python vrf_a5_ast_parser.py [ir.json])
if __name__ == "__main__":
    import sys

    ir_path = sys.argv[1] if len(sys.argv) > 1 else "ir.json"
    try:
        sigs = signals_from_ir_file(ir_path)
    except RuntimeError as e:
        print(f"Error: {e}")
        sys.exit(1)

    for key, values in sigs.items():
        print(f"{key:15} ({len(values):3}): {values[:8]}")
