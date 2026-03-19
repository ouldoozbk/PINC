"""
Scheduled collector: read new generation results from GCS, filter compiled=true,
deduplicate, update canonical dataset + state, and mark retrain readiness.

Designed to be run by Cloud Scheduler -> Cloud Run Job.

Example:
  python tools/training/collect_results_to_dataset.py \
    --bucket YOUR_BUCKET \
    --threshold 500
"""

from __future__ import annotations

import argparse
import hashlib
import json
import time
import uuid
from typing import Dict, Iterable, List, Optional, Set, Tuple

from google.cloud import storage


def _load_json_blob(bucket: storage.Bucket, blob_name: str, default: dict) -> dict:
    blob = bucket.blob(blob_name)
    if not blob.exists():
        return default
    try:
        return json.loads(blob.download_as_text())
    except Exception:
        return default


def _upload_json_blob(bucket: storage.Bucket, blob_name: str, data: dict) -> None:
    bucket.blob(blob_name).upload_from_string(
        json.dumps(data, indent=2, sort_keys=True),
        content_type="application/json",
    )


def _iter_jsonl_lines(text: str) -> Iterable[dict]:
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
            if isinstance(obj, dict):
                yield obj
        except Exception:
            continue


def _is_compiled_true(obj: dict) -> bool:
    verification = obj.get("verification") or {}
    if verification.get("compiled") is True:
        return True
    if obj.get("compiled") is True:
        return True
    return False


def _normalize_text(value: Optional[str]) -> str:
    if not isinstance(value, str):
        return ""
    return "\n".join(line.rstrip() for line in value.strip().splitlines())


def _sample_key(annotation: str, code: str) -> str:
    key = f"{annotation}\n{code}".encode("utf-8")
    return hashlib.md5(key).hexdigest()


def _job_id_from_blob_name(blob_name: str) -> str:
    base = blob_name.rsplit("/", 1)[-1]
    if base.endswith(".json"):
        return base[:-5]
    return base


def _canonical_entry(
    result_obj: dict,
    source_blob_name: str,
    bucket_name: str,
    collector_run_id: str,
) -> Optional[dict]:
    annotation = _normalize_text(result_obj.get("annotation"))
    p4_code = _normalize_text(result_obj.get("p4_code") or result_obj.get("code"))
    if not annotation or not p4_code:
        return None

    source_job_id = str(result_obj.get("job_id") or _job_id_from_blob_name(source_blob_name))
    now = int(time.time())

    return {
        "annotation": annotation,
        "cleaned_p4": p4_code,
        "p4_code": p4_code,
        "intent": result_obj.get("intent"),
        "job_id": source_job_id,
        "record_id": _sample_key(annotation, p4_code),
        "source": "production_generate",
        "collected_at": now,
        "provenance": {
            "source": "production_generate",
            "source_job_id": source_job_id,
            "source_result_blob": source_blob_name,
            "source_result_gcs_uri": f"gs://{bucket_name}/{source_blob_name}",
            "collector_run_id": collector_run_id,
            "verification_compiled": (result_obj.get("verification") or {}).get("compiled"),
            "ingested_at": now,
        },
    }


def _load_existing_keys(bucket: storage.Bucket, canonical_blob: str) -> Tuple[Set[str], str]:
    blob = bucket.blob(canonical_blob)
    if not blob.exists():
        return set(), ""

    text = blob.download_as_text()
    keys: Set[str] = set()
    for obj in _iter_jsonl_lines(text):
        annotation = _normalize_text(obj.get("annotation"))
        code = _normalize_text(obj.get("cleaned_p4") or obj.get("p4_code") or obj.get("code"))
        if annotation and code:
            keys.add(_sample_key(annotation, code))
    return keys, text


def _sorted_result_blobs(
    client: storage.Client,
    bucket: storage.Bucket,
    prefix: str,
    last_processed_object: str,
) -> List[storage.Blob]:
    blobs = [b for b in client.list_blobs(bucket, prefix=prefix) if b.name.endswith(".json")]
    blobs.sort(key=lambda b: b.name)
    if not last_processed_object:
        return blobs
    return [b for b in blobs if b.name > last_processed_object]


