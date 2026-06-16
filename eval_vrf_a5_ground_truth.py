"""
Evaluate VRF A.5 against 12 ground-truth test cases.

For each case:
  1. Copy the ground-truth .p4 file into a temp workspace.
  2. Compile it with p4lang/p4c Docker image → generates ir.json.
  3. Generate expected_behavior.json from the intent (Claude Haiku).
  4. Run VRF A.5 (extract actual behavior + compare) → verdict + score.
  5. Compare verdict against human label.

Usage (from repo root):
    CLAUDE_API_KEY=<key> python3 eval_vrf_a5_ground_truth.py

Outputs:
    eval_vrf_a5_results.csv    — machine-readable results
    eval_vrf_a5_results.md     — human-readable report
"""

from __future__ import annotations

import csv
import json
import os
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

# ── path setup ────────────────────────────────────────────────────────────────
REPO_ROOT   = Path(__file__).parent
BACKEND_DIR = REPO_ROOT / "backend"
GT_CODE_DIR = REPO_ROOT / "code" / "ground-truth" / "code"
EVAL_CSV_IN = REPO_ROOT / "code" / "ground-truth" / "eval_labels.csv"
CSV_OUT     = REPO_ROOT / "eval_vrf_a5_results.csv"
MD_OUT      = REPO_ROOT / "eval_vrf_a5_results.md"

sys.path.insert(0, str(BACKEND_DIR))

from vrf_a5_intent_parser import generate_expected_behavior, save_expected_behavior


# ── helpers ───────────────────────────────────────────────────────────────────
def read_eval_labels(path: Path) -> list[dict]:
    with open(path, newline="") as f:
        return list(csv.DictReader(f))


def normalise_label(label: str) -> str:
    label = label.strip().lower()
    if label in ("yes", "pass"):
        return "yes"
    if label == "partial":
        return "partial"
    return "no"


def verdict_to_label(verdict: str) -> str:
    if verdict == "PASS":
        return "yes"
    if verdict == "PARTIAL":
        return "partial"
    return "no"


def agreement(vrf_label: str, human_label: str) -> str:
    if vrf_label == human_label:
        return "exact"
    if vrf_label in {"yes", "partial"} and human_label in {"yes", "partial"}:
        return "close"
    return "disagree"


def compile_p4_and_get_ir(p4_path: Path, workdir: Path) -> bool:
    """
    Copy p4_path into workdir as test.p4, compile with Docker p4lang/p4c,
    and attempt to produce ir.json via p4test --toJSON.
    Returns True if compilation succeeded (regardless of ir.json).
    """
    dst_p4 = workdir / "test.p4"
    shutil.copy(p4_path, dst_p4)

    # Step 1: compile with p4c (produces test.json / BMV2 artifact)
    compile_result = subprocess.run(
        [
            "docker", "run", "--rm", "--platform", "linux/amd64",
            "-v", f"{workdir}:/workspace", "-w", "/workspace",
            "p4lang/p4c",
            "bash", "-c",
            (
                "apt-get update -qq && "
                "apt-get install -y -qq libboost-iostreams1.71.0 2>/dev/null && "
                "p4c --target bmv2 --arch v1model test.p4"
            ),
        ],
        capture_output=True, text=True, timeout=120,
    )

    if compile_result.returncode != 0:
        return False

    # Step 2: generate ir.json via p4test --toJSON
    ir_result = subprocess.run(
        [
            "docker", "run", "--rm", "--platform", "linux/amd64",
            "-v", f"{workdir}:/workspace", "-w", "/workspace",
            "p4lang/p4c",
            "bash", "-c",
            (
                "apt-get update -qq && "
                "apt-get install -y -qq libboost-iostreams1.71.0 2>/dev/null && "
                "p4test --toJSON ir.json test.p4"
            ),
        ],
        capture_output=True, text=True, timeout=120,
    )
    if ir_result.returncode != 0:
        print(f"\n    [p4test stderr]: {ir_result.stderr[-500:].strip()}")
    return True


