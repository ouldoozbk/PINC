"""
VRF A.5: Semantic Comparator — Compare expected vs actual behavior JSON and compute match score.

Scoring is a weighted combination of four components:

  bucket_recall    (0.50) — Recall-based: what fraction of expected buckets appear in the
                            actual code buckets?  Recall rather than Jaccard because code
                            legitimately implements extra buckets (e.g. error_detection from
                            a standard checksum block) that the intent never mentioned.

  edit_distance    (0.15) — Normalized Damerau-Levenshtein similarity applied ONLY to the
                            canonical sorted string of concrete header identifiers (e.g.
                            "ethernet,ipv4,tcp").

  control_blocks   (0.10) — Whether the required ingress/egress control blocks are present.

  prohibited_check (0.25) — Hard penalty if the code contains any prohibited behavior patterns
                            named in the intent spec. Weighted higher than a soft mismatch
                            because prohibited violations are security-critical.
"""

from __future__ import annotations

from typing import Dict, Iterable, Optional, Set, Tuple


# Weights (must sum to 1.0)
WEIGHTS: Dict[str, float] = {
    "bucket_recall":    0.50,
    "edit_distance":    0.15,
    "control_blocks":   0.10,
    "prohibited_check": 0.25,
}


# Normalized Damerau-Levenshtein (pure Python, no extra dependencies)
# Uses the Optimal String Alignment variant.
def _damerau_levenshtein(s1: str, s2: str) -> int:
    """
    Compute the Damerau-Levenshtein (OSA) edit distance between two strings.
    Considers insertions, deletions, substitutions, and adjacent transpositions.
    """
    len1, len2 = len(s1), len(s2)
    if len1 == 0:
        return len2
    if len2 == 0:
        return len1

    dp = [[0] * (len2 + 1) for _ in range(len1 + 1)]
    for i in range(len1 + 1):
        dp[i][0] = i
    for j in range(len2 + 1):
        dp[0][j] = j

    for i in range(1, len1 + 1):
        for j in range(1, len2 + 1):
            cost = 0 if s1[i - 1] == s2[j - 1] else 1
            dp[i][j] = min(
                dp[i - 1][j] + 1,           # deletion
                dp[i][j - 1] + 1,           # insertion
                dp[i - 1][j - 1] + cost,    # substitution
            )
            # Transposition of adjacent characters
            if i > 1 and j > 1 and s1[i - 1] == s2[j - 2] and s1[i - 2] == s2[j - 1]:
                dp[i][j] = min(dp[i][j], dp[i - 2][j - 2] + cost)

    return dp[len1][len2]


def _ned_similarity(s1: str, s2: str) -> float:
    """
    Normalized edit distance similarity in [0, 1]:
        similarity = 1 - DL(s1, s2) / max(|s1|, |s2|)
    Returns 1.0 when both strings are empty (nothing to differ on).
    """
    if not s1 and not s2:
        return 1.0
    denom = max(len(s1), len(s2))
    return 1.0 - _damerau_levenshtein(s1, s2) / denom


# Canonical string builder for concrete sensitive fields
def _canonical_header_string(headers: Iterable[str]) -> str:
    """
    Produce a stable, comparable string from a collection of header identifiers.
    Strips common suffixes (_t) and all underscores, lowercases, sorts, then joins.

    Example:
        ["ipv4_t", "Ethernet_T", "vlan_tag_t"]  →  "ethernet,ipv4,vlantag"
    """
    normalized = sorted(
        h.lower().replace("_t", "").replace("_", "")
        for h in headers
        if h
    )
    return ",".join(normalized)


# Scoring
def compute_intent_match_score(
    expected_json: dict,
    actual_json: dict,
) -> Tuple[float, Dict[str, float]]:
    """
    Compare expected vs actual behavior and return (final_score, detailed_scores).
    Score is in [0.0, 1.0]; higher is better.

    Reads the *buckets* field (list of 9-taxonomy bucket names) from both JSONs.
    Falls back gracefully to *required_behaviors* behavior_ids if the buckets
    field is absent (backward compatibility with pre-router expected specs).
    """
    scores: Dict[str, float] = {
        "bucket_recall":    0.0,
        "edit_distance":    0.0,
        "control_blocks":   0.0,
        "prohibited_check": 0.0,
    }

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
        # If the expected spec has no declared bucket signal, do not grant
        # perfect recall by default; this avoids silent false-positives.
        scores["bucket_recall"] = 0.0 if expected_has_bucket_key else 0.0

    # 2. Edit distance on concrete header identifiers
    #    Applied ONLY to these enumerable tokens, not to bucket names,
    #    because bucket classification can legitimately diverge between
    #    NLP intent routing and AST code extraction.
    expected_hdrs = expected_json.get("headers_required") or []
    actual_hdrs   = actual_json.get("headers_defined")    or []

    exp_canonical = _canonical_header_string(expected_hdrs)
    act_canonical = _canonical_header_string(actual_hdrs)
    scores["edit_distance"] = _ned_similarity(exp_canonical, act_canonical)

    # 3. Control blocks
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

    # 4. Prohibited behaviors — hard penalty
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
    detailed_scores: Dict[str, float],
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

    # Header mismatch — also report the edit distance for transparency
    expected_hdrs = set(expected_json.get("headers_required") or [])
    actual_hdrs_raw = actual_json.get("headers_defined") or []
    actual_hdrs = set(h.replace("_t", "") for h in actual_hdrs_raw)
    missing_headers = expected_hdrs - actual_hdrs
    ed_score = detailed_scores.get("edit_distance", 1.0)
    if missing_headers and ed_score < 1.0:
        feedback["issues"].append({
            "type": "MISSING_HEADERS",
            "severity": "HIGH",
            "details": (
                f"Expected headers not defined: {sorted(missing_headers)}  "
                f"(header edit-distance similarity: {ed_score:.2%})"
            ),
            "suggestion": "Define and parse the required header types in the parser.",
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
