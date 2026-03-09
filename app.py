import os
import re
import time
import logging
import json
import uuid
from contextlib import asynccontextmanager
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse, JSONResponse
from pydantic import BaseModel
from google.cloud import storage
import requests as http_requests
from model import load_model

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

pipeline = None
gcs_client = None
llm_client = None


@asynccontextmanager
async def lifespan(app: FastAPI):
    global pipeline, gcs_client, llm_client, few_shot_examples

    # Load intent classifier from GCS
    bucket_name = os.environ["GCS_BUCKET"]
    model_path = os.environ.get("MODEL_PATH", "models/intent_pipeline.pkl")
    local_path = "/tmp/intent_pipeline.pkl"

    # Initialize GCS client first; startup downloads depend on it.
    gcs_client = storage.Client()

    # Load few-shot examples
    try:
        blob = gcs_client.bucket(bucket_name).blob("models/few_shot_examples.json")
        blob.download_to_filename("/tmp/few_shot_examples.json")
        with open("/tmp/few_shot_examples.json") as f:
            few_shot_examples = json.load(f)
        logger.info(f"Loaded {len(few_shot_examples)} few-shot examples")
    except Exception as e:
        logger.warning(f"No few-shot examples found, proceeding without: {e}")
        few_shot_examples = []

    llm_client = OpenRouterClient(model_name="gpt-oss-120b")
    logger.info("LLM client initialized")

    t0 = time.time()
    bucket = gcs_client.bucket(bucket_name)
    blob = bucket.blob(model_path)
    blob.download_to_filename(local_path)
    logger.info(f"GCS download: {time.time()-t0:.2f}s")

    pipeline = load_model(local_path)
    logger.info(f"Total startup: {time.time()-t0:.2f}s")

    try:
        yield
    finally:
        # No explicit shutdown logic for now; placeholder if needed later.
        pass


app = FastAPI(lifespan=lifespan)

# Allow browser clients from separate frontend hosts (e.g., Vercel).
# Set CORS_ORIGINS to comma-separated origins in production.
cors_origins_env = os.getenv("CORS_ORIGINS", "*").strip()
if cors_origins_env == "*":
    cors_origins = ["*"]
else:
    cors_origins = [o.strip() for o in cors_origins_env.split(",") if o.strip()]

