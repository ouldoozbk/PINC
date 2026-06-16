# Summary of Changes

## Problem

VRF A.5 was failing on correctly-classified programs because:

1. `intent_code_similarity` (10% weight) used `sentence_transformers` / `all-MiniLM-L6-v2` — a model unavailable in the environment that actively suppressed scores on correct programs
2. No streamlined way to test weight configurations against a large corpus of pre-compiled P4 programs

---

## Changes

### `backend/vrf_a5_semantic_comparator.py`
- **Config B applied:** `intent_code_similarity` weight `0.10 → 0.05`, `bucket_recall` weight `0.60 → 0.65`
- Replaced `embed_text` (numpy cosine similarity) with `compute_text_similarity` (Claude Haiku call)
- Added `api_key: str = ""` param to `compute_intent_match_score` and `generate_intent_mismatch_feedback`
- Removed `numpy` import

### `backend/vrf_a5_semantic_router.py` — full rewrite
- **Removed:** `sentence_transformers`, `SentenceTransformer`, `_load_model`, `_get_template_embeddings`, `embed_text`, `_BUCKET_KEYWORDS`, `_keyword_classify` — all embedding/keyword fallback infrastructure
- **Added:** `_call_haiku()` — shared Anthropic API helper
- **Added:** `compute_text_similarity(a, b, api_key)` — asks Haiku to score similarity 0–1
- **Added:** `classify_code_buckets(description, api_key)` — used by behavior extractor
- `route_intent_to_buckets` now calls Claude Haiku; raises `RuntimeError` if no `api_key` (no silent fallback)
- `compute_text_similarity` raises `RuntimeError` if no `api_key`

### `backend/vrf_a5_intent_parser.py`
- Added `api_key: str = ""` to `generate_expected_behavior` and `_infer_behaviors_and_headers`
- Passes `api_key` through to `route_intent_to_buckets`
- Updated docstring (removed `all-MiniLM-L6-v2` reference)

### `backend/vrf_a5_behavior_extractor.py`
- **Removed:** `_classify_buckets_embedding`, `numpy`, `SIMILARITY_THRESHOLD`, `_get_template_embeddings`, `_load_model` imports
- `_classify_buckets_llm` now raises `RuntimeError` if no `api_key` instead of silently falling back
- Removed silent `except` block that swallowed LLM failures

### `backend/vrf_a5_validator.py`
- Passes `api_key` through to `compute_intent_match_score` and `generate_intent_mismatch_feedback`

### `backend/run_weight_experiments.py` — new file
Batch experiment runner over all 405 pre-compiled cases in `FINAL_p4_ds_clean_comments.jsonl`:

- Uses `annotation` as intent, `cleaned_p4` as code — skips VRF A entirely
- Generates `ir.json` per case via Docker (`p4test --toJSON`), same command as `vrf_a_compile.sh`
- **Persistent cache** at `experiment_cache/<index>/` — `test.p4`, `ir.json`, `expected_behavior.json`, `actual_behavior.json` are never deleted; re-runs skip any step whose output is already cached
- Tests 4 configs in a single pass per case (Baseline, A no-sim, B sim=0.05, C header=0.05)
- Prints per-case progress and a final comparison table (pass rate, avg score, Δ vs baseline, flipped/regressed cases)
- `--api-key` flag; falls back to `CLAUDE_API_KEY` / `ANTHROPIC_API_KEY` env vars
- `--limit N` for partial runs, `--force` to bypass cache

### `backend/experiment_cache/` — new directory
Persistent cache root for the experiment runner.

---

## Weight Experiment Results (20-record sample)

| Config     | Pass | Pass% | Avg score |
|------------|------|-------|-----------|
| Baseline   |   13 | 65.0% |    0.7806 |
| A_no_sim   |   14 | 70.0% |    0.8329 |
| B_sim_05   |   14 | 70.0% |    0.8066 |
| C_header_05|   14 | 70.0% |    0.7941 |

**Decision:** A_no_sim performed best on avg score. Removed `intent_code_similarity` entirely.

---

## Round 2 — Remove intent_code_similarity

### Problem
`intent_code_similarity` — even at 0.05 weight — added latency (extra Claude Haiku API call per validation), complexity, and noise with no measurable benefit over the pure bucket-recall approach.

### Changes

### `backend/vrf_a5_semantic_router.py`
- **Removed:** `compute_text_similarity(a, b, api_key)` function entirely

### `backend/vrf_a5_semantic_comparator.py`
- **Removed:** `from vrf_a5_semantic_router import compute_text_similarity` import
- **Removed:** `intent_code_similarity` key from `WEIGHTS`
- **Updated:** `bucket_recall` weight `0.65 → 0.70` (absorbs the freed weight)
- **Removed:** `api_key` param from `compute_intent_match_score` and `generate_intent_mismatch_feedback`
- **Removed:** `detailed_scores` param from `generate_intent_mismatch_feedback` (was only used for LOW_SEMANTIC_SIMILARITY check)
- **Removed:** `LOW_SEMANTIC_SIMILARITY` feedback issue block
- **Updated:** module docstring (5 components → 4, updated weights)

### `backend/vrf_a5_validator.py`
- Removed `api_key` from calls to `compute_intent_match_score` and `generate_intent_mismatch_feedback`
- Removed `detailed_scores` from `generate_intent_mismatch_feedback` call

### `backend/vrf_a5_intent_parser.py`
- Updated docstring: `all-MiniLM-L6-v2` → `Claude Haiku (claude-haiku-4-5-20251001)`

### `backend/run_weight_experiments.py`
- **Removed:** `from vrf_a5_semantic_router import compute_text_similarity` import
- **Removed:** `intent_code_similarity` scoring block from `_score()`
- **Removed:** `api_key` param from `_score()`
- **Replaced:** `BASELINE` + 4-config `CONFIGS` dict with single `Production` config (A_no_sim weights)
- **Simplified:** summary table — removed Δ-vs-Baseline column and marginal/regression sections; replaced with a Failures list
- Updated module docstring

---

## Invariants

- No `sentence_transformers` / `numpy` usage remains anywhere in the VRF A.5 pipeline
- No vector/cosine similarity anywhere — bucket classification uses Claude Haiku; header similarity uses difflib NED
- Missing API key raises immediately with a clear error — no silent degradation
- Production weights: `bucket_recall=0.70`, `header_similarity=0.10`, `control_blocks=0.10`, `prohibited_check=0.10`
- Verified on 20-record sample: 14/20 pass (70%), avg score 0.833
