"""
PINC API Server — Flask backend that exposes the pipeline as REST endpoints.

Endpoints:
  POST /api/run-pipeline      Run full pipeline (intent → P4 code → VRF A → VRF A.5)
  POST /api/parse-intent      Convert intent text → expected_behavior.json
  POST /api/extract-behavior  Extract actual_behavior.json from P4 code
  POST /api/compare           Compare expected vs actual behavior
  POST /api/compile           Compile P4 code only (VRF A)
  POST /api/validate-intent   Run VRF A.5 only (intent validation)
  GET  /api/files/<name>      Retrieve generated files
"""

import json
import os
import sys
import threading
import time
import uuid
from datetime import datetime, timezone

from flask import Flask, jsonify, request, send_file
from flask_cors import CORS

# Ensure local modules are importable
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from vrf_a_compiler import clean_p4_code, validate_p4_compilation, read_error_summary
from vrf_a5_intent_parser import generate_expected_behavior, save_expected_behavior
from vrf_a5_behavior_extractor import extract_behavior_from_code, save_actual_behavior
from vrf_a5_semantic_comparator import compute_intent_match_score, generate_intent_mismatch_feedback, format_feedback_for_llm
from vrf_a5_validator import run_vrf_a5, validate_intent

app = Flask(__name__)
CORS(app)

# ---------------------------------------------------------------------------
# Pipeline state (in-memory, single-user demo)
# ---------------------------------------------------------------------------
pipeline_state = {
    "running": False,
    "attempt": 0,
    "max_attempts": 10,
    "status": "idle",          # idle | running | success | failed
    "stage": "",               # "" | generating | vrf_a | vrf_a5 | done
    "logs": [],
    "result": None,
    "expected_behavior": None,
    "actual_behavior": None,
    "p4_code": None,
    "vrf_a_result": None,
    "vrf_a5_result": None,
    "error": None,
}

def _reset_state():
    pipeline_state.update({
        "running": False,
        "attempt": 0,
        "status": "idle",
        "stage": "",
        "logs": [],
        "result": None,
        "expected_behavior": None,
        "actual_behavior": None,
        "p4_code": None,
        "vrf_a_result": None,
        "vrf_a5_result": None,
        "error": None,
    })


def _log(msg):
    pipeline_state["logs"].append({
        "time": datetime.now(timezone.utc).isoformat(),
        "message": msg,
    })


# ---------------------------------------------------------------------------
# API Endpoints
# ---------------------------------------------------------------------------

@app.route("/api/parse-intent", methods=["POST"])
def api_parse_intent():
    """Convert natural language intent → expected_behavior.json."""
    data = request.get_json(force=True)
    intent = data.get("intent", "").strip()
    if not intent:
        return jsonify({"error": "intent is required"}), 400

    expected = generate_expected_behavior(intent)
    return jsonify({"expected_behavior": expected})


@app.route("/api/extract-behavior", methods=["POST"])
def api_extract_behavior():
    """Extract actual_behavior.json from P4 source code."""
    data = request.get_json(force=True)
    p4_code = data.get("p4_code", "").strip()
    if not p4_code:
        return jsonify({"error": "p4_code is required"}), 400

    actual = extract_behavior_from_code(p4_code)
    return jsonify({"actual_behavior": actual})


@app.route("/api/compare", methods=["POST"])
def api_compare():
    """Compare expected_behavior vs actual_behavior and return scores."""
    data = request.get_json(force=True)
    expected = data.get("expected_behavior")
    actual = data.get("actual_behavior")
    if not expected or not actual:
        return jsonify({"error": "Both expected_behavior and actual_behavior are required"}), 400

    score, detailed = compute_intent_match_score(expected, actual)
    feedback = None
    if score < 0.60:
        fb = generate_intent_mismatch_feedback(expected, actual, detailed, score)
        feedback = format_feedback_for_llm(fb)

    return jsonify({
        "match_score": score,
        "detailed_scores": detailed,
        "feedback": feedback,
    })


