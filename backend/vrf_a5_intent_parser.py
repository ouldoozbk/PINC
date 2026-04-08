"""
VRF A.5: Intent Parser — Convert natural language intent into expected_behavior.json.
Used before code generation to define the specification we will validate against.

Intent-to-bucket routing uses LLM (claude-haiku-4-5-20251001 for testing) via
vrf_a5_semantic_router, replacing the previous 12-entry regex INTENT_BEHAVIOR_MAP.
"""

from __future__ import annotations

import json
import re
import uuid
from datetime import datetime, timezone
from typing import List, Optional, Set, Tuple

from vrf_a5_semantic_router import BUCKET_HEADERS, route_intent_to_buckets


# Phrases that suggest prohibited behaviors (kept as lightweight regex — no embedding needed).
PROHIBITED_PATTERNS = [
    (r"\b(drop\s+all|drop\s+by\s+default|drop\s+everything)\b", "packet_drop_by_default"),
    (r"\b(static\s+route|hardcoded\s+route)\b", "static_routing"),
]


def _infer_behaviors_and_headers(intent: str, api_key: str = "") -> Tuple[List[dict], Set[str]]:
    """
    Route the intent to the 9-bucket taxonomy via LLM (Claude Haiku),
    then build required_behaviors and headers_required from the matched buckets.
    """
    matched_buckets, _ = route_intent_to_buckets(intent, api_key=api_key)

    required_behaviors: List[dict] = []
    all_headers: Set[str] = set()

    for bucket in sorted(matched_buckets):  # sorted for deterministic output
        required_behaviors.append({
            "behavior_id": bucket,
            "description": f"Inferred from intent: {bucket.replace('_', ' ')}",
            "components": {
                "table_required": True,
                "table_type": "exact",
                "key_fields": [],
                "action_types": [],
            },
        })
        all_headers.update(BUCKET_HEADERS.get(bucket, ["ethernet"]))

    return required_behaviors, all_headers


def _infer_prohibited(intent: str) -> List[str]:
    """Infer prohibited_behaviors from intent (e.g. 'do not drop all')."""
    intent_lower = intent.lower()
    prohibited = []
    for pattern, name in PROHIBITED_PATTERNS:
        if re.search(pattern, intent_lower):
            prohibited.append(name)
    return prohibited


def generate_expected_behavior(intent: str, intent_id: Optional[str] = None, api_key: str = "") -> dict:
    """
    Convert natural language intent into expected_behavior.json.

    Uses LLM  to assign the intent to one or more
    of the nine taxonomy buckets, then builds the expected behavior spec from those buckets.
    """

    matched_buckets, similarities = route_intent_to_buckets(intent, api_key=api_key)
    required_behaviors, headers_required = _infer_behaviors_and_headers(intent, api_key)
    prohibited_behaviors = _infer_prohibited(intent)

    expected = {
        "intent_id": intent_id or f"intent_{uuid.uuid4().hex[:12]}",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "intent_type": "semantic",
        "raw_intent": intent[:500],
        "buckets": sorted(matched_buckets),
        "bucket_similarities": {k: round(v, 4) for k, v in similarities.items()},
        "required_behaviors": required_behaviors,
        "headers_required": list(headers_required),
        "control_blocks": {
            "ingress": {"required": True, "must_contain": []},
            "egress": {"required": False},
        },
        "prohibited_behaviors": prohibited_behaviors,
        "performance_constraints": {},
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
