"""
Find provenance links for a given job_id.

Input:
  --bucket <GCS bucket>
  --job_id <job_id>

Output:
  JSON with canonical row matches and, when available:
  - source result blob
  - batch blob
  - collector run id

Works even if older canonical rows do not have provenance fields.
"""

from __future__ import annotations

import argparse
import json
from typing import Dict, List

from google.cloud import storage


def _iter_jsonl(text: str):
    for idx, line in enumerate(text.splitlines(), start=1):
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
        except Exception:
            continue
        if isinstance(obj, dict):
            yield idx, obj


def _load_blob_text(bucket: storage.Bucket, blob_name: str) -> str:
    blob = bucket.blob(blob_name)
    if not blob.exists():
        return ""
    return blob.download_as_text()


def _find_candidate_source_blobs(
    client: storage.Client,
    bucket: storage.Bucket,
    results_prefix: str,
    job_id: str,
) -> List[str]:
    prefix = results_prefix if results_prefix.endswith("/") else results_prefix + "/"
    suffix = f"/{job_id}.json"
    matches: List[str] = []
    for blob in client.list_blobs(bucket, prefix=prefix):
        name = blob.name
        if name.endswith(suffix) or name == f"{prefix}{job_id}.json":
            matches.append(name)
    matches.sort()
    return matches


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bucket", required=True)
    ap.add_argument("--job_id", required=True)
    ap.add_argument("--canonical_blob", default="training_data/FINAL_p4_ds_clean_comments.jsonl")
    ap.add_argument("--results_prefix", default="results/user_results/")
    args = ap.parse_args()

    client = storage.Client()
    bucket = client.bucket(args.bucket)

    canonical_text = _load_blob_text(bucket, args.canonical_blob)
    if not canonical_text:
        print(
            json.dumps(
                {
                    "job_id": args.job_id,
                    "canonical_blob": args.canonical_blob,
                    "matches": [],
                    "note": "Canonical dataset blob not found or empty.",
                },
                indent=2,
            )
        )
        return

    matches: List[Dict] = []
    for line_number, row in _iter_jsonl(canonical_text):
        provenance = row.get("provenance") if isinstance(row.get("provenance"), dict) else {}
        row_job_id = str(row.get("job_id") or "")
        prov_job_id = str(provenance.get("source_job_id") or "")

        if args.job_id not in {row_job_id, prov_job_id}:
            continue

        matches.append(
            {
                "canonical_line": line_number,
                "job_id": row_job_id or prov_job_id,
                "record_id": row.get("record_id"),
                "source_result_blob": provenance.get("source_result_blob"),
                "source_result_gcs_uri": provenance.get("source_result_gcs_uri"),
                "batch_blob": provenance.get("batch_blob"),
                "collector_run_id": provenance.get("collector_run_id"),
                "has_provenance": bool(provenance),
            }
        )

    discovered_source_blobs = _find_candidate_source_blobs(
        client=client,
        bucket=bucket,
        results_prefix=args.results_prefix,
        job_id=args.job_id,
    )

    print(
        json.dumps(
            {
                "job_id": args.job_id,
                "canonical_blob": args.canonical_blob,
                "match_count": len(matches),
                "matches": matches,
                "candidate_source_blobs": discovered_source_blobs,
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