@app.route("/api/compile", methods=["POST"])
def api_compile():
    """Run VRF A: clean P4 code and compile via Docker p4c."""
    data = request.get_json(force=True)
    p4_code = data.get("p4_code", "").strip()
    if not p4_code:
        return jsonify({"error": "p4_code is required"}), 400

    cleaned = clean_p4_code(p4_code)
    with open("test.p4", "w") as f:
        f.write(cleaned)

    success, errors = validate_p4_compilation(cleaned, "test.p4", attempt=1)
    return jsonify({
        "success": success,
        "cleaned_code": cleaned,
        "errors": errors,
    })


@app.route("/api/validate-intent", methods=["POST"])
def api_validate_intent():
    """Run VRF A.5 only: compare P4 code against expected_behavior.json."""
    data = request.get_json(force=True)
    p4_code = data.get("p4_code", "").strip()
    expected = data.get("expected_behavior")
    if not p4_code:
        return jsonify({"error": "p4_code is required"}), 400

    # Save expected if provided
    if expected:
        save_expected_behavior(expected, "expected_behavior.json")

    passed, feedback, score, detailed = run_vrf_a5(
        p4_code,
        expected_behavior_path="expected_behavior.json",
        actual_behavior_path="actual_behavior.json",
    )

    # Read actual behavior back
    actual = None
    try:
        with open("actual_behavior.json") as f:
            actual = json.load(f)
    except Exception:
        pass

    return jsonify({
        "passed": passed,
        "match_score": score,
        "detailed_scores": detailed,
        "feedback": feedback,
        "actual_behavior": actual,
    })


@app.route("/api/run-pipeline", methods=["POST"])
def api_run_pipeline():
    """Start the full pipeline in a background thread."""
    if pipeline_state["running"]:
        return jsonify({"error": "Pipeline is already running"}), 409

    data = request.get_json(force=True)
    intent = data.get("intent", "").strip()
    yang_model = data.get("yang_model", "").strip() or None
    yang_data = data.get("yang_data", "").strip() or None
    api_key = data.get("api_key", "").strip()
    provider = data.get("provider", "replicate")  # "replicate" or "openai"
    max_attempts = int(data.get("max_attempts", 10))

    if not intent:
        return jsonify({"error": "intent is required"}), 400
    if not api_key:
        return jsonify({"error": "api_key is required"}), 400

    # Set environment variable for the chosen provider
    if provider == "openai":
        os.environ["OPENAI_API_KEY"] = api_key
        os.environ.pop("REPLICATE_API_TOKEN", None)
    else:
        os.environ["REPLICATE_API_TOKEN"] = api_key
        os.environ.pop("OPENAI_API_KEY", None)

    _reset_state()
    pipeline_state["running"] = True
    pipeline_state["status"] = "running"
    pipeline_state["max_attempts"] = max_attempts

    thread = threading.Thread(
        target=_run_pipeline_thread,
        args=(intent, yang_model, yang_data, max_attempts),
        daemon=True,
    )
    thread.start()

    return jsonify({"message": "Pipeline started", "status": "running"})


@app.route("/api/pipeline-status", methods=["GET"])
def api_pipeline_status():
    """Return current pipeline state."""
    return jsonify(pipeline_state)


@app.route("/api/files/<name>", methods=["GET"])
def api_get_file(name):
    """Retrieve generated files."""
    allowed = {
        "test.p4", "expected_behavior.json", "actual_behavior.json",
        "error_summary.txt", "validation_status.txt", "detailed_prompt.txt",
    }
    if name not in allowed:
        return jsonify({"error": "File not allowed"}), 403
    if not os.path.exists(name):
        return jsonify({"error": "File not found"}), 404
    return send_file(name)


# ---------------------------------------------------------------------------
# Background pipeline runner
# ---------------------------------------------------------------------------

