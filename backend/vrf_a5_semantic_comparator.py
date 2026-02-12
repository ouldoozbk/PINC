"""
VRF A.5: Semantic Comparator — Compare expected vs actual behavior JSON and compute match score.
Implements scoring and feedback generation as in vrf-validation.md.
"""

from __future__ import annotations

from typing import Any, Dict, Optional, Tuple


# Weights for final score (must sum to 1.0)
WEIGHTS = {
    "required_behaviors": 0.5,
    "headers": 0.15,
    "control_blocks": 0.15,
    "prohibited_check": 0.2,
}


def _normalize_behavior_id_for_match(behavior_id: str) -> str:
    """Map actual behavior_id to expected form (e.g. mac_learning_impl -> mac_learning)."""
    s = behavior_id.strip()
    if s.endswith("_impl"):
        return s[:-5]  # remove _impl
    return s


# Hierarchical behavior relationships: child -> set of parent behavior_ids it can satisfy.
# e.g. "mac_forwarding" also satisfies "forwarding"; "mac_learning" also satisfies "learning".
_BEHAVIOR_HIERARCHY = {
    "mac_forwarding": {"forwarding"},
    "mac_learning": {"forwarding"},
    "ip_forwarding": {"forwarding"},
    "packet_filter": {"forwarding"},
    "tcp_syn_filter": {"packet_filter"},
}


def _behavior_matches(required_id: str, detected_id: str) -> bool:
    """Check if a detected behavior satisfies a required behavior.
    Exact match, or the detected behavior is a child of the required behavior.
    """
    if required_id == detected_id:
        return True
    parents = _BEHAVIOR_HIERARCHY.get(detected_id, set())
    if required_id in parents:
        return True
    # Substring containment: "mac_forwarding" contains "forwarding"
    if required_id in detected_id:
        return True
    return False


def compute_intent_match_score(expected_json: dict, actual_json: dict) -> Tuple[float, Dict[str, float]]:
    """
    Compare expected vs actual behavior and return (final_score, detailed_scores).
    Returns a match score between 0.0 and 1.0.
    """
    scores = {
        "required_behaviors": 0.0,
        "headers": 0.0,
        "control_blocks": 0.0,
        "prohibited_check": 0.0,
    }

    # 1. Required behaviors (with hierarchical matching)
    required_list = expected_json.get("required_behaviors") or []
    required = set(b.get("behavior_id") or "" for b in required_list if b)
    actual_list = actual_json.get("detected_behaviors") or []
    detected = set(_normalize_behavior_id_for_match(b.get("behavior_id") or "") for b in actual_list if b)
    if required:
        matched_count = 0
        for req_id in required:
            if any(_behavior_matches(req_id, det_id) for det_id in detected):
                matched_count += 1
        scores["required_behaviors"] = matched_count / len(required)
    else:
        scores["required_behaviors"] = 1.0

    # 2. Headers
    expected_headers = set((expected_json.get("headers_required") or []))
    actual_headers_raw = actual_json.get("headers_defined") or []
    actual_headers = set(h.replace("_t", "").replace("_", "") for h in actual_headers_raw)
    expected_normalized = set(h.replace("_", "").lower() for h in expected_headers)
    actual_normalized = set(h.replace("_", "").lower() for h in actual_headers)
    if expected_normalized:
        scores["headers"] = len(expected_normalized & actual_normalized) / len(expected_normalized)
    else:
        scores["headers"] = 1.0

    # 3. Control blocks
    control_blocks_exp = expected_json.get("control_blocks") or {}
    ingress_req = control_blocks_exp.get("ingress") or {}
    if isinstance(ingress_req, dict):
        ingress_required = ingress_req.get("required", True)
    else:
        ingress_required = True
    egress_req = control_blocks_exp.get("egress") or {}
    if isinstance(egress_req, dict):
        egress_required = egress_req.get("required", False)
    else:
        egress_required = False

    control_actual = actual_json.get("control_blocks") or {}
    ingress_actual = control_actual.get("ingress") or []
    egress_actual = control_actual.get("egress") or []
    num_required = (1 if ingress_required else 0) + (1 if egress_required else 0)
    if num_required == 0:
        scores["control_blocks"] = 1.0
    else:
        found = 0
        if ingress_required and ingress_actual:
            found += 1
        if egress_required and egress_actual:
            found += 1
        scores["control_blocks"] = found / num_required

    # 4. Prohibited behaviors
    prohibited = set(expected_json.get("prohibited_behaviors") or [])
    suspicious = set(actual_json.get("suspicious_patterns") or [])
    scores["prohibited_check"] = 1.0 if not (prohibited & suspicious) else 0.0

    # Weighted final score
    final_score = sum(scores[k] * WEIGHTS[k] for k in scores)
    return final_score, scores


def generate_intent_mismatch_feedback(
    expected_json: dict,
    actual_json: dict,
    detailed_scores: Dict[str, float],
    final_score: Optional[float] = None,
) -> dict:
    """
    Generate actionable feedback for LLM regeneration when VRF A.5 fails.
    """
    if final_score is None:
        final_score, _ = compute_intent_match_score(expected_json, actual_json)

    feedback = {
        "validation_result": "INTENT_MISMATCH",
        "match_score": final_score,
        "issues": [],
    }

    required_list = expected_json.get("required_behaviors") or []
    required = set(b.get("behavior_id") or "" for b in required_list if b)
    actual_list = actual_json.get("detected_behaviors") or []
    detected = set(_normalize_behavior_id_for_match(b.get("behavior_id") or "") for b in actual_list if b)
    missing = set(
        req_id for req_id in required
        if not any(_behavior_matches(req_id, det_id) for det_id in detected)
    )
    if missing:
        feedback["issues"].append({
            "type": "MISSING_BEHAVIOR",
            "severity": "CRITICAL",
            "details": f"Required behaviors not implemented: {list(missing)}",
            "suggestion": "Add tables and actions to implement these behaviors",
        })

    prohibited = set(expected_json.get("prohibited_behaviors") or [])
    suspicious = set(actual_json.get("suspicious_patterns") or [])
    violations = prohibited & suspicious
    if violations:
        feedback["issues"].append({
            "type": "PROHIBITED_BEHAVIOR",
            "severity": "CRITICAL",
            "details": f"Code contains prohibited patterns: {list(violations)}",
            "suggestion": "Remove or modify the following logic to avoid these patterns",
        })

    expected_headers = set(expected_json.get("headers_required") or [])
    actual_headers_raw = actual_json.get("headers_defined") or []
    actual_headers = set(h.replace("_t", "") for h in actual_headers_raw)
    missing_headers = expected_headers - actual_headers
    if missing_headers and detailed_scores.get("headers", 1.0) < 1.0:
        feedback["issues"].append({
            "type": "MISSING_HEADERS",
            "severity": "HIGH",
            "details": f"Expected headers not defined: {list(missing_headers)}",
            "suggestion": "Define and parse the required header types",
        })

    return feedback


def format_feedback_for_llm(feedback: dict) -> str:
    """Turn feedback dict into a string suitable for appending to the LLM prompt."""
    lines = [
        "[VRF A.5 Intent Validation Failed]",
        f"Match score: {feedback.get('match_score', 0):.2%}",
        "",
    ]
    for issue in feedback.get("issues") or []:
        lines.append(f"- {issue.get('type', 'ISSUE')}: {issue.get('details', '')}")
        lines.append(f"  Suggestion: {issue.get('suggestion', '')}")
    return "\n".join(lines)
