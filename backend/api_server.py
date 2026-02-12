"""
PINC API Server — Unified Flask backend for the full pipeline.

Endpoints:
  POST /api/run-pipeline        Run full pipeline (intent → P4 code → VRF A → VRF A.5)
  GET  /api/pipeline-status     Poll live pipeline state
  POST /api/parse-intent        Convert intent text → expected_behavior.json
  POST /api/extract-behavior    Extract actual_behavior.json from P4 code
  POST /api/compare             Compare expected vs actual behavior
  POST /api/compile             Compile P4 code only (VRF A)
  POST /api/validate-intent     Run VRF A.5 only (intent validation)
  POST /api/vrf-b/validate      Run VRF B functional testing via p4testgen container pool
  GET  /api/vrf-b/status        Container pool health / availability
  POST /api/vrf-b/start-pool    Start the VRF B container pool
  POST /api/vrf-b/stop-pool     Stop the VRF B container pool
  GET  /api/files/<name>        Retrieve generated files
"""

import json
import os
import subprocess
import sys
import threading
import time
import uuid
from datetime import datetime, timezone
from queue import Queue, Empty

import httpx
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
_pipeline_stop = threading.Event()

pipeline_state = {
    "running": False,
    "attempt": 0,
    "max_attempts": 10,
    "status": "idle",          # idle | running | success | failed
    "stage": "",               # "" | generating | vrf_a | vrf_a5 | vrf_b | done
    "logs": [],
    "result": None,
    "expected_behavior": None,
    "actual_behavior": None,
    "p4_code": None,
    "vrf_a_result": None,
    "vrf_a5_result": None,
    "vrf_b_result": None,
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
        "vrf_b_result": None,
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
    max_attempts = int(data.get("max_attempts", 10))

    if not intent:
        return jsonify({"error": "intent is required"}), 400

    _reset_state()
    _pipeline_stop.clear()
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


@app.route("/api/stop-pipeline", methods=["POST"])
def api_stop_pipeline():
    """Request the running pipeline to stop after the current step."""
    if not pipeline_state["running"]:
        return jsonify({"error": "Pipeline is not running"}), 409
    _pipeline_stop.set()
    _log("Stop requested — pipeline will halt after current step.")
    return jsonify({"message": "Stop signal sent"})


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
# VRF B: Container pool management (p4testgen functional testing)
# ---------------------------------------------------------------------------

VRF_B_CONFIG = {
    "image": "p4_test_suite",
    "port_start": 8022,
    "num_containers": 4,       # default 4 for dev; set higher for prod
    "timeout": 60,
}

vrf_b_pool = Queue()
vrf_b_state = {
    "running": False,
    "total": 0,
    "available": 0,
    "ports": [],
}


def _vrfb_start_pool(num_containers=None, port_start=None):
    """Start VRF B Docker worker containers and fill the pool."""
    n = num_containers or VRF_B_CONFIG["num_containers"]
    ps = port_start or VRF_B_CONFIG["port_start"]
    image = VRF_B_CONFIG["image"]

    # Drain any stale pool entries
    while not vrf_b_pool.empty():
        try:
            vrf_b_pool.get_nowait()
        except Empty:
            break

    ports = list(range(ps, ps + n))
    started = []

    for port in ports:
        name = f"p4_container_{port}"
        # Stop any leftover container with same name
        subprocess.run(["docker", "rm", "-f", name],
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        result = subprocess.run([
            "docker", "run", "-d",
            "--name", name,
            "--rm", "--privileged", "--cap-add=NET_ADMIN",
            "-p", f"{port}:8000",
            image,
        ], capture_output=True, text=True)
        if result.returncode == 0:
            vrf_b_pool.put(port)
            started.append(port)

    vrf_b_state.update({
        "running": True,
        "total": len(started),
        "available": len(started),
        "ports": started,
    })
    return started


def _vrfb_stop_pool():
    """Stop all VRF B containers."""
    for port in vrf_b_state.get("ports", []):
        name = f"p4_container_{port}"
        subprocess.run(["docker", "stop", name],
                       stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # Drain pool
    while not vrf_b_pool.empty():
        try:
            vrf_b_pool.get_nowait()
        except Empty:
            break

    vrf_b_state.update({
        "running": False,
        "total": 0,
        "available": 0,
        "ports": [],
    })


@app.route("/api/vrf-b/status", methods=["GET"])
def api_vrfb_status():
    """Return VRF B container pool status."""
    vrf_b_state["available"] = vrf_b_pool.qsize()
    return jsonify(vrf_b_state)


@app.route("/api/vrf-b/start-pool", methods=["POST"])
def api_vrfb_start_pool():
    """Start the VRF B container pool."""
    if vrf_b_state["running"]:
        return jsonify({"error": "Pool is already running", **vrf_b_state}), 409

    data = request.get_json(force=True) if request.is_json else {}
    n = int(data.get("num_containers", VRF_B_CONFIG["num_containers"]))
    ps = int(data.get("port_start", VRF_B_CONFIG["port_start"]))

    started = _vrfb_start_pool(num_containers=n, port_start=ps)
    if not started:
        return jsonify({"error": "Failed to start containers. Is the p4_test_suite image built?"}), 500

    return jsonify({"message": f"Started {len(started)} containers", **vrf_b_state})


@app.route("/api/vrf-b/stop-pool", methods=["POST"])
def api_vrfb_stop_pool():
    """Stop the VRF B container pool."""
    _vrfb_stop_pool()
    return jsonify({"message": "Pool stopped", **vrf_b_state})


@app.route("/api/vrf-b/validate", methods=["POST"])
def api_vrfb_validate():
    """Run VRF B: send P4 code to a worker container for functional testing."""
    data = request.get_json(force=True)
    p4_code = data.get("p4_code", "").strip()
    if not p4_code:
        return jsonify({"error": "p4_code is required"}), 400

    if not vrf_b_state["running"] or vrf_b_pool.empty():
        return jsonify({
            "error": "VRF B container pool is not running or no workers available. Start the pool first.",
        }), 503

    try:
        port = vrf_b_pool.get(timeout=5)
    except Empty:
        return jsonify({"error": "All VRF B workers are busy. Try again later."}), 503

    try:
        timeout = VRF_B_CONFIG["timeout"]
        url = f"http://localhost:{port}/validate"
        resp = httpx.post(url, json={"code": p4_code}, timeout=timeout)
        result = resp.json()
        return jsonify({
            "success": result.get("success", False),
            "stdout": result.get("stdout", ""),
            "stderr": result.get("stderr", ""),
            "returncode": result.get("returncode"),
            "error": result.get("error"),
        }), resp.status_code
    except httpx.TimeoutException:
        return jsonify({"success": False, "error": f"VRF B validation timed out ({timeout}s)"}), 504
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500
    finally:
        vrf_b_pool.put(port)


# ---------------------------------------------------------------------------
# Background pipeline runner
# ---------------------------------------------------------------------------

def _run_vrf_b(p4_code):
    """Run VRF B functional testing synchronously. Returns result dict."""
    if not vrf_b_state["running"] or vrf_b_pool.empty():
        return {"success": False, "skipped": True, "error": "VRF B pool not running — skipped"}

    try:
        port = vrf_b_pool.get(timeout=5)
    except Empty:
        return {"success": False, "skipped": True, "error": "No VRF B workers available — skipped"}

    try:
        timeout = VRF_B_CONFIG["timeout"]
        url = f"http://localhost:{port}/validate"
        resp = httpx.post(url, json={"code": p4_code}, timeout=timeout)
        data = resp.json()
        return {
            "success": data.get("success", False),
            "skipped": False,
            "stdout": data.get("stdout", ""),
            "stderr": data.get("stderr", ""),
            "returncode": data.get("returncode"),
            "error": data.get("error"),
        }
    except httpx.TimeoutException:
        return {"success": False, "skipped": False, "error": f"VRF B timed out ({timeout}s)"}
    except Exception as e:
        return {"success": False, "skipped": False, "error": str(e)}
    finally:
        vrf_b_pool.put(port)


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
            if _pipeline_stop.is_set():
                pipeline_state["status"] = "failed"
                pipeline_state["stage"] = "done"
                _log("Pipeline stopped by user.")
                return

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

            _log("Generating P4 code via Replicate...")
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

            # VRF B: Functional testing
            pipeline_state["stage"] = "vrf_b"
            _log("[VRF B] Running functional tests (p4testgen + PTF)...")
            vrf_b_result = _run_vrf_b(cleaned)
            pipeline_state["vrf_b_result"] = vrf_b_result

            if vrf_b_result.get("skipped"):
                _log(f"[VRF B] Skipped — {vrf_b_result.get('error', 'pool not running')}")
            elif vrf_b_result.get("success"):
                _log("[VRF B] All functional tests PASSED")
            else:
                _log(f"[VRF B] Functional tests FAILED — {vrf_b_result.get('error', 'see output')}")

            # Pipeline complete (VRF B is informational — doesn't block success)
            pipeline_state["status"] = "success"
            pipeline_state["stage"] = "done"
            _log(f"Pipeline complete! P4 code generated in {attempt} attempt(s).")
            pipeline_state["result"] = {
                "p4_code": cleaned,
                "attempts": attempt,
                "match_score": score,
                "vrf_b_passed": vrf_b_result.get("success", False),
                "vrf_b_skipped": vrf_b_result.get("skipped", True),
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
