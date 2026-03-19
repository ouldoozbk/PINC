"""
Validate and summarize canonical dataset schema after collection/rebuild.

This helps confirm:
- legacy mined rows vs new production rows,
- provenance coverage,
- whether rows are usable for finetuning (annotation + code).

Examples:
  python tools/training/validate_canonical_dataset.py --in FINAL_p4_ds_clean_comments.jsonl

  python tools/training/validate_canonical_dataset.py \
    --bucket YOUR_BUCKET \
    --blob training_data/FINAL_p4_ds_clean_comments.jsonl
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path
from typing import Dict, Iterable, Optional

from google.cloud import storage


def _iter_jsonl(text: str) -> Iterable[dict]:
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
        except Exception:
            continue
        if isinstance(obj, dict):
            yield obj


def _norm_str(v: object) -> str:
    return v.strip() if isinstance(v, str) else ""


def _training_code(row: dict) -> str:
    # Prefer cleaned_p4 when present, then p4_code, then raw_p4 (legacy rows).
    return _norm_str(row.get("cleaned_p4")) or _norm_str(row.get("p4_code")) or _norm_str(row.get("raw_p4"))


def _is_new_row(row: dict) -> bool:
    if row.get("source") == "production_generate":
        return True
    prov = row.get("provenance")
    return isinstance(prov, dict) and bool(prov)


def _load_from_gcs(bucket_name: str, blob_name: str) -> str:
    client = storage.Client()
    bucket = client.bucket(bucket_name)
    blob = bucket.blob(blob_name)
    if not blob.exists():
        raise SystemExit(f"Blob not found: gs://{bucket_name}/{blob_name}")
    return blob.download_as_text()


def _load_text(in_path: Optional[str], bucket: Optional[str], blob: Optional[str]) -> str:
    if in_path:
        return Path(in_path).read_text(encoding="utf-8")
    if bucket and blob:
        return _load_from_gcs(bucket, blob)
    raise SystemExit("Provide either --in OR both --bucket and --blob")


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--in", dest="in_path", help="Local canonical JSONL path")
    ap.add_argument("--bucket", help="GCS bucket")
    ap.add_argument("--blob", help="GCS blob path")
    ap.add_argument("--show_examples", type=int, default=2, help="How many bad-row examples to print")
    args = ap.parse_args()

    text = _load_text(args.in_path, args.bucket, args.blob)

    total = 0
    new_rows = 0
    legacy_rows = 0
    trainable_rows = 0

    missing_annotation = 0
    missing_code = 0
    missing_provenance_new = 0

    bad_examples = []

    for row in _iter_jsonl(text):
        total += 1

        annotation = _norm_str(row.get("annotation"))
        code = _training_code(row)
        is_new = _is_new_row(row)

        if is_new:
            new_rows += 1
            if not isinstance(row.get("provenance"), dict):
                missing_provenance_new += 1
        else:
            legacy_rows += 1

        ok = True
        if not annotation:
            missing_annotation += 1
            ok = False
        if not code:
            missing_code += 1
            ok = False

        if ok:
            trainable_rows += 1
        elif len(bad_examples) < args.show_examples:
            bad_examples.append(
                {
                    "annotation_present": bool(annotation),
                    "code_present": bool(code),
                    "source": row.get("source"),
                    "job_id": row.get("job_id"),
                    "repo_name": row.get("repo_name"),
                    "has_provenance": isinstance(row.get("provenance"), dict),
                }
            )

    summary = {
        "rows_total": total,
        "rows_new": new_rows,
        "rows_legacy": legacy_rows,
        "rows_trainable": trainable_rows,
        "missing_annotation": missing_annotation,
        "missing_training_code": missing_code,
        "new_rows_missing_provenance": missing_provenance_new,
        "trainable_ratio": (trainable_rows / total) if total else 0.0,
        "notes": [
            "Finetuning should use annotation + (cleaned_p4 or p4_code or raw_p4 fallback).",
            "Provenance is recommended for new rows, not required for legacy rows.",
        ],
        "bad_row_examples": bad_examples,
    }

    print(json.dumps(summary, indent=2))


if __name__ == "__main__":
    main()
