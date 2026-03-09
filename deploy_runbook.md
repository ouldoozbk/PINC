# P4 Intent-to-Code Deployment Runbook

## Prerequisites

- GCP project with billing enabled
- `gcloud` CLI installed and authenticated (`gcloud auth login`)
- Project set (`gcloud config set project YOUR_PROJECT_ID`)
- Docker installed locally or access to GCP Cloud Shell

Enable required APIs:

```bash
gcloud services enable run.googleapis.com \
  artifactregistry.googleapis.com \
  cloudbuild.googleapis.com \
  storage.googleapis.com \
  compute.googleapis.com
```

---

## GCS Bucket Setup

Create the bucket in `us-central1` to keep it in the same region as your Cloud Run services:

```bash
gsutil mb -l us-central1 gs://YOUR_PROJECT_ID-models
```

The bucket uses the following folder structure:

```
gs://YOUR_PROJECT_ID-models/
├── models/
│   ├── intent_pipeline.pkl       # TF-IDF + LinearSVC intent classifier
│   └── few_shot_examples.json    # Few-shot P4 examples (optional)
└── results/
    └── UUID.json                 # Generated results, written at inference time
```

Upload the intent classifier:

```bash
gsutil cp intent_pipeline.pkl gs://YOUR_PROJECT_ID-models/models/intent_pipeline.pkl
```

Upload few-shot examples if available:

```bash
gsutil cp few_shot_examples.json gs://YOUR_PROJECT_ID-models/models/few_shot_examples.json
```

Verify uploads:

```bash
gsutil ls gs://YOUR_PROJECT_ID-models/models/
```

The `results/` folder is created automatically at inference time — no setup needed.

---

## Inference Service Setup

The backend is a FastAPI application, containerized with Docker and deployed to Cloud Run. On startup, it downloads the intent classifier and few-shot examples from GCS into memory. The service exposes the following endpoints:

- `/health`: Health check (GET)
- `/classify`: Intent classification (POST)
- `/predict`: Backward-compatible alias for classification (POST)
- `/generate`: Full pipeline (classify intent → generate P4 → validate → store to GCS) (POST)
- `/validate`: P4 code validation (POST)

See the Backend API Contract section below for request/response details.

### Environment Variables

| Variable | Required | Description | Example |
|---|---|---|---|
| `GCS_BUCKET` | Yes | GCS bucket name | `your-project-id-models` |
| `MODEL_PATH` | No | Path to classifier within bucket (default: `models/intent_pipeline.pkl`) | `models/intent_pipeline.pkl` |
| `LLM_API_KEY` | Yes | LLM API key, injected from Secret Manager | `csk-...` |
| `VALIDATION_SERVICE_URL` | No | URL of the validation service | `http://<ip>:<port>/validate` |
| `CORS_ORIGINS` | Yes | Allowed frontend origins (comma-separated, include scheme) | `https://your-app.vercel.app` |

### Build and Deploy

First, store your LLM API key in Secret Manager (see section 7 for full details):

```bash
gcloud secrets create LLM_API_KEY --replication-policy="automatic"
echo "<YOUR_LLM_API_KEY>" | gcloud secrets versions add LLM_API_KEY --data-file=-
```

Deploy to Cloud Run directly from source (Cloud Build handles the container build):

```bash
gcloud run deploy p4-deploy-backend \
  --source . \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars "GCS_BUCKET=<your-bucket>,MODEL_PATH=models/intent_pipeline.pkl,VALIDATION_SERVICE_URL=<validator-url>,CORS_ORIGINS=<frontend-url>" \
  --set-secrets "LLM_API_KEY=LLM_API_KEY:latest"
```

For automated deploys on every push to GitHub, see section 8 (Cloud Build Trigger Setup).

---

## 1. Current Architecture

Backend is Cloud Run service (`p4-deploy-backend`).

## 2. Backend API Contract (Current)

- `GET /health`
- `POST /classify` (primary classify endpoint)
- `POST /predict` (backward-compatible alias)
- `POST /generate`
- `POST /validate`

Request examples:

- For `/classify` or `/predict` endpoint (intent annotation):

```json
{
  "annotation": "Drop all UDP packets on port 53."
}
```

- For `/generate` or `/api/compile` endpoint (P4 code):

```json
{
  "p4_code": "#include <core.p4> ..."
}
```

- For `/validate` endpoint (code payload):

```json
{
  "code": "actual P4 code here"
}
```


## 3. Runtime Configuration Notes

Refer to the Environment Variables table above for required settings. Additional notes:
- `CORS_ORIGINS` must include scheme, e.g. `https://test-gcp-lemon.vercel.app`
- Secret env name must be exactly `LLM_API_KEY` (not `cerebras_api`)

## 4. Validation Service URL Behavior

`app.py` supports both validator styles:
- `/validate` style payload: `{"code": "..."}`
- compile style payload: `{"p4_code": "..."}`

Set one of:
- Current setup from PINC /main branch: `VALIDATION_SERVICE_URL=http://<ip>:8000/validate`
- Future setup with VRF-B components: `VALIDATION_SERVICE_URL=http://<ip>:<port>/api/compile`

