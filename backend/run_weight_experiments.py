"""
Weight Experiment Runner — VRF A.5 scoring over the full compiled JSONL corpus.

Usage:
    python run_weight_experiments.py [--limit N] [--api-key KEY] [--force]

Flags:
    --limit N      Process only the first N records (default: all 405).
    --api-key KEY  Anthropic API key for LLM bucket classifier.
    --force        Ignore cached ir.json / behavior JSONs and regenerate.

Cache:
    experiment_cache/<index>/
        test.p4               — cleaned P4 source
        ir.json               — p4c JSON IR (from p4test --toJSON)
        expected_behavior.json — generated from annotation
        actual_behavior.json  — extracted from ir.json

    Re-runs skip Docker if ir.json exists, skip parsers if JSONs exist.
    Scoring is always recomputed (instant).

Output:
    Per-case progress line + final summary table.
"""

from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import Dict, Optional, Set, Tuple

import difflib

# Add backend/ to path so we can import existing modules.
BACKEND_DIR = Path(__file__).parent
sys.path.insert(0, str(BACKEND_DIR))

from vrf_a5_intent_parser import generate_expected_behavior, save_expected_behavior
from vrf_a5_behavior_extractor import extract_behavior_from_code, save_actual_behavior

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
JSONL_PATH = (
    BACKEND_DIR.parent
    / "dataset"
    / "p4gcc"
    / "data"
    / "FINAL_p4_ds_clean_comments.jsonl"
)
CACHE_ROOT = BACKEND_DIR / "experiment_cache"

# ---------------------------------------------------------------------------
# Weight configurations
# ---------------------------------------------------------------------------
WEIGHTS: Dict[str, float] = {
    "bucket_recall":    0.70,
    "header_similarity": 0.10,
    "control_blocks":   0.10,
    "prohibited_check": 0.10,
}

CONFIGS: Dict[str, Dict[str, float]] = {
    "Production": WEIGHTS,
}

THRESHOLD_PASS = 0.85


# ---------------------------------------------------------------------------
# Scoring (self-contained — does not use module-level WEIGHTS)
# ---------------------------------------------------------------------------

def _header_string(headers) -> str:
    return ", ".join(sorted(h.lower() for h in (headers or [])))


def _ned_similarity(a: str, b: str) -> float:
    if not a and not b:
        return 1.0
    return difflib.SequenceMatcher(None, a, b).ratio()


def _score(expected: dict, actual: dict, weights: Dict[str, float]) -> Tuple[float, dict]:
    """Compute weighted match score with an arbitrary weight dict."""
    scores: Dict[str, float] = {k: 0.0 for k in weights}

    # 1. Bucket recall
    exp_buckets: Set[str] = set(expected.get("buckets") or [])
    if not exp_buckets:
        exp_buckets = {
            b.get("behavior_id", "")
            for b in (expected.get("required_behaviors") or [])
            if b
        }
    act_buckets: Set[str] = set(actual.get("buckets") or [])
    if not act_buckets:
        act_buckets = {
            b.get("behavior_id", "")
            for b in (actual.get("detected_behaviors") or [])
            if b
        }
    if "bucket_recall" in scores:
        if exp_buckets:
            scores["bucket_recall"] = len(exp_buckets & act_buckets) / len(exp_buckets)

    # 3. Header similarity
    if "header_similarity" in scores:
        scores["header_similarity"] = _ned_similarity(
            _header_string(expected.get("headers_required", [])),
            _header_string(actual.get("headers_defined", [])),
        )

    # 4. Control blocks
    if "control_blocks" in scores:
        cb_exp = expected.get("control_blocks") or {}
        ing_spec = cb_exp.get("ingress") or {}
        ing_req = ing_spec.get("required", True) if isinstance(ing_spec, dict) else True
        eg_spec  = cb_exp.get("egress") or {}
        eg_req   = eg_spec.get("required", False) if isinstance(eg_spec, dict) else False
        cb_act = actual.get("control_blocks") or {}
        num_req = (1 if ing_req else 0) + (1 if eg_req else 0)
        if num_req == 0:
            scores["control_blocks"] = 1.0
        else:
            found = (
                (1 if ing_req and cb_act.get("ingress") else 0)
                + (1 if eg_req  and cb_act.get("egress")  else 0)
            )
            scores["control_blocks"] = found / num_req

    # 5. Prohibited check
    if "prohibited_check" in scores:
        prohibited = set(expected.get("prohibited_behaviors") or [])
        suspicious  = set(actual.get("suspicious_patterns") or [])
        scores["prohibited_check"] = 0.0 if (prohibited & suspicious) else 1.0

    final = sum(scores[k] * weights[k] for k in scores)
    return final, scores


