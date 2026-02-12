# PINC Initial Wrapper + VRF A.5 — Handoff for New Agent

**Date:** February 11, 2026  
**Purpose:** Document what this project does, what was implemented, what is failing, and how to run / fix it.

---

## 1. What We’re Attempting

- **LLM-driven P4 code generation** from natural-language network intent (e.g. “Ethernet switch with MAC learning and forwarding”).
- **Two-stage validation:**
  - **VRF A:** Compilation check — generated P4 is compiled with `p4c` (Docker: `p4lang/p4c`).
  - **VRF A.5:** Intent validation — compare expected behavior (from intent) vs actual behavior (extracted from P4) via JSON; score and optionally retry with feedback.
- **Retry loop:** Up to 10 attempts. On compile failure or intent failure (score &lt; 0.6), feedback is fed back into the LLM prompt and we regenerate.

Design details are in the repo root: **`vrf-validation.md`**.

---

## 2. Repo Layout (Relevant Parts)

```
PINC/
├── vrf-validation.md                    # VRF A.5 design doc
├── Initial Wrapper Implementation/
│   ├── network_intent_to_p4.py          # Main pipeline (intent → prompt → generate → VRF A → VRF A.5)
│   ├── validate_p4.sh                   # Runs p4c in Docker (VRF A only)
│   ├── intent_parser.py                 # Intent → expected_behavior.json
│   ├── behavior_extractor.py            # P4 code → actual_behavior.json
│   ├── semantic_comparator.py           # Compare JSONs, score, feedback
│   ├── vrf_a5_validator.py              # Orchestrates extract + compare
│   ├── requirements.txt                 # openai, replicate
│   ├── README.md                        # Setup/usage
│   └── HANDOFF.md                      # This file
└── code/server-validation/p4testgen-server/
    └── run_tests.sh                    # VRF B (p4testgen/PTF) — not wired into wrapper
```

---

## 3. How to Run

- **From:** `Initial Wrapper Implementation/`
- **Need:** Python 3, Docker (running), and **either** `REPLICATE_API_TOKEN` or `OPENAI_API_KEY`
- **Commands:**
  ```bash
  cd "Initial Wrapper Implementation"
  pip install -r requirements.txt
  export REPLICATE_API_TOKEN='r8_...'   # or OPENAI_API_KEY
  python3 network_intent_to_p4.py
  ```
- **Flow:** Prompt for intent → generate `expected_behavior.json` → loop: generate P4 → run `./validate_p4.sh` (compile) → if pass, run VRF A.5 (extract actual behavior, compare) → if score ≥ 0.6 proceed, else retry with feedback.

---

## 4. What’s Not Working

**The pipeline never reaches a successful compile.** The LLM keeps producing P4-16 that fails `p4c`. After 10 attempts we always hit “Failed to generate valid P4 code”.

### 4.1 Failure 1 (earlier): `constant` vs `const`

- **Error:** `syntax error, unexpected IDENTIFIER, expecting (` at a line like `constant ethernet_type_t ethernet_type`
- **Cause:** Model used P4-14 keyword `constant`; P4-16 uses `const`.
- **What was done:**  
  - In `network_intent_to_p4.py`, `clean_p4_code()` now replaces `constant` with `const`.  
  - System and user prompts were updated to say “use `const`, never `constant`” and to show an example.

### 4.2 Failure 2 (current): “expecting APPLY” at control block

- **Error (latest run):**
  ```text
  test.p4(57):syntax error, unexpected IDENTIFIER, expecting APPLY
          metadata.ingress_port
                   ^^^^^^^^^^^^
  ```
- **Meaning:** Around line 57 the parser is inside a `control` block and sees something like `metadata.ingress_port` where it expects the `apply { ... }` block. So the model is likely:
  - Putting statements (e.g. references to `metadata.ingress_port`) **outside** an `apply { }` block, or
  - Using wrong syntax (e.g. `standard_metadata.ingress_port` should be used in the right place inside `apply { }`).
- **Not yet done:** No automatic fix or extra prompt guidance for this pattern. Error feedback is passed to the LLM, but the model may not be correcting it across attempts.

---

## 5. Error Feedback Flow (Relevant to Fixes)

- **Compilation:** `validate_p4.sh` runs p4c, writes `validation_status.txt` and `p4_validation_errors.txt`, and `extract_error_info` appends to `error_summary.txt`.
- **Retries:** For attempt &gt; 1, `read_error_summary()` (in `network_intent_to_p4.py`) reads `error_summary.txt` and the last few attempts are included in the next prompt. Intent feedback (from VRF A.5) is also appended when the last failure was intent mismatch.
- **Limitation:** The error summary is often “Attempt 1 Errors” repeated (or only the first attempt’s errors) in the message the user sees; worth checking whether **all** attempts are being appended and that the **full** compiler output (including the failing line) is in the prompt so the LLM can see line numbers and exact messages.

---

## 6. Suggested Next Steps for a New Agent

1. **Inspect failing `test.p4` around the reported line (e.g. 57).**  
   Confirm the structure: control block, `apply { }`, and where `metadata.ingress_port` (or `standard_metadata.ingress_port`) appears. Document the exact invalid pattern.

2. **Improve prompt for control blocks.**  
   In `network_intent_to_p4.py` (`create_detailed_prompt` and/or `SYSTEM_PROMPT`), add explicit P4-16 rules:
   - In a `control` block, all logic must be inside `apply { ... }`.
   - Refer to `standard_metadata_t` (e.g. `standard_metadata.ingress_port`) only inside `apply { }`, and only in controls that have `standard_metadata_t` in their signature.

3. **Optionally add a small cleanup in `clean_p4_code()`.**  
   If there is a consistent mistake (e.g. a stray line before `apply {`), consider a targeted fix (e.g. regex or simple heuristics) so that even bad output is corrected before compilation.

4. **Verify error feedback content.**  
   Ensure `error_summary.txt` and the string passed to the LLM on retry include the **full** p4c error (file, line, message and failing line). If only “Attempt 1” is appended, fix `validate_p4.sh` / `extract_error_info` or the Python that builds the retry prompt so that the **latest** attempt’s errors are clearly included.

5. **Consider a minimal golden P4 snippet.**  
   Add (or point to) a short, compilable P4-16 example (e.g. one control with `apply { }` and one use of `standard_metadata`) in the prompt or in `example_case.txt` so the model has a clear structural template.

6. **Re-run the pipeline** after changes and capture:
   - The exact `test.p4` (or the failing fragment) and the full p4c error for the next failure, so the next fix can be targeted.

---

## 7. References

- **VRF A.5 design:** `vrf-validation.md` (repo root)
- **Wrapper setup/usage:** `Initial Wrapper Implementation/README.md`
- **P4-16 language:** e.g. [P4-16 spec](https://p4.org/p4-spec/docs/P4-16-v1.2.0.html) (control block and `apply` syntax)
