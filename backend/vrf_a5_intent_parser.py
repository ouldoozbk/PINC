"""
VRF A.5: Intent Parser — Convert natural language intent into expected_behavior.json.
Used before code generation to define the specification we will validate against.
"""

from __future__ import annotations

import json
import re
import uuid
from datetime import datetime, timezone
from typing import List, Optional, Set, Tuple


# Keywords that map intent phrases to behavior_ids and required headers.
# NOTE: Use \w* after keywords (not \b at end) so we match inflected forms
# like "learning", "forwarding", "filtering" etc.
INTENT_BEHAVIOR_MAP = [
    (r"\b(switch\w*|forward\w*)\b", "forwarding", ["ethernet"]),
    (r"\b(mac\s+learn\w*|learn\w*\s+mac|source\s+mac)\b", "mac_learning", ["ethernet"]),
    (r"\b(destination\s+mac|dst\s+mac|forward\w*\s+by\s+mac|mac\s+forward\w*)\b", "mac_forwarding", ["ethernet"]),
    (r"\b(firewall\w*|filter\w*|drop\w*|block\w*)\b", "packet_filter", ["ethernet", "ipv4"]),
    (r"\b(tcp\s+syn|syn\s+packet)\b", "tcp_syn_filter", ["ethernet", "ipv4", "tcp"]),
    (r"\b(ip\s+forward\w*|routing|route\w*)\b", "ip_forwarding", ["ethernet", "ipv4"]),
    (r"\b(nat|network\s+address\s+translation)\b", "nat", ["ethernet", "ipv4"]),
    (r"\b(load\s+balanc\w*)\b", "load_balancing", ["ethernet", "ipv4"]),
    (r"\b(vlan\w*|vlan\s+tag\w*)\b", "vlan_handling", ["ethernet", "vlan"]),
    (r"\b(arp|address\s+resolution)\b", "arp_handling", ["ethernet", "arp"]),
    (r"\b(mirror\w*|clone\w*)\b", "packet_mirroring", ["ethernet"]),
    (r"\b(counter\w*|count\w*|meter\w*)\b", "counting", ["ethernet"]),
]

# Phrases that suggest prohibited behaviors
PROHIBITED_PATTERNS = [
    (r"\b(drop\s+all|drop\s+by\s+default|drop\s+everything)\b", "packet_drop_by_default"),
    (r"\b(static\s+route|hardcoded\s+route)\b", "static_routing"),
]


def _infer_behaviors_and_headers(intent: str) -> Tuple[List[dict], Set[str]]:
    """Infer required_behaviors and headers_required from intent text."""
    intent_lower = intent.lower().strip()
    behaviors_seen = set()
    required_behaviors = []
    all_headers = set()

    for pattern, behavior_id, headers in INTENT_BEHAVIOR_MAP:
        if re.search(pattern, intent_lower, re.IGNORECASE) and behavior_id not in behaviors_seen:
            behaviors_seen.add(behavior_id)
            required_behaviors.append({
                "behavior_id": behavior_id,
                "description": f"Inferred from intent: {behavior_id.replace('_', ' ')}",
                "components": {
                    "table_required": True,
                    "table_type": "exact",
                    "key_fields": [],
                    "action_types": []
                }
            })
            all_headers.update(headers)

    # If nothing matched, treat whole intent as one generic behavior so we don't fail everything
    if not required_behaviors:
        required_behaviors.append({
            "behavior_id": "intent_impl",
            "description": intent[:200],
            "components": {
                "table_required": True,
                "table_type": "exact",
                "key_fields": [],
                "action_types": []
            }
        })
        all_headers.add("ethernet")

    return required_behaviors, all_headers


def _infer_prohibited(intent: str) -> List[str]:
    """Infer prohibited_behaviors from intent (e.g. 'do not drop all')."""
    intent_lower = intent.lower()
    prohibited = []
    for pattern, name in PROHIBITED_PATTERNS:
        if re.search(pattern, intent_lower):
            prohibited.append(name)
    return prohibited


def generate_expected_behavior(intent: str, intent_id: Optional[str] = None) -> dict:
    """
    Convert natural language intent into expected_behavior.json.

    Uses keyword/template inference. Can be extended with LLM-based parsing
    for complex intents (see vrf-validation.md).
    """
    if not intent or not intent.strip():
        intent = "basic packet forwarding"

    required_behaviors, headers_required = _infer_behaviors_and_headers(intent)
    prohibited_behaviors = _infer_prohibited(intent)

    expected = {
        "intent_id": intent_id or f"intent_{uuid.uuid4().hex[:12]}",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "intent_type": "inferred",
        "raw_intent": intent[:500],
        "required_behaviors": required_behaviors,
        "headers_required": list(headers_required),
        "control_blocks": {
            "ingress": {"required": True, "must_contain": []},
            "egress": {"required": False}
        },
        "prohibited_behaviors": prohibited_behaviors,
        "performance_constraints": {}
    }
    return expected


def save_expected_behavior(expected: dict, path: str = "expected_behavior.json") -> None:
    """Write expected behavior JSON to file."""
    with open(path, "w") as f:
        json.dump(expected, f, indent=2)


if __name__ == "__main__":
    import sys
    intent = sys.argv[1] if len(sys.argv) > 1 else "Implement a basic Ethernet switch with source MAC learning"
    out = generate_expected_behavior(intent)
    save_expected_behavior(out)
    print(json.dumps(out, indent=2))
