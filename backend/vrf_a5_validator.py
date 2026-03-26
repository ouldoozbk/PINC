"""
VRF A.5: Intent Validation Orchestrator.
Runs behavior extraction, semantic comparison, and returns pass/partial/fail with scores.
"""

from __future__ import annotations

import json
from typing import Optional, Tuple

from vrf_a5_behavior_extractor import extract_behavior_from_code, save_actual_behavior
from vrf_a5_semantic_comparator import (
    compute_intent_match_score,
    format_feedback_for_llm,
    generate_intent_mismatch_feedback,
)

# Thresholds from vrf-validation.md
THRESHOLD_PASS = 0.85
THRESHOLD_FAIL = 0.60


def validate_intent(
    p4_code: str,
    expected_behavior_path: str = "expected_behavior.json",
    actual_behavior_path: str = "actual_behavior.json",
    save_actual: bool = True,
    api_key: str = "",
) -> Tuple[str, float, dict, Optional[str]]:
    """
    Run VRF A.5: extract actual behavior from P4 code, compare to expected, return result.

    Returns:
        (verdict, match_score, detailed_scores, feedback_for_llm)
        - verdict: "PASS" | "PARTIAL" | "FAIL"
        - match_score: float 0.0--1.0
        - detailed_scores: dict with required_behaviors, headers, control_blocks, prohibited_check
        - feedback_for_llm: None on PASS; string to add to prompt on FAIL (and optionally PARTIAL)
    """
    try:
        with open(expected_behavior_path) as f:
            expected_json = json.load(f)
    except (FileNotFoundError, json.JSONDecodeError):
        # No expected spec: treat as pass (skip intent validation)
        return "PASS", 1.0, {}, None

    actual_json = extract_behavior_from_code(p4_code, api_key=api_key)
    if save_actual:
        save_actual_behavior(actual_json, actual_behavior_path)

    match_score, detailed_scores = compute_intent_match_score(expected_json, actual_json)

    if match_score >= THRESHOLD_PASS:
        return "PASS", match_score, detailed_scores, None
    if match_score >= THRESHOLD_FAIL:
        return "PARTIAL", match_score, detailed_scores, None
    # FAIL: generate feedback for regeneration
    feedback = generate_intent_mismatch_feedback(
        expected_json, actual_json, detailed_scores, match_score
    )
    return "FAIL", match_score, detailed_scores, format_feedback_for_llm(feedback)


def run_vrf_a5(
    p4_code: str,
    expected_behavior_path: str = "expected_behavior.json",
    actual_behavior_path: str = "actual_behavior.json",
    api_key: str = "",
) -> Tuple[bool, Optional[str], float, dict]:
    """
    Convenience: run VRF A.5 and return (passed, feedback_for_llm, score, detailed_scores).
    passed is True for PASS or PARTIAL (proceed); False for FAIL (regenerate).
    """
    verdict, score, detailed, feedback = validate_intent(
        p4_code,
        expected_behavior_path=expected_behavior_path,
        actual_behavior_path=actual_behavior_path,
        save_actual=True,
        api_key=api_key,
    )
    passed = verdict in ("PASS", "PARTIAL")
    return passed, feedback, score, detailed