def _safe_replace_canonical(bucket: storage.Bucket, canonical_blob: str, merged_text: str) -> None:
    tmp_name = f"{canonical_blob}.tmp-{uuid.uuid4().hex[:8]}"
    tmp_blob = bucket.blob(tmp_name)
    tmp_blob.upload_from_string(merged_text, content_type="application/jsonl")

    dst = bucket.blob(canonical_blob)
    dst.rewrite(tmp_blob)
    tmp_blob.delete()


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--bucket", required=True)
    ap.add_argument("--results_prefix", default="results/")
    ap.add_argument("--canonical_blob", default="training_data/FINAL_p4_ds_clean_comments.jsonl")
    ap.add_argument("--state_blob", default="training_data/state.json")
    ap.add_argument("--batch_prefix", default="training_data/batches/")
    ap.add_argument("--retrain_request_prefix", default="training_data/retrain_requests/")
    ap.add_argument("--threshold", type=int, default=500)
    args = ap.parse_args()

    results_prefix = args.results_prefix if args.results_prefix.endswith("/") else args.results_prefix + "/"
    batch_prefix = args.batch_prefix if args.batch_prefix.endswith("/") else args.batch_prefix + "/"
    retrain_prefix = (
        args.retrain_request_prefix
        if args.retrain_request_prefix.endswith("/")
        else args.retrain_request_prefix + "/"
    )

    client = storage.Client()
    bucket = client.bucket(args.bucket)
    collector_run_id = f"collector-{time.strftime('%Y%m%d-%H%M%S')}-{uuid.uuid4().hex[:8]}"

    state = _load_json_blob(
        bucket,
        args.state_blob,
        default={
            "last_processed_object": "",
            "new_since_last_train": 0,
            "last_train_time": None,
            "retrain_ready": False,
        },
    )

    last_processed = str(state.get("last_processed_object") or "")
    blobs = _sorted_result_blobs(client, bucket, results_prefix, last_processed)
    if not blobs:
        print(json.dumps({"processed": 0, "new_unique": 0, "message": "No new result files."}, indent=2))
        return

    existing_keys, canonical_text = _load_existing_keys(bucket, args.canonical_blob)

    new_entries: List[dict] = []
    processed = 0
    skipped = 0
    max_seen_name = last_processed

    for blob in blobs:
        max_seen_name = blob.name
        processed += 1
        try:
            obj = json.loads(blob.download_as_text())
        except Exception:
            skipped += 1
            continue

        if not isinstance(obj, dict) or not _is_compiled_true(obj):
            skipped += 1
            continue

        entry = _canonical_entry(
            obj,
            source_blob_name=blob.name,
            bucket_name=args.bucket,
            collector_run_id=collector_run_id,
        )
        if not entry:
            skipped += 1
            continue

        key = _sample_key(entry["annotation"], entry["cleaned_p4"])
        if key in existing_keys:
            skipped += 1
            continue

        existing_keys.add(key)
        new_entries.append(entry)

    if new_entries:
        now = time.strftime("%Y%m%d-%H%M%S")
        batch_blob = f"{batch_prefix}batch-{now}-{uuid.uuid4().hex[:8]}.jsonl"
        for idx, entry in enumerate(new_entries):
            entry["provenance"]["batch_blob"] = batch_blob
            entry["provenance"]["batch_gcs_uri"] = f"gs://{args.bucket}/{batch_blob}"
            entry["provenance"]["batch_index"] = idx
        batch_text = "\n".join(json.dumps(e, ensure_ascii=False) for e in new_entries) + "\n"
        bucket.blob(batch_blob).upload_from_string(batch_text, content_type="application/jsonl")

        merged_text = canonical_text
        if merged_text and not merged_text.endswith("\n"):
            merged_text += "\n"
        merged_text += batch_text
        _safe_replace_canonical(bucket, args.canonical_blob, merged_text)

        state["last_batch_blob"] = batch_blob

    state["last_processed_object"] = max_seen_name
    state["new_since_last_train"] = int(state.get("new_since_last_train", 0)) + len(new_entries)
    state["last_collection_time"] = int(time.time())
    state["last_collector_run_id"] = collector_run_id

    retrain_requested = False
    if state["new_since_last_train"] >= args.threshold:
        state["retrain_ready"] = True
        req_name = f"{retrain_prefix}retrain-{time.strftime('%Y%m%d-%H%M%S')}-{uuid.uuid4().hex[:8]}.json"
        req_payload = {
            "reason": "threshold_reached",
            "threshold": args.threshold,
            "new_since_last_train": state["new_since_last_train"],
            "canonical_blob": args.canonical_blob,
            "state_blob": args.state_blob,
            "created_at": int(time.time()),
        }
        _upload_json_blob(bucket, req_name, req_payload)
        state["last_retrain_request"] = req_name
        retrain_requested = True

    _upload_json_blob(bucket, args.state_blob, state)

    print(
        json.dumps(
            {
                "processed": processed,
                "new_unique": len(new_entries),
                "skipped": skipped,
                "last_processed_object": max_seen_name,
                "new_since_last_train": state["new_since_last_train"],
                "retrain_requested": retrain_requested,
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