# ---------------------------------------------------------------------------
# Docker — generate ir.json via p4test --toJSON
# ---------------------------------------------------------------------------

def _run_p4test_toJSON(case_dir: Path, p4_file: str = "test.p4") -> bool:
    """
    Run p4test --toJSON ir.json inside case_dir via Docker.
    Mirrors the command used in vrf_a_compile.sh.
    Returns True on success (ir.json written), False on failure.
    """
    cmd = [
        "docker", "run", "--rm", "--platform", "linux/amd64",
        "-v", f"{case_dir}:/workspace",
        "-w", "/workspace",
        "p4lang/p4c",
        "bash", "-c",
        (
            "apt-get update -qq 2>/dev/null && "
            "apt-get install -y -qq libboost-iostreams1.71.0 2>/dev/null; "
            f"p4test --toJSON ir.json {p4_file}"
        ),
    ]
    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=120,
        )
        return (case_dir / "ir.json").exists()
    except subprocess.TimeoutExpired:
        print("  [WARN] Docker timed out", flush=True)
        return False
    except Exception as exc:
        print(f"  [WARN] Docker error: {exc}", flush=True)
        return False


# ---------------------------------------------------------------------------
# Per-case processing
# ---------------------------------------------------------------------------

def process_case(
    idx: int,
    record: dict,
    force: bool,
    api_key: str,
) -> Optional[dict]:
    """
    Process one JSONL record.  Returns a result dict or None if unrecoverable.
    """
    annotation  = (record.get("annotation") or "").strip()
    cleaned_p4  = (record.get("cleaned_p4") or "").strip()
    if not annotation or not cleaned_p4:
        return None

    case_dir = CACHE_ROOT / str(idx)
    case_dir.mkdir(parents=True, exist_ok=True)

    p4_path       = case_dir / "test.p4"
    ir_path       = case_dir / "ir.json"
    expected_path = case_dir / "expected_behavior.json"
    actual_path   = case_dir / "actual_behavior.json"

    # 1. Write P4 source (always — cheap, ensures cache is consistent)
    p4_path.write_text(cleaned_p4, encoding="utf-8")

    # 2. Generate ir.json via Docker (cached)
    if force or not ir_path.exists():
        ok = _run_p4test_toJSON(case_dir)
        if not ok:
            return {"idx": idx, "annotation": annotation, "error": "ir.json generation failed"}
    else:
        pass  # cached

    # 3. Expected behavior (cached)
    if force or not expected_path.exists():
        exp = generate_expected_behavior(annotation, api_key=api_key)
        save_expected_behavior(exp, str(expected_path))
    else:
        with expected_path.open() as f:
            exp = json.load(f)

    # 4. Actual behavior (cached)
    if force or not actual_path.exists():
        act = extract_behavior_from_code(
            cleaned_p4,
            ir_path=str(ir_path),
            api_key=api_key,
        )
        save_actual_behavior(act, str(actual_path))
    else:
        with actual_path.open() as f:
            act = json.load(f)

    # 5. Score under all configs
    config_scores: Dict[str, Tuple[float, dict]] = {}
    for cfg_name, weights in CONFIGS.items():
        final, detail = _score(exp, act, weights)
        config_scores[cfg_name] = (final, detail)

    exp_buckets: Set[str] = set(exp.get("buckets") or [])
    act_buckets: Set[str] = set(act.get("buckets") or [])
    bucket_recall = (
        len(exp_buckets & act_buckets) / len(exp_buckets) if exp_buckets else 0.0
    )

    return {
        "idx": idx,
        "annotation": annotation,
        "exp_buckets": sorted(exp_buckets),
        "act_buckets": sorted(act_buckets),
        "bucket_recall": bucket_recall,
        "config_scores": {k: v[0] for k, v in config_scores.items()},
    }


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(description="VRF A.5 weight experiment runner")
    parser.add_argument("--limit", type=int, default=0,
                        help="Max records to process (0 = all)")
    parser.add_argument(
        "--api-key", default="",
        help="Anthropic API key (falls back to CLAUDE_API_KEY / ANTHROPIC_API_KEY env vars)",
    )
    parser.add_argument("--force", action="store_true",
                        help="Ignore cache and regenerate ir.json + behavior JSONs")
    args = parser.parse_args()

    api_key = (
        args.api_key
        or os.environ.get("CLAUDE_API_KEY", "")
        or os.environ.get("ANTHROPIC_API_KEY", "")
    )
    args.api_key = api_key  # normalise so process_case sees the resolved key

    # Load JSONL
    records = []
    with JSONL_PATH.open(encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line:
                records.append(json.loads(line))

    limit = args.limit if args.limit > 0 else len(records)
    records = records[:limit]
    print(f"Running weight experiments on {len(records)} records.", flush=True)
    print(f"Cache: {CACHE_ROOT}", flush=True)
    print(flush=True)

    results = []
    errors  = 0

    for i, record in enumerate(records, start=1):
        annotation_short = (record.get("annotation") or "")[:60]
        print(f"[{i:3d}/{len(records)}] {annotation_short!r}", end=" ", flush=True)

        res = process_case(i, record, force=args.force, api_key=args.api_key)
        if res is None or "error" in res:
            err = res.get("error", "skipped") if res else "missing annotation/code"
            print(f"  ERROR: {err}", flush=True)
            errors += 1
            continue

        cfg_str = "  ".join(
            f"{cfg}={res['config_scores'][cfg]:.3f}({'P' if res['config_scores'][cfg] >= THRESHOLD_PASS else 'f'})"
            for cfg in CONFIGS
        )
        print(f"recall={res['bucket_recall']:.2f}  {cfg_str}", flush=True)
        results.append(res)

    # Summary table
    print(flush=True)
    print("=" * 72, flush=True)
    print("SUMMARY", flush=True)
    print("=" * 72, flush=True)
    print(f"Processed: {len(results)}  Errors/skipped: {errors}", flush=True)
    print(flush=True)

    cfg_names = list(CONFIGS.keys())
    header = f"{'Config':<16} | {'Pass':>6} | {'Pass%':>6} | {'Avg score':>10}"
    print(header, flush=True)
    print("-" * len(header), flush=True)

    for cfg in cfg_names:
        passes = sum(1 for r in results if r["config_scores"][cfg] >= THRESHOLD_PASS)
        avg    = sum(r["config_scores"][cfg] for r in results) / len(results) if results else 0.0
        print(
            f"{cfg:<16} | {passes:>6} | {passes/len(results)*100:>5.1f}% | {avg:>10.4f}",
            flush=True,
        )

    print(flush=True)
    print("Failures:", flush=True)
    failures = [r for r in results if r["config_scores"]["Production"] < THRESHOLD_PASS]
    for r in failures:
        print(
            f"  [{r['idx']:3d}] recall={r['bucket_recall']:.2f}  "
            f"score={r['config_scores']['Production']:.3f}  "
            f"{r['annotation'][:50]!r}",
            flush=True,
        )
    if not failures:
        print("  (none)", flush=True)


if __name__ == "__main__":
    main()