app.add_middleware(
    CORSMiddleware,
    allow_origins=cors_origins,
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Code from PINC repository
class OpenRouterClient:
    def __init__(self, model_name: str):
        api_key = os.getenv("LLM_API_KEY")
        if not api_key:
            raise RuntimeError("LLM_API_KEY not set")
        self.model_name = model_name
        self.headers = {
            "Authorization": f"Bearer {api_key}",
            "Content-Type": "application/json",
        }

    def complete(self, prompt: str, max_tokens=2048) -> str:
        payload = {
            "model": self.model_name,
            "messages": [
    {
        "role": "system",
        "content": """You are an expert P4 code generator with deep networking domain knowledge.
When given a user description of packet-processing behavior or network intent, respond with exactly one valid, compilable P4 program.
Do not include comments, explanations, or any extra tokens. Always produce code that compiles cleanly under the standard p4c compiler."""
    },
    {"role": "user", "content": prompt}
],
            "max_tokens": max_tokens,
        }
        # adding retry logic to handle rate limits from LLM provider
        # "https://openrouter.ai/api/v1/chat/completions"
        # "https://api.cerebras.ai/v1/chat/completions"
        for attempt in range(3):
            r = http_requests.post(
                "https://api.cerebras.ai/v1/chat/completions",
                headers=self.headers,
                json=payload,
                timeout=120
            )
            # if rate limited, wait exponentially longer and retry up to 3 times before giving up
            if r.status_code == 429:
                wait = 2 ** attempt
                logger.warning(f"Rate limited, retrying in {wait}s...")
                time.sleep(wait)
                continue
            r.raise_for_status()
            return r.json()["choices"][0]["message"]["content"]
        raise RuntimeError("LLM provider rate limit exceeded after 3 retries")


class GenerateRequest(BaseModel):
    annotation: str


class ValidateRequest(BaseModel):
    p4_code: str


def extract_p4_from_response(response: str) -> str:
    """Extract P4 code from LLM response: <p4>...</p4> or ```p4 ... ```."""
    text = response.strip()
    # <p4> ... </p4>
    m = re.search(r"<p4>\s*(.*?)\s*</p4>", text, re.DOTALL | re.IGNORECASE)
    if m:
        return m.group(1).strip()
    # ```p4 or ```P4 ... ```
    m = re.search(r"```(?:[pP]4)?\s*\n(.*?)```", text, re.DOTALL)
    if m:
        return m.group(1).strip()
    # Fallback: from first #include to end
    if "#include" in text:
        return text[text.find("#include") :].strip()
    return text


def call_validation_service(p4_code: str) -> dict:
    """
    Call external validation service (e.g. PINC backend /validate or /api/compile).
    Supports both request schemas:
    - /validate style: { "code": "..." }
    - compile style: { "p4_code": "..." }
    Returns normalized output: {"compiled": bool|None, "errors": str|None}.
    """
    url = os.environ.get("VALIDATION_SERVICE_URL", "").strip()
    if not url:
        return {"compiled": None, "errors": None}
    # If the URL already has a specific path (e.g. ends with /validate, /compile, /api/compile),
    # use it as-is. Otherwise, assume it's a base URL and append /api/compile.
    lower = url.rstrip("/").lower()
    if lower.endswith(("/validate", "/compile", "/api/compile")):
        full_url = url
    else:
        full_url = url.rstrip("/") + "/api/compile"

    # Dispatcher-compatible /validate endpoints expect {"code": "..."};
    # compile endpoints expect {"p4_code": "..."}.
    if full_url.rstrip("/").lower().endswith("/validate"):
        payload = {"code": p4_code}
    else:
        payload = {"p4_code": p4_code}

    try:
        r = http_requests.post(
            full_url,
            json=payload,
            headers={"Content-Type": "application/json"},
            timeout=60,
        )
        r.raise_for_status()
        data = r.json()

        # Accept both compile-style and dispatcher-style response schemas.
        success = data.get("success")
        if success is None:
            success = data.get("compiled", False)

        errors = data.get("errors")
        if errors is None:
            errors = data.get("error")

        if errors is not None and not isinstance(errors, str):
            errors = json.dumps(errors) if errors else None
        return {"compiled": success, "errors": errors}
    except Exception as e:
        logger.warning(f"Validation service call failed: {e}")
        return {"compiled": None, "errors": str(e)}


def build_prompt(annotation: str, intent: str, few_shot_examples: list = []) -> str:
    examples_str = ""
    if few_shot_examples:
        examples_str = "EXAMPLES:\nHere are examples of similar network intents and their P4 implementations:\n\n"
        examples_str += "\n".join([
            f"Example {i+1}:\nIntent: {ex['annotation']}\nImplementation:\n```p4\n{ex['code']}\n```\n"
            for i, ex in enumerate(few_shot_examples)
        ])

    return f"""You are generating one compilable P4_16 program for BMv2 v1model.

TASK:
Implement the network intent: {annotation}

Intent category: {intent}

{examples_str}

REQUIREMENTS:
- Target: BMv2 with v1model architecture
- Include all required components: headers, parser, ingress/egress controls, deparser, and V1Switch main block
- Ensure compatibility with p4c compiler
- Follow the patterns shown in the examples above
- Output exactly one complete, compilable program
- No prose, comments, or markdown in the output
- Start your reply with <p4> on the first line and end with </p4> on the last line
- Never reuse code from the prompt or previous examples. Always write a new solution.

Generate the P4 program now:"""

# function to save result dict to GCS and return the GCS URI
def save_result_to_gcs(result: dict) -> str:
    bucket_name = os.environ["GCS_BUCKET"]
    job_id = str(uuid.uuid4())
    blob_path = f"results/{job_id}.json"

    bucket = gcs_client.bucket(bucket_name)
    blob = bucket.blob(blob_path)
    blob.upload_from_string(json.dumps(result, indent=2), content_type="application/json")

    gcs_uri = f"gs://{bucket_name}/{blob_path}"
    logger.info(f"Result saved to {gcs_uri}")
    return gcs_uri

# generate endpoint: includes intent classification, LLM call, and saving results to GCS
@app.post("/generate")
async def generate(req: GenerateRequest):
    if pipeline is None:
        raise HTTPException(status_code=503, detail="Model not loaded")
    if not req.annotation.strip():
        raise HTTPException(status_code=400, detail="annotation cannot be empty")

    # Step 1: classify intent
    t0 = time.time()
    intent = pipeline.predict([req.annotation])[0]
    classify_ms = (time.time()-t0)*1000

    # Step 2: build prompt + call OpenRouter
    prompt = build_prompt(req.annotation, intent)
    t1 = time.time()
    try:
        response = llm_client.complete(prompt)
    except Exception as e:
        logger.exception("LLM completion failed")
        raise HTTPException(status_code=502, detail=f"LLM completion failed: {e}")
    p4_code = extract_p4_from_response(response)
    llm_ms = (time.time() - t1) * 1000

    # Step 3: optional verification (compilation check via external service)
    verification = call_validation_service(p4_code)

    # Step 4: save to GCS
    result = {
        "job_id": str(uuid.uuid4()),
        "annotation": req.annotation,
        "intent": intent,
        "p4_code": p4_code,
        "verification": verification,
        "latency": {
            "classify_ms": round(classify_ms, 2),
            "llm_ms": round(llm_ms, 2),
            "total_ms": round(classify_ms + llm_ms, 2),
        },
    }
    try:
        gcs_uri = save_result_to_gcs(result)
    except Exception as e:
        logger.exception("Failed saving result to GCS")
        raise HTTPException(status_code=500, detail=f"Failed saving result to GCS: {e}")
    result["gcs_uri"] = gcs_uri

    return result

# /classify is the primary endpoint for intent classification only, without generation or verification. 
# Useful for benchmarking and as a standalone service.
@app.post("/classify")
async def classify(req: GenerateRequest):
    if pipeline is None:
        raise HTTPException(status_code=503, detail="Model not loaded")
    t0 = time.time()
    intent = pipeline.predict([req.annotation])[0]
    return {
        "annotation": req.annotation,
        "predicted_intent": intent,
        "latency_ms": round((time.time()-t0)*1000, 2)
    }


@app.get("/health")
async def health():
    return {"status": "ok", "model_loaded": pipeline is not None}


@app.post("/validate")
async def validate(req: ValidateRequest):
    """
    Verify P4 code compilation via external validation service.
    Set VALIDATION_SERVICE_URL to your backend validation endpoint, e.g.:
    - http://<host>:<port>/validate
    - http://<host>:<port>/api/compile
    """
    if not req.p4_code.strip():
        raise HTTPException(status_code=400, detail="p4_code cannot be empty")
    verification = call_validation_service(req.p4_code)
    if verification["compiled"] is None and verification["errors"] is None:
        return JSONResponse(
            status_code=503,
            content={
                "detail": "Validation not configured. Set VALIDATION_SERVICE_URL to your PINC validation endpoint (e.g. https://public-ip:port/validate).",
                "verification": verification,
            },
        )
    return {"verification": verification, "compiled": verification["compiled"]}


# Minimal landing page: sample input, classify, generate, show verification
INDEX_HTML = """<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>P4 Intent Classifier &amp; Generator</title>
  <style>
    * { box-sizing: border-box; }
    body { font-family: system-ui, sans-serif; max-width: 720px; margin: 0 auto; padding: 1.5rem; background: #0f0f12; color: #e4e4e7; }
    h1 { font-size: 1.35rem; margin-bottom: 0.5rem; }
    .muted { color: #71717a; font-size: 0.9rem; margin-bottom: 1.25rem; }
    label { display: block; font-size: 0.8rem; font-weight: 600; color: #a1a1aa; margin-bottom: 0.35rem; }
    textarea { width: 100%; min-height: 88px; padding: 0.6rem 0.75rem; background: #18181b; border: 1px solid #3f3f46; border-radius: 6px; color: #e4e4e7; font-size: 0.85rem; resize: vertical; }
    textarea:focus { outline: none; border-color: #6366f1; }
    button { padding: 0.5rem 1rem; border-radius: 6px; font-weight: 600; font-size: 0.85rem; cursor: pointer; border: none; margin-right: 0.5rem; margin-bottom: 0.5rem; }
    .btn-pri { background: #6366f1; color: #fff; }
    .btn-pri:hover { background: #4f46e5; }
    .btn-pri:disabled { opacity: 0.5; cursor: not-allowed; }
    .btn-sec { background: #27272a; color: #e4e4e7; border: 1px solid #3f3f46; }
    .btn-sec:hover { border-color: #52525b; }
    pre, .out { background: #18181b; border: 1px solid #3f3f46; border-radius: 6px; padding: 0.75rem 1rem; font-size: 0.8rem; white-space: pre-wrap; word-break: break-word; max-height: 320px; overflow: auto; margin-top: 0.5rem; }
    .out { margin-top: 1rem; }
    .badge { display: inline-block; padding: 0.2rem 0.5rem; border-radius: 4px; font-size: 0.75rem; font-weight: 600; margin-right: 0.5rem; }
    .badge-ok { background: rgba(34, 197, 94, 0.2); color: #22c55e; }
    .badge-fail { background: rgba(239, 68, 68, 0.2); color: #ef4444; }
    .badge-unknown { background: rgba(113, 113, 122, 0.3); color: #a1a1aa; }
    .err { color: #f87171; font-size: 0.85rem; margin-top: 0.5rem; }
    #predictOut, #generateOut { margin-top: 0.75rem; }
  </style>
</head>
<body>
  <h1>P4 Intent Classifier &amp; Generator</h1>
  <p class="muted">Enter a network intent to classify and/or generate P4 code. Verification (compiled: true/false) uses VALIDATION_SERVICE_URL when set.</p>
  <div>
    <label for="annotation">Network intent</label>
    <textarea id="annotation" placeholder="e.g. Drop all UDP packets on port 53.">Drop all UDP packets on port 53.</textarea>
  </div>
  <div style="margin-top: 1rem;">
    <button class="btn-pri" id="btnPredict">Classify</button>
    <button class="btn-pri" id="btnGenerate">Generate P4</button>
  </div>
  <div id="predictOut"></div>
  <div id="generateOut"></div>
  <script>
    const base = '';
    const annotation = () => document.getElementById('annotation').value.trim();
    const predictOut = document.getElementById('predictOut');
    const generateOut = document.getElementById('generateOut');

    async function classify() {
      const text = annotation();
      if (!text) { predictOut.innerHTML = '<span class="err">Enter an intent.</span>'; return; }
      predictOut.innerHTML = '<span class="muted">Classifying…</span>';
      try {
        const r = await fetch(base + '/classify', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ annotation: text }) });
        const d = await r.json();
        if (!r.ok) { predictOut.innerHTML = '<span class="err">' + (d.detail || r.status) + '</span>'; return; }
        predictOut.innerHTML = '<div class="out"><strong>Predicted intent:</strong> ' + (d.predicted_intent || '-') + '<br><span class="muted">latency_ms: ' + (d.latency_ms ?? '-') + '</span></div>';
      } catch (e) {
        predictOut.innerHTML = '<span class="err">' + e.message + '</span>';
      }
    }

    async function generate() {
      const text = annotation();
      if (!text) { generateOut.innerHTML = '<span class="err">Enter an intent.</span>'; return; }
      generateOut.innerHTML = '<span class="muted">Generating P4…</span>';
      try {
        const r = await fetch(base + '/generate', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ annotation: text }) });
        const d = await r.json();
        if (!r.ok) { generateOut.innerHTML = '<span class="err">' + (d.detail || r.status) + '</span>'; return; }
        const v = d.verification || {};
        let verHtml = '';
        if (v.compiled === true) verHtml = '<span class="badge badge-ok">compiled: true</span>';
        else if (v.compiled === false) verHtml = '<span class="badge badge-fail">compiled: false</span>';
        else verHtml = '<span class="badge badge-unknown">compiled: not checked (set VALIDATION_SERVICE_URL)</span>';
        if (v.errors) verHtml += '<pre style="margin-top:0.5rem;font-size:0.78rem;">' + escapeHtml(v.errors) + '</pre>';
        generateOut.innerHTML = '<div class="out"><strong>Intent:</strong> ' + escapeHtml(d.intent || '') + '<br><strong>Verification</strong> ' + verHtml + '<br><span class="muted">latency: ' + (d.latency && d.latency.total_ms ? d.latency.total_ms + ' ms' : '-') + '</span><br><br><strong>P4 code:</strong><pre>' + escapeHtml((d.p4_code || '').slice(0, 4000)) + (d.p4_code && d.p4_code.length > 4000 ? '…' : '') + '</pre></div>';
      } catch (e) {
        generateOut.innerHTML = '<span class="err">' + e.message + '</span>';
      }
    }

    function escapeHtml(s) { return (s ?? '').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;').replace(/"/g,'&quot;'); }
    document.getElementById('btnPredict').onclick = classify;
    document.getElementById('btnGenerate').onclick = generate;
  </script>
</body>
</html>
"""


@app.get("/", response_class=HTMLResponse)
async def index():
    """Serve minimal landing page: sample input, classify, generate, verification (compiled: true/false)."""
    return INDEX_HTML
