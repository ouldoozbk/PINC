<img width="1043" height="342" alt="image" src="https://github.com/user-attachments/assets/eec7b77d-94c4-49ae-8f8a-296a70b75b6b" />

## How this project works

PINC is a research project that uses LLMs to generate P4 (programmable data-plane) code from high-level intents. The repo has several **independent** parts:

| Part | Location | What it does |
|------|----------|--------------|
| **Intent → P4 wrapper** | `backend/` | Flask API + React frontend: type a network intent → LLM generates P4 → VRF A (compile) → VRF A.5 (intent) → VRF B (functional). |
| **Classifier (TF-IDF + SVM)** | `code/engine/classify/` | Trains/uses a classifier on P4 datasets (notebooks). |
| **Fine-tuning** | `code/engine/fine-tuning/` | Instruction-tuning for P4 generation (notebook). |
| **Measurements (FTE/NFTE, CoT, Pass@k)** | `code/measure/`, `code/pass_at_k/` | Evaluation notebooks: zero-shot, few-shot, chain-of-thought, pass@k. |
| **VRF B Docker image** | `code/server-validation/p4testgen-server/` | Dockerfile + scripts for the p4testgen/PTF worker containers (built once, managed by the backend). |
| **Dataset pipeline** | `dataset/` | Scripts to build/process the P4 dataset (e.g. for training). |

You **do not need Google Colab**. The notebooks were developed in Colab but run fine locally in Jupyter if you install the same dependencies.

---

## How to run

### Option A: Intent → P4 (simplest "run the project")

This runs the full pipeline with a web UI.

1. **Prerequisites:**
   - Python 3.9+
   - **Docker Desktop** (must be running) — required for **VRF A** (p4c compilation) and **VRF A.5** (AST-based intent validation). VRF A compiles the generated P4 code inside a `p4lang/p4c` container and writes `ir.json` (the p4c JSON IR). VRF A.5 reads `ir.json` to classify the code into the 9-bucket taxonomy; it will raise an error if Docker has not run.
   - An OpenAI or Replicate API key.

2. **Setup:**
   ```bash
   cd backend
   python3 -m venv venv
   source venv/bin/activate   # Windows: venv\Scripts\activate
   pip install -r requirements.txt
   ```
3. **Start the backend:**
   ```bash
   python api_server.py
   ```
4. **Start the frontend** (in a second terminal):
   ```bash
   cd backend/frontend
   npm install   # first time only
   npm run dev
   ```
5. Open [http://localhost:3000](http://localhost:3000) and use the UI to enter an intent and run the pipeline.

   The pipeline order is: **VRF A** (p4c compile via Docker → writes `ir.json`) → **VRF A.5** (reads `ir.json`, validates intent alignment) → **VRF B** (functional tests, optional).

   See `backend/README.md` for details on VRF stages, YANG support, and troubleshooting.

### Option B: Run the notebooks (classifier, fine-tuning, Pass@k, etc.)

- **In Google Colab:** Upload the notebook (e.g. from `code/engine/classify/` or `code/pass_at_k/`) to [colab.research.google.com](https://colab.research.google.com) and run. Some cells use `google.colab` (e.g. auth, file upload); those only work in Colab.
- **Locally:** Use Jupyter or VS Code with a Jupyter kernel. From the repo root:
  ```bash
  pip install jupyter datasets transformers torch scikit-learn  # adjust as needed for the notebook
  jupyter notebook
  ```
  Open the notebook you care about and run cells. For Hugging Face–based notebooks, set `HF_TOKEN` or log in via `huggingface-cli login` if required.

### Option C: VRF B Docker image (for functional testing)

Only needed if you want VRF B (p4testgen + PTF) functional testing.

1. **Build the image** (one-time):
   ```bash
   cd code/server-validation/p4testgen-server
   docker buildx build --tag p4_test_suite . --load
   ```
2. The container pool is managed from the backend — go to the **VRF B (Functional)** tab in the web UI and click **Start Pool**.

---

**Summary:** For "run this project" in the sense of generating P4 from an intent, use **Option A** and you do **not** need Colab. Use Colab only if you want to run the research notebooks in the cloud; otherwise run them locally with Jupyter.