# ── main evaluation loop ──────────────────────────────────────────────────────
def main():
    api_key = (
        os.getenv("CLAUDE_API_KEY")
        or os.getenv("ANTHROPIC_API_KEY")
        or ""
    )
    if not api_key:
        print("ERROR: Set CLAUDE_API_KEY or ANTHROPIC_API_KEY before running.")
        sys.exit(1)

    cases = read_eval_labels(EVAL_CSV_IN)
    results = []

    for case in cases:
        case_id    = case["id"].strip()
        bucket     = case["bucket"].strip()
        intent     = case["intent"].strip()
        human_lbl  = normalise_label(case.get("your_label", ""))

        p4_path = GT_CODE_DIR / f"{case_id}.p4"
        if not p4_path.exists():
            print(f"  [SKIP] {case_id}.p4 not found")
            continue

        p4_code = p4_path.read_text()
        print(f"\n[{case_id}] {intent[:70]}...")

        with tempfile.TemporaryDirectory() as tmpdir:
            tmpdir_path   = Path(tmpdir)
            expected_path = str(tmpdir_path / "expected_behavior.json")
            actual_path   = str(tmpdir_path / "actual_behavior.json")
            ir_path       = str(tmpdir_path / "ir.json")

            # 1. Compile P4 → generates ir.json in tmpdir
            print(f"  Compiling {case_id}.p4 via Docker…", end=" ", flush=True)
            compiled = compile_p4_and_get_ir(p4_path, tmpdir_path)
            if compiled:
                ir_exists = (tmpdir_path / "ir.json").exists()
                print(f"✓  (ir.json={'yes' if ir_exists else 'no'})")
            else:
                print("✗  (compile failed)")
                ir_exists = False

            # 2. Generate expected behavior from intent
            expected_json = generate_expected_behavior(intent, api_key=api_key)
            save_expected_behavior(expected_json, expected_path)
            matched_buckets = expected_json.get("buckets", [])
            print(f"  Expected buckets → {matched_buckets}")

            # 3. Run VRF A.5 — pass ir_path so extractor can use it
            from vrf_a5_behavior_extractor import extract_behavior_from_code, save_actual_behavior
            from vrf_a5_semantic_comparator import compute_intent_match_score

            try:
                actual_json = extract_behavior_from_code(
                    p4_code, ir_path=ir_path, api_key=api_key
                )
                save_actual_behavior(actual_json, actual_path)

                with open(expected_path) as f:
                    exp = json.load(f)

                match_score, detailed = compute_intent_match_score(exp, actual_json)

                THRESHOLD_PASS = 0.85
                THRESHOLD_FAIL = 0.60
                if match_score >= THRESHOLD_PASS:
                    verdict = "PASS"
                elif match_score >= THRESHOLD_FAIL:
                    verdict = "PARTIAL"
                else:
                    verdict = "FAIL"

                actual_buckets = actual_json.get("buckets", [])

            except Exception as exc:
                print(f"  ERROR in VRF A.5: {exc}")
                verdict, match_score, detailed = "ERROR", 0.0, {}
                actual_buckets = []

        vrf_label = verdict_to_label(verdict)
        agree     = agreement(vrf_label, human_lbl)

        print(
            f"  verdict={verdict}  score={match_score:.2%}  "
            f"actual_buckets={actual_buckets}  human={human_lbl}  → {agree}"
        )

        results.append({
            "id":                   case_id,
            "bucket":               bucket,
            "intent":               intent,
            "human_label":          human_lbl,
            "compiled":             "yes" if compiled else "no",
            "ir_json":              "yes" if ir_exists else "no",
            "expected_buckets":     ", ".join(matched_buckets),
            "actual_buckets":       ", ".join(actual_buckets),
            "vrf_a5_verdict":       verdict,
            "vrf_a5_score":         round(match_score, 4),
            "score_bucket_recall":      round(detailed.get("bucket_recall", 0), 4),
            "score_header_similarity":  round(detailed.get("header_similarity", 0), 4),
            "score_control_blocks":     round(detailed.get("control_blocks", 0), 4),
            "score_prohibited":         round(detailed.get("prohibited_check", 0), 4),
            "agreement":            agree,
        })

    # ── write CSV ──────────────────────────────────────────────────────────────
    fieldnames = [
        "id", "bucket", "intent", "human_label",
        "compiled", "ir_json", "expected_buckets", "actual_buckets",
        "vrf_a5_verdict", "vrf_a5_score",
        "score_bucket_recall", "score_header_similarity",
        "score_control_blocks", "score_prohibited",
        "agreement",
    ]
    with open(CSV_OUT, "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=fieldnames)
        w.writeheader()
        w.writerows(results)
    print(f"\nWrote {CSV_OUT}")

    # ── write Markdown ─────────────────────────────────────────────────────────
    n        = len(results)
    exact    = sum(1 for r in results if r["agreement"] == "exact")
    close    = sum(1 for r in results if r["agreement"] == "close")
    disagree = sum(1 for r in results if r["agreement"] == "disagree")
    avg_score = sum(r["vrf_a5_score"] for r in results) / n if n else 0
    compiled_count = sum(1 for r in results if r["compiled"] == "yes")
    ir_count = sum(1 for r in results if r["ir_json"] == "yes")

    md_lines = [
        "# VRF A.5 Ground-Truth Evaluation",
        "",
        f"**Test cases:** {n}  |  "
        f"**Compiled:** {compiled_count}/{n}  |  "
        f"**IR JSON:** {ir_count}/{n}  |  "
        f"**Avg score:** {avg_score:.2%}",
        "",
        f"**Exact match:** {exact}/{n}  |  "
        f"**Close:** {close}/{n}  |  "
        f"**Disagree:** {disagree}/{n}",
        "",
        "## Per-Case Results",
        "",
        "| ID | Bucket | Intent (truncated) | Human | VRF A.5 | Score | Expected Buckets | Actual Buckets | Agreement |",
        "|----|--------|--------------------|-------|---------|-------|------------------|----------------|-----------|",
    ]
    for r in results:
        intent_short = r["intent"][:45] + ("…" if len(r["intent"]) > 45 else "")
        md_lines.append(
            f"| {r['id']} | {r['bucket']} | {intent_short} "
            f"| {r['human_label']} | {r['vrf_a5_verdict']} "
            f"| {r['vrf_a5_score']:.2%} "
            f"| {r['expected_buckets']} "
            f"| {r['actual_buckets']} "
            f"| **{r['agreement']}** |"
        )

    md_lines += [
        "",
        "## Detailed Scores",
        "",
        "| ID | Intent (truncated) | Compiled | IR | Bucket Recall | Header Similarity | Control Blocks | Prohibited |",
        "|----|-------------------|----------|----|---------------|-------------------|----------------|------------|",
    ]
    for r in results:
        intent_short = r["intent"][:35] + ("…" if len(r["intent"]) > 35 else "")
        md_lines.append(
            f"| {r['id']} | {intent_short} "
            f"| {r['compiled']} | {r['ir_json']} "
            f"| {r['score_bucket_recall']:.2%} "
            f"| {r['score_header_similarity']:.2%} "
            f"| {r['score_control_blocks']:.2%} "
            f"| {r['score_prohibited']:.2%} |"
        )

    md_lines += [
        "",
        "## Summary",
        "",
        f"- Test cases evaluated: **{n}**",
        f"- Successfully compiled: **{compiled_count}/{n}**",
        f"- IR JSON generated (enables full bucket classification): **{ir_count}/{n}**",
        f"- Exact agreement (human label = VRF A.5 label): **{exact}/{n}** ({exact/n:.0%})",
        f"- Close agreement (both positive): **{close}/{n}** ({close/n:.0%})",
        f"- Disagreement: **{disagree}/{n}** ({disagree/n:.0%})",
        f"- Average VRF A.5 score: **{avg_score:.2%}**",
    ]

    MD_OUT.write_text("\n".join(md_lines) + "\n")
    print(f"Wrote {MD_OUT}")


if __name__ == "__main__":
    main()
