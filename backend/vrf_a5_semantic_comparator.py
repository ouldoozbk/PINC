"""
VRF A.5: Semantic Comparator — Compare expected vs actual behavior JSON and compute match score.

Scoring is a weighted combination of four components:

  bucket_recall          (0.70) — Recall-based: what fraction of expected buckets appear in the
                                   actual code buckets?  Primary driver now that LLM classifier
                                   (claude-haiku-4-5-20251001) reliably classifies code buckets.
                                   Recall rather than Jaccard because code legitimately implements
                                   extra buckets (e.g. error_detection from a checksum block).

  header_similarity      (0.10) — Normalized edit distance (NED via difflib.SequenceMatcher)
                                   between the sorted expected header list and the sorted actual
                                   header list.  Measures protocol-stack structural match.

  control_blocks         (0.10) — Whether the required ingress/egress control blocks are present.

  prohibited_check       (0.10) — Hard penalty if the code contains any prohibited behavior
                                   patterns named in the intent spec.
"""

from __future__ import annotations

import difflib
from typing import Dict, Optional, Set, Tuple

# Weights (must sum to 1.0)
WEIGHTS: Dict[str, float] = {
    "bucket_recall":    0.70,
    "header_similarity": 0.10,
    "control_blocks":   0.10,
    "prohibited_check": 0.10,
}


# Helpers
def _header_string(headers) -> str:
    """Canonical sorted, lowercased, comma-joined header string for NED comparison."""
    return ", ".join(sorted(h.lower() for h in (headers or [])))


def _ned_similarity(a: str, b: str) -> float:
    """
    Normalized edit distance via difflib.SequenceMatcher.
    Returns 1.0 when both strings are empty (both have no headers — full match).
    """
    if not a and not b:
        return 1.0
    return difflib.SequenceMatcher(None, a, b).ratio()


# Scoring
def compute_intent_match_score(
    expected_json: dict,
    actual_json: dict,
) -> Tuple[float, Dict[str, float]]:
    """
    Compare expected vs actual behavior and return (final_score, detailed_scores).
    Score is in [0.0, 1.0]; higher is better.
    """
    scores: Dict[str, float] = {k: 0.0 for k in WEIGHTS}

    # 1. Bucket recall
    #    Recall = |expected ∩ actual| / |expected|
    #    A superset actual (code does more than asked) does not penalize.
    expected_buckets: Set[str] = set(expected_json.get("buckets") or [])
    expected_has_bucket_key = "buckets" in expected_json

    # Fallback: derive expected bucket set from required_behaviors behavior_ids
    # (covers old expected_behavior.json files that predate the router).
    if not expected_buckets:
        expected_buckets = set(
            b.get("behavior_id", "")
            for b in (expected_json.get("required_behaviors") or [])
            if b
        )

    actual_buckets: Set[str] = set(actual_json.get("buckets") or [])

    # Fallback: derive actual bucket set from detected_behaviors behavior_ids.
    if not actual_buckets:
        actual_buckets = set(
            b.get("behavior_id", "")
            for b in (actual_json.get("detected_behaviors") or [])
            if b
        )

    if expected_buckets:
        covered = len(expected_buckets & actual_buckets)
        scores["bucket_recall"] = covered / len(expected_buckets)
    else:
        scores["bucket_recall"] = 0.0 if expected_has_bucket_key else 0.0

    # 3. Header similarity — NED on sorted header sets
    expected_headers = _header_string(expected_json.get("headers_required", []))
    actual_headers   = _header_string(actual_json.get("headers_defined", []))
    scores["header_similarity"] = _ned_similarity(expected_headers, actual_headers)

    # 4. Control blocks
    control_blocks_exp = expected_json.get("control_blocks") or {}

    ingress_spec = control_blocks_exp.get("ingress") or {}
    ingress_required = (
        ingress_spec.get("required", True)
        if isinstance(ingress_spec, dict)
        else True
    )
    egress_spec = control_blocks_exp.get("egress") or {}
    egress_required = (
        egress_spec.get("required", False)
        if isinstance(egress_spec, dict)
        else False
    )

    control_actual = actual_json.get("control_blocks") or {}
    ingress_actual = control_actual.get("ingress") or []
    egress_actual  = control_actual.get("egress")  or []

    num_required = (1 if ingress_required else 0) + (1 if egress_required else 0)
    if num_required == 0:
        scores["control_blocks"] = 1.0
    else:
        found = (
            (1 if ingress_required and ingress_actual else 0)
            + (1 if egress_required and egress_actual else 0)
        )
        scores["control_blocks"] = found / num_required

    # 5. Prohibited behaviors — hard penalty
    prohibited = set(expected_json.get("prohibited_behaviors") or [])
    suspicious  = set(actual_json.get("suspicious_patterns")   or [])
    scores["prohibited_check"] = 0.0 if (prohibited & suspicious) else 1.0

    # Weighted final score
    final_score = sum(scores[k] * WEIGHTS[k] for k in scores)
    return final_score, scores


# Feedback generation
def generate_intent_mismatch_feedback(
    expected_json: dict,
    actual_json: dict,
    final_score: Optional[float] = None,
) -> dict:
    """
    Generate actionable feedback for LLM regeneration when VRF A.5 fails.
    """
    if final_score is None:
        final_score, _ = compute_intent_match_score(expected_json, actual_json)

    feedback: dict = {
        "validation_result": "INTENT_MISMATCH",
        "match_score": final_score,
        "issues": [],
    }

    # Missing buckets
    expected_buckets: Set[str] = set(expected_json.get("buckets") or [])
    if not expected_buckets:
        expected_buckets = set(
            b.get("behavior_id", "")
            for b in (expected_json.get("required_behaviors") or [])
            if b
        )
    actual_buckets: Set[str] = set(actual_json.get("buckets") or [])
    if not actual_buckets:
        actual_buckets = set(
            b.get("behavior_id", "")
            for b in (actual_json.get("detected_behaviors") or [])
            if b
        )
    missing_buckets = expected_buckets - actual_buckets
    if missing_buckets:
        feedback["issues"].append({
            "type": "MISSING_BUCKET",
            "severity": "CRITICAL",
            "details": f"Expected behavior buckets not detected in code: {sorted(missing_buckets)}",
            "suggestion": (
                "Add the tables, actions, or extern calls that implement the missing behavior. "
                "See the 9-bucket taxonomy for concrete P4 signal requirements."
            ),
        })

    # Prohibited violations
    prohibited = set(expected_json.get("prohibited_behaviors") or [])
    suspicious  = set(actual_json.get("suspicious_patterns")   or [])
    violations  = prohibited & suspicious
    if violations:
        feedback["issues"].append({
            "type": "PROHIBITED_BEHAVIOR",
            "severity": "CRITICAL",
            "details": f"Code contains prohibited patterns: {sorted(violations)}",
            "suggestion": "Remove or modify the logic that triggers these patterns.",
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
