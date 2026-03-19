"""
Upload a local JSONL file to GCS as a new immutable batch file.

Example:
  python tools/training/upload_batch_to_gcs.py \
    --bucket YOUR_BUCKET \
    --in training.jsonl \
    --prefix training/incoming/
"""

from __future__ import annotations

import argparse
import time
import uuid
from pathlib import Path

from google.cloud import storage


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bucket", required=True)
    ap.add_argument("--in", dest="in_path", required=True)
    ap.add_argument("--prefix", default="training/incoming/")
    args = ap.parse_args()

    p = Path(args.in_path)
    data = p.read_text(encoding="utf-8").strip()
    if not data:
        raise SystemExit("Input JSONL is empty; nothing to upload.")

    prefix = args.prefix
    if prefix and not prefix.endswith("/"):
        prefix += "/"

    batch_id = f"{int(time.time())}-{uuid.uuid4().hex[:8]}"
    blob_name = f"{prefix}batch-{batch_id}.jsonl"

    client = storage.Client()
    bucket = client.bucket(args.bucket)
    blob = bucket.blob(blob_name)
    blob.upload_from_string(data + "\n", content_type="application/jsonl")

    print(blob_name)


if __name__ == "__main__":
    main()