def _run_pipeline_thread(intent, yang_model, yang_data, max_attempts):
    """Run the full pipeline in a background thread, updating pipeline_state."""
    try:
        from pipeline import (
            cleanup_files,
            create_detailed_prompt,
            generate_p4_code,
        )

        _log("Cleaning up previous files...")
        cleanup_files()

        # VRF A.5 pre-check: generate expected behavior
        _log("Parsing intent → expected_behavior.json")
        pipeline_state["stage"] = "parsing_intent"
        expected = generate_expected_behavior(intent)
        save_expected_behavior(expected, "expected_behavior.json")
        pipeline_state["expected_behavior"] = expected
        _log(f"Expected behaviors: {[b['behavior_id'] for b in expected.get('required_behaviors', [])]}")

        intent_feedback = None
        generated_p4_code = None

        for attempt in range(1, max_attempts + 1):
            pipeline_state["attempt"] = attempt
            _log(f"--- Attempt {attempt} of {max_attempts} ---")

            # Build prompt
            pipeline_state["stage"] = "generating"
            if attempt == 1:
                prompt = create_detailed_prompt(intent, yang_model, yang_data, intent_feedback)
                with open("detailed_prompt.txt", "w") as f:
                    f.write(prompt)
            else:
                error_history = read_error_summary()
                error_section = f"\n=== PREVIOUS ATTEMPT THAT FAILED ===\n{generated_p4_code}\n\n=== COMPILATION / VALIDATION ERROR HISTORY ===\n{error_history}\n"
                if intent_feedback:
                    error_section += f"\n=== INTENT VALIDATION FEEDBACK ===\n{intent_feedback}\n"
                error_section += "\nIMPORTANT: Fix ALL errors. Start with code directly."
                prompt = create_detailed_prompt(intent, yang_model, yang_data, error_section)

            _log("Generating P4 code via LLM...")
            p4_code = generate_p4_code(prompt)
            if p4_code is None:
                _log("LLM returned no output")
                continue

            generated_p4_code = p4_code
            cleaned = clean_p4_code(p4_code)
            pipeline_state["p4_code"] = cleaned
            with open("test.p4", "w") as f:
                f.write(cleaned)

            # VRF A: Compilation
            pipeline_state["stage"] = "vrf_a"
            _log("[VRF A] Compiling P4 code...")
            success, errors = validate_p4_compilation(cleaned, "test.p4", attempt)
            pipeline_state["vrf_a_result"] = {"success": success, "errors": errors}

            if not success:
                _log(f"[VRF A] Compilation FAILED (attempt {attempt})")
                continue

            _log("[VRF A] Compilation SUCCESS")

            # VRF A.5: Intent validation
            pipeline_state["stage"] = "vrf_a5"
            _log("[VRF A.5] Validating intent alignment...")
            passed, feedback, score, detailed = run_vrf_a5(
                cleaned,
                expected_behavior_path="expected_behavior.json",
                actual_behavior_path="actual_behavior.json",
            )

            # Read actual behavior
            try:
                with open("actual_behavior.json") as f:
                    pipeline_state["actual_behavior"] = json.load(f)
            except Exception:
                pass

            pipeline_state["vrf_a5_result"] = {
                "passed": passed,
                "match_score": score,
                "detailed_scores": detailed,
                "feedback": feedback,
            }

            _log(f"[VRF A.5] Score: {score:.2%} | Passed: {passed}")

            if not passed:
                intent_feedback = feedback
                _log("[VRF A.5] Intent mismatch — retrying...")
                continue

            # Success!
            pipeline_state["status"] = "success"
            pipeline_state["stage"] = "done"
            _log(f"Pipeline complete! P4 code generated in {attempt} attempt(s).")
            pipeline_state["result"] = {
                "p4_code": cleaned,
                "attempts": attempt,
                "match_score": score,
            }
            return

        # Exhausted all attempts
        pipeline_state["status"] = "failed"
        pipeline_state["stage"] = "done"
        _log(f"Failed to generate valid P4 code after {max_attempts} attempts.")

    except Exception as e:
        pipeline_state["status"] = "failed"
        pipeline_state["error"] = str(e)
        _log(f"Pipeline error: {e}")
    finally:
        pipeline_state["running"] = False


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)
