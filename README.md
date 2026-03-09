# P4 Intent-to-Code System

## Overview
This project provides an end-to-end system for translating network intent into validated P4 code using LLMs, FastAPI, and Google Cloud Platform. It includes:
- A FastAPI backend deployed on Cloud Run
- A React frontend (Vercel/Netlify)
- GCP Cloud Storage for models/results
- Validation server for P4 code

## Architecture
- **Frontend:** Static React app in `frontend/`, interacts with backend via API
- **Backend:** FastAPI app (`app.py`), containerized and deployed to Cloud Run
- **Validation Server:** Dockerized service for P4 code validation
- **Cloud Storage:** Stores models and generated results

## Setup

### Prerequisites
- GCP project with billing enabled
- `gcloud` CLI installed and authenticated
- Docker installed

### GCP Configuration
1. Enable required APIs:
```bash
gcloud services enable run.googleapis.com artifactregistry.googleapis.com cloudbuild.googleapis.com storage.googleapis.com compute.googleapis.com
```
2. Create GCS bucket:
```bash
gsutil mb -l us-central1 gs://YOUR_PROJECT_ID-models
```
3. Upload model files:

```bash
gsutil cp intent_pipeline.pkl gs://YOUR_PROJECT_ID-models/models/intent_pipeline.pkl
gsutil cp few_shot_examples.json gs://YOUR_PROJECT_ID-models/models/few_shot_examples.json
```

### Secret Manager
Store your LLM API key securely:
```bash
gcloud secrets create LLM_API_KEY --replication-policy="automatic"
echo "<YOUR_LLM_API_KEY>" | gcloud secrets versions add LLM_API_KEY --data-file=-
```

### Backend Deployment
Deploy FastAPI backend to Cloud Run:
```bash
gcloud run deploy p4-deploy-backend \
  --source . \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --set-env-vars "GCS_BUCKET=<your-bucket>,MODEL_PATH=models/intent_pipeline.pkl,VALIDATION_SERVICE_URL=<validator-url>,CORS_ORIGINS=<frontend-url>" \
  --set-secrets "LLM_API_KEY=LLM_API_KEY:latest"
```

### Frontend Setup
1. Set `VITE_API_BASE_URL` to your backend URL (Vercel env var)
2. Run locally:

```bash
cd frontend
npm install
npm run dev
```

## API Endpoints
- `GET /health`: Health check
- `POST /classify`: Intent classification
- `POST /predict`: Alias for classify
- `POST /generate`: Full pipeline (classify, generate, validate, store)
- `POST /validate`: P4 code validation

## Example Requests
- Classify:
  ```json
  { "annotation": "Drop all UDP packets on port 53." }
  ```
- Generate:
  ```json
  { "p4_code": "#include <core.p4> ..." }
  ```
- Validate:
  ```json
  { "code": "actual P4 code here" }
  ```

## Troubleshooting
- CORS errors: Ensure `CORS_ORIGINS` is set correctly
- Auth errors: Allow unauthenticated access or configure OIDC tokens
- Secret errors: Map secret as `LLM_API_KEY=LLM_API_KEY:latest`
- Validation errors: Use correct payload schema for `/validate` or `/api/compile`

## Requirements
See `requirements.txt` for backend dependencies:
- fastapi
- uvicorn
- google-cloud-storage
- requests
- scikit-learn

## Logs & CI/CD
- Cloud Build triggers rebuild/deploy on GitHub push
- View logs:

```bash
gcloud run services logs read p4-deploy-backend --region us-central1
```

For detailed deployment steps, see `deploy_runbook.md`.
