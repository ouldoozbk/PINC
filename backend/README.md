# Backend

FastAPI server that runs the intent-to-P4 pipeline (LLM generation, VRF A compilation, VRF A.5 intent validation, VRF B functional testing).

## Prerequisites

- Python 3
- Docker Desktop (running)
- An OpenAI or Replicate API key

## Run

```bash
python3 -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate
pip install -r requirements.txt
```

Set your API key:

```bash
export OPENAI_API_KEY='your-key'
# or
export REPLICATE_API_TOKEN='your-token'
```

Start the server:

```bash
python api_server.py
```

Runs at `http://localhost:5001`.
