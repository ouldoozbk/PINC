"""
Generate the eval dataset seed file from FINAL_p4_ds_clean_comments.jsonl.
Each JSONL entry's `annotation` becomes the intent; p4_code starts blank (generated later).

Run once:  python3 backend/generate_eval_dataset.py
Then use the Eval Dataset tab to generate P4 for each intent and annotate.
"""

import csv, json
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
OUT_CSV  = PROJECT_ROOT / "eval_dataset.csv"
OUT_JSON = PROJECT_ROOT / "eval_dataset.json"
JSONL_PATH = PROJECT_ROOT / "dataset" / "p4gcc" / "data" / "FINAL_p4_ds_clean_comments.jsonl"


def load_from_jsonl():
    cases = []
    with open(JSONL_PATH) as f:
        for i, line in enumerate(f):
            entry = json.loads(line)
            annotation = (entry.get("annotation") or "").strip()
            if not annotation:
                continue
            ground_truth = (entry.get("cleaned_p4") or entry.get("raw_p4") or "").strip()
            cases.append({
                "id":              i + 1,
                "jsonl_index":     i,
                "bucket":          entry.get("bucket", "general"),
                "intent":          annotation,
                "ground_truth_p4": ground_truth,
                "p4_code":         "",
                "vrf_a_passed":    None,
                "attempts":        None,
                "your_label":      "",
                "notes":           "",
            })
    return cases


cases = load_from_jsonl()

csv_fields = ["id", "bucket", "intent", "vrf_a_passed", "your_label", "notes"]
with open(OUT_CSV, "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=csv_fields)
    w.writeheader()
    for c in cases:
        w.writerow({k: c[k] for k in csv_fields})

with open(OUT_JSON, "w") as f:
    json.dump(cases, f, indent=2)

print(f"Generated {len(cases)} intent-only cases from JSONL → eval_dataset.json")
print("Next: open the Eval Dataset tab and click 'Generate P4' on each card.")
