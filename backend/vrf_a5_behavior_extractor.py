"""
VRF A.5: Behavior Extractor — Parse generated P4 code and produce actual_behavior.json.
Extracts tables, key fields, actions, headers, and control blocks for intent comparison.
"""

from __future__ import annotations

import json
import re
import uuid
from datetime import datetime, timezone
from typing import Any, Dict, List, Optional


def _extract_headers(p4_code: str) -> List[str]:
    """Extract header type names (e.g. ethernet_t, ipv4_t)."""
    # header ethernet_t { ... } or header_type in older P4
    pattern = r"\bheader\s+(\w+)\s*\{"
    return list(dict.fromkeys(re.findall(pattern, p4_code)))


def _extract_tables(p4_code: str) -> List[Dict[str, Any]]:
    """Extract table definitions: name, key fields, actions, default_action."""
    tables = []
    for m in re.finditer(r"table\s+(\w+)\s*\{", p4_code):
        name = m.group(1)
        start = m.end()
        depth = 1
        i = start
        while i < len(p4_code) and depth:
            if p4_code[i] == "{":
                depth += 1
            elif p4_code[i] == "}":
                depth -= 1
            i += 1
        block = p4_code[start:i - 1]
        key_fields = re.findall(r"key\s*=\s*\{([^}]+)\}", block)
        keys = []
        if key_fields:
            for part in re.findall(r"([\w.]+\s*:\s*\w+)", key_fields[0]):
                keys.append(part.split(":")[0].strip())
        actions = re.findall(r"actions\s*=\s*\{([^}]+)\}", block)
        action_list = re.findall(r"\b(\w+)\s*[;,]", actions[0]) if actions else []
        default = re.search(r"default_action\s*=\s*(\w+)\s*", block)
        tables.append({
            "table_name": name,
            "table_type": "exact",
            "key_fields": keys,
            "actions": action_list,
            "default_action": default.group(1) if default else "NoAction"
        })
    return tables


def _table_to_behavior_id(table_name: str, key_fields: List[str], actions: List[str]) -> str:
    """
    Map a table's name/keys/actions to a behavior_id that can be matched
    against expected required_behaviors (e.g. mac_learning, mac_forwarding).
    """
    name_lower = table_name.lower()
    keys_str = " ".join(key_fields).lower()
    actions_str = " ".join(actions).lower()

    if "learn" in name_lower or "learn" in actions_str or "srcaddr" in keys_str or "src_addr" in keys_str:
        return "mac_learning_impl"
    if "forward" in name_lower or "dstaddr" in keys_str or "dst_addr" in keys_str or "egress" in actions_str:
        return "mac_forwarding_impl"
    if "filter" in name_lower or "drop" in name_lower or "firewall" in name_lower:
        return "packet_filter_impl"
    if "syn" in name_lower or "tcp" in keys_str:
        return "tcp_syn_filter_impl"
    if "ip" in name_lower or "route" in name_lower:
        return "ip_forwarding_impl"
    if "nat" in name_lower:
        return "nat_impl"
    if "vlan" in name_lower or "vlan" in keys_str:
        return "vlan_handling_impl"
    if "arp" in name_lower:
        return "arp_handling_impl"
    if "mirror" in name_lower or "clone" in name_lower:
        return "packet_mirroring_impl"
    if "count" in name_lower or "meter" in name_lower:
        return "counting_impl"
    # Generic: one table -> one generic behavior
    return "intent_impl_impl"


def _extract_control_blocks(p4_code: str) -> Dict[str, List[str]]:
    """Extract control block names (e.g. MyIngress) from V1Switch or control declarations."""
    result = {"ingress": [], "egress": []}
    # V1Switch( Parser(), VerifyChecksum(), Ingress(), Egress(), ... )
    v1_match = re.search(r"V1Switch\s*\(([^)]+(?:\([^)]*\)[^)]*)*)\)", p4_code, re.DOTALL)
    if v1_match:
        inner = v1_match.group(1)
        controls = re.findall(r"(\w+)\s*\(\s*\)", inner)
        if len(controls) >= 4:
            result["ingress"].append(controls[2])
            result["egress"].append(controls[3])
    # control MyIngress(...) { ... }
    for m in re.finditer(r"control\s+(\w+)\s*\([^)]*\)\s*\{", p4_code):
        name = m.group(1)
        if "Ingress" in name or (name.endswith("Ingress") and "Egress" not in name):
            result["ingress"].append(name)
        elif "Egress" in name or name.endswith("Egress"):
            result["egress"].append(name)
    return result


def _detect_suspicious_patterns(p4_code: str) -> List[str]:
    """Detect patterns that might match prohibited_behaviors."""
    suspicious = []
    code_lower = p4_code.lower()
    if "drop" in code_lower and "default_action" in code_lower and "drop" in code_lower:
        # default_action = drop() or similar
        if re.search(r"default_action\s*=\s*\w*drop\w*\s*", p4_code, re.IGNORECASE):
            suspicious.append("packet_drop_by_default")
    if re.search(r"hardcoded|static\s+route|0x[0-9a-f]+\s*=>", p4_code, re.IGNORECASE):
        suspicious.append("static_routing")
    return suspicious


def extract_behavior_from_code(p4_code: str, code_id: Optional[str] = None) -> dict:
    """
    Parse P4 code and return actual_behavior.json structure.
    """
    if not p4_code or not p4_code.strip():
        return _empty_actual_behavior(code_id)

    headers_defined = _extract_headers(p4_code)
    tables = _extract_tables(p4_code)
    control_blocks = _extract_control_blocks(p4_code)
    suspicious_patterns = _detect_suspicious_patterns(p4_code)

    detected_behaviors = []
    for t in tables:
        behavior_id = _table_to_behavior_id(
            t["table_name"],
            t.get("key_fields", []),
            t.get("actions", [])
        )
        detected_behaviors.append({
            "behavior_id": behavior_id,
            "evidence": {
                "table_name": t["table_name"],
                "table_type": t.get("table_type", "exact"),
                "key_fields": t.get("key_fields", []),
                "actions": t.get("actions", []),
                "default_action": t.get("default_action", "NoAction")
            }
        })

    # If no tables found, still report structure so comparator can score headers/control
    if not detected_behaviors:
        detected_behaviors.append({
            "behavior_id": "intent_impl_impl",
            "evidence": {
                "table_name": "none",
                "table_type": "exact",
                "key_fields": [],
                "actions": [],
                "default_action": "NoAction"
            }
        })

    return {
        "code_id": code_id or f"code_{uuid.uuid4().hex[:12]}",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "detected_behaviors": detected_behaviors,
        "headers_defined": headers_defined,
        "control_blocks": control_blocks,
        "suspicious_patterns": suspicious_patterns
    }


def _empty_actual_behavior(code_id: Optional[str] = None) -> dict:
    return {
        "code_id": code_id or "unknown",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "detected_behaviors": [],
        "headers_defined": [],
        "control_blocks": {"ingress": [], "egress": []},
        "suspicious_patterns": []
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