If unset, generation still works, verification is returned as not checked.

## 5. Frontend Configuration

Frontend lives in `frontend/` (copied from `PINC/frontend`, modified to target `app.py` endpoints).

Vercel env var:
- `VITE_API_BASE_URL=https://<cloud-run-url>`

Local frontend run:

```bash
cd frontend
npm install
npm run dev
```

Local proxy is configured in `frontend/vite.config.js` for:
- `/health`
- `/classify`
- `/generate`
- `/validate`

## 6. Cloud Run Manual Deploy (Fast Path)

```bash
gcloud run deploy p4-deploy-backend \
  --source . \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars "GCS_BUCKET=toypinc-models,MODEL_PATH=models/intent_pipeline.pkl,VALIDATION_SERVICE_URL=http://136.117.52.251:8000/validate,CORS_ORIGINS=https://test-gcp-lemon.vercel.app" \
  --set-secrets "LLM_API_KEY=LLM_API_KEY:latest"
```

Quick check:

```bash
curl https://<cloud-run-url>/health
```

## 7. Secret Manager Setup (Step-by-step)

To securely store your LLM API key and make it available to Cloud Run:

**A. Create the secret in Google Cloud Console:**
1. Go to https://console.cloud.google.com/security/secret-manager
2. Click "Create Secret".
3. Enter `LLM_API_KEY` as the secret name.
4. Paste your API key as the value.
5. Click "Create".

**B. Or create the secret using the CLI:**
1. Open Cloud Shell or your terminal.
2. Run:
  ```bash
  gcloud secrets create LLM_API_KEY --replication-policy="automatic"
  ```
3. Add your API key as a secret version:
  ```bash
  echo "<YOUR_LLM_API_KEY>" | gcloud secrets versions add LLM_API_KEY --data-file=-
  ```

**C. Grant access to the build/deploy service account:**
1. Find the service account used by Cloud Build (often ends with `@<project>.iam.gserviceaccount.com`).
2. Go to https://console.cloud.google.com/security/secret-manager/LLM_API_KEY/permissions
3. Click "Add Principal".
4. Enter the service account email.
5. Add the role `Secret Manager Secret Accessor`.
6. Click "Save".

## 8. Cloud Build Trigger Setup (Step-by-step)

To automate deployment with Cloud Build:

**A. Connect your GitHub repository:**
1. Go to https://console.cloud.google.com/cloud-build/triggers
2. Click "Create Trigger".
3. Select "GitHub" and follow prompts to connect your repo.

**B. Configure the trigger:**
1. Set the trigger branch (e.g. `main`).
2. Specify `cloudbuild.yaml` as the build config file.
3. Ensure the trigger uses the correct service account.

**C. Set required permissions for the service account:**
1. Go to https://console.cloud.google.com/iam-admin/iam
2. Find the Cloud Build service account.
3. Add these roles:
  - Cloud Run Admin (`roles/run.admin`)
  - Service Account User (`roles/iam.serviceAccountUser`)
  - Secret Manager Secret Accessor (`roles/secretmanager.secretAccessor`)

**D. Confirm `cloudbuild.yaml` sets env and secrets:**
Your `cloudbuild.yaml` should include:
```
--set-env-vars=...
--set-secrets=LLM_API_KEY=LLM_API_KEY:latest
```

## 9. Common Failure Modes and Fixes

### A) `Failed to fetch` from frontend
Likely causes:
- Cloud Run requires auth
- CORS misconfigured
- Wrong `VITE_API_BASE_URL`

Fixes:
- allow unauthenticated invocations for public frontend
- set `CORS_ORIGINS=https://<vercel-domain>`
- verify Vercel env var points to correct backend URL

### B) `OPTIONS /classify 405 Method Not Allowed`
Cause:
- CORS middleware missing in deployed revision or wrong backend target

Fix:
- redeploy latest backend with CORS middleware
- confirm request reaches correct Cloud Run service

### C) `The request was not authenticated`
Cause:
- Cloud Run invoker policy blocks requests from unauthenticated clients (default for private services)

Fix (for private backend, only Vercel allowed):

1. Remove public access:
   - Deploy Cloud Run with `--no-allow-unauthenticated` (default for private services):
 ```bash
gcloud run deploy p4-deploy-backend \
   --source . \
   --region us-central1 \
   --platform managed \
   --no-allow-unauthenticated \
   --set-env-vars "GCS_BUCKET=toypinc-models,MODEL_PATH=models/intent_pipeline.pkl,VALIDATION_SERVICE_URL=http://136.117.52.251:8000/validate,CORS_ORIGINS=https://test-gcp-lemon.vercel.app" \
   --set-secrets "LLM_API_KEY=LLM_API_KEY:latest"
 ```

2. Create a dedicated Google service account for Vercel (or use an existing one):
   - In Google Cloud Console, go to IAM & Admin > Service Accounts.
   - Click "Create Service Account".
   - Name it (e.g. `vercel-invoker`) and save.

