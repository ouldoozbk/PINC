<img width="1043" height="342" alt="image" src="https://github.com/user-attachments/assets/eec7b77d-94c4-49ae-8f8a-296a70b75b6b" />

## How this project works

PINC is a research project that uses LLMs to generate P4 (programmable data-plane) code from high-level intents. The repo has several **independent** parts:

| Part | Location | What it does |
|------|----------|--------------|
| **Intent → P4 wrapper** | `Initial Wrapper Implementation/` | CLI: you type a network intent → LLM generates P4 → Docker validates it. Easiest way to “run” something end-to-end. |
| **Classifier (TF-IDF + SVM)** | `code/engine/classify/` | Trains/uses a classifier on P4 datasets (notebooks). |
| **Fine-tuning** | `code/engine/fine-tuning/` | Instruction-tuning for P4 generation (notebook). |
| **Measurements (FTE/NFTE, CoT, Pass@k)** | `code/measure/`, `code/pass_at_k/` | Evaluation notebooks: zero-shot, few-shot, chain-of-thought, pass@k. |
| **P4 validation server** | `code/server-validation/p4testgen-server/` | FastAPI server that runs P4 validation in Docker containers (used by experiments, not required for the wrapper). |
| **Dataset pipeline** | `dataset/` | Scripts to build/process the P4 dataset (e.g. for training). |

You **do not need Google Colab**. The notebooks were developed in Colab but run fine locally in Jupyter if you install the same dependencies.

---

## How to run

### Option A: Intent → P4 (simplest “run the project”)

This is the only part that works as a single script + Docker.

1. **Prerequisites:** Python 3, Docker Desktop (running), OpenAI API key.
2. **Setup:**
   ```bash
   cd "Initial Wrapper Implementation"
   python3 -m venv venv
   source venv/bin/activate   # Windows: venv\Scripts\activate
   pip install -r requirements.txt
   export OPENAI_API_KEY='your-api-key'
   ```
3. **Run:**
   ```bash
   python3 network_intent_to_p4.py
   ```
   Then enter a network intent when prompted (e.g. “Drop all packets from port 5”).  
   See `Initial Wrapper Implementation/README.md` for details, YANG, and troubleshooting.

### Option B: Run the notebooks (classifier, fine-tuning, Pass@k, etc.)

- **In Google Colab:** Upload the notebook (e.g. from `code/engine/classify/` or `code/pass_at_k/`) to [colab.research.google.com](https://colab.research.google.com) and run. Some cells use `google.colab` (e.g. auth, file upload); those only work in Colab.
- **Locally:** Use Jupyter or VS Code with a Jupyter kernel. From the repo root:
  ```bash
  pip install jupyter datasets transformers torch scikit-learn  # adjust as needed for the notebook
  jupyter notebook
  ```
  Open the notebook you care about and run cells. For Hugging Face–based notebooks, set `HF_TOKEN` or log in via `huggingface-cli login` if required.

### Option C: P4 validation server (for experiments)

Only needed if you’re running experiments that call the validation API.

1. **Prerequisites:** Docker, Python 3.
2. **Setup:** From repo root, install deps and build the container image (see `code/server-validation/p4testgen-server/` for Dockerfile/scripts).
3. **Run:** Start the FastAPI app (e.g. `uvicorn main:app` in that directory). It will start Docker containers and expose a `/validate` endpoint.

---

**Summary:** For “run this project” in the sense of generating P4 from an intent, use **Option A** and you do **not** need Colab. Use Colab only if you want to run the research notebooks in the cloud; otherwise run them locally with Jupyter.