3. Grant the Cloud Run Invoker role to this service account:
```bash
gcloud run services add-iam-policy-binding p4-deploy-backend \
 --region us-central1 \
 --member="serviceAccount:<vercel-service-account>@<project>.iam.gserviceaccount.com" \
 --role="roles/run.invoker"
```

**For the future:** Configure Vercel to authenticate requests using OIDC identity tokens:
   - Vercel can generate OIDC tokens for outgoing requests.
   - In the frontend, use the OIDC token as a Bearer token in the Authorization header when calling Cloud Run.
     - Example (Python, using requests):
       
  ```python
  import requests
  
  url = "https://<cloud-run-url>/classify"
  headers = {
  "Authorization": "Bearer <OIDC_IDENTITY_TOKEN>",
  "Content-Type": "application/json"
  }
  data = {"annotation": "Drop all UDP packets on port 53."}
  
  response = requests.post(url, json=data, headers=headers)
  print(response.status_code, response.text)
  ```
**Where does `<OIDC_IDENTITY_TOKEN>` come from?**
   - The OIDC identity token is a short-lived token generated by Google to prove the identity of a service account or workload.
   - If you are running code on Google Cloud (Cloud Functions, Cloud Run, etc.), you can use the metadata server to fetch a token:
       
  ```bash
  curl "http://metadata/computeMetadata/v1/instance/service-accounts/default/identity?audience=https://<cloud-run-url>" -H "Metadata-Flavor: Google"
  ```
   - If you are running code outside Google Cloud (like Vercel), you must:
     1. Use a Google service account with the Cloud Run Invoker role.
     2. Authenticate as that service account (using a key file or Workload Identity Federation).
     3. Use Google libraries (like `google-auth` in Python) to generate an OIDC token for your Cloud Run URL.
   - Example (Python, using google-auth):
     
  ```python
  from google.auth.transport.requests import Request
  from google.oauth2 import service_account
  
  credentials = service_account.Credentials.from_service_account_file(
     'path/to/service-account.json',
     audience='https://<cloud-run-url>'
  )
  oidc_token = credentials.id_token
  ```
  - For Vercel, you can use Workload Identity Federation to avoid storing a key file. See:
   https://cloud.google.com/iam/docs/workload-identity-federation
  - More info: https://cloud.google.com/run/docs/authenticating/service-to-service

This setup eliminates the API key as a single point of compromise and lets GCP handle request validation at the infrastructure level. Only requests with valid OIDC tokens from the authorized service account will be accepted.

### D) `RuntimeError("LLM_API_KEY not set")`
Cause:
- secret mapped to wrong env var name

Fix:
- map secret as `LLM_API_KEY=LLM_API_KEY:latest`
- ensure deployed revision has this config

### E) `500 Internal Server Error` on `/generate`
Likely causes:
- LLM provider errors (key/quota/upstream)
- GCS write permission errors

Current backend now returns clearer error detail in `/generate` for LLM/GCS failures.

### F) `422 Unprocessable Entity` when validating
Cause:
- payload schema mismatch with validator endpoint

Fix:
- use `/validate` endpoint with `code` payload or `/api/compile` with `p4_code` payload
- backend now auto-handles both based on URL path

## 10. Requirements File Notes

`requirements.txt` should include:
- `fastapi`
- `uvicorn`
- `google-cloud-storage`
- `requests`
- `scikit-learn`

Do not include `pickle` in requirements (stdlib module).

## 11. Handy Verification Commands

Describe service config:

```bash
gcloud run services describe p4-deploy-backend --region us-central1 --format export
```

Check secret exists:

```bash
gcloud secrets versions access latest --secret=LLM_API_KEY
```

Health check:

```bash
curl https://<cloud-run-url>/health
```

Classify check:

```bash
curl -X POST "https://<cloud-run-url>/classify" \
  -H "Content-Type: application/json" \
  -d '{"annotation":"Drop all UDP packets on port 53."}'
```
## 12. CI/CD and Log Troubleshooting

### GitHub-triggered rebuilds
Whenever you push to the GitHub repository (on the branch configured in Cloud Build triggers, e.g. `main`), Cloud Build automatically runs the pipeline defined in `cloudbuild.yaml`. This rebuilds and redeploys the backend to Cloud Run. You can check trigger status and history at:
https://console.cloud.google.com/cloud-build/triggers

### Checking logs with gcloud
To view recent logs for your Cloud Run service via CLI:

```bash
gcloud logging read "resource.type=cloud_run_revision AND resource.labels.service_name=p4-deploy-backend" --limit 50 --format="value(textPayload)"
```
Or for all logs (including errors):

```bash
gcloud run services logs read p4-deploy-backend --region us-central1
```

### Checking logs in GCP Console
1. Go to https://console.cloud.google.com/run
2. Click your service (`p4-deploy-backend`).
3. Click "Logs" in the sidebar to view request and error logs.
4. Filter by severity or search for error messages (e.g. cerebras API failures, frontend errors, etc.)

This is useful for troubleshooting failed requests, backend errors, or issues reported by the frontend.

