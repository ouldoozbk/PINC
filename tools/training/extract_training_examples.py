"""
Extract training examples from pipeline results JSON and write JSONL.

Input:
  - A file containing JSON objects (one per line), OR
  - A single JSON file containing one object, OR
  - stdin

This filters to compiled==true and outputs JSONL lines like:
  {"text": "### Instruction:\\n<intent>\\n\\n### Response:\\n<p4>\\n<code>\\n</p4>\\n"}

Example:
  python tools/training/extract_training_examples.py --in results.jsonl --out training.jsonl
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from typing import Any, Dict, Iterable, Optional


def _iter_json_objects(text: str) -> Iterable[Dict[str, Any]]:
    text = text.strip()
    if not text:
        return
    # Try JSONL first
    if "\n" in text:
        for line in text.splitlines():
            line = line.strip()
            if not line:
                continue
            yield json.loads(line)
        return
    # Fall back to single JSON object
    yield json.loads(text)


def _compiled_true(obj: Dict[str, Any]) -> bool:
    v = obj.get("verification") or {}
    compiled = v.get("compiled")
    if compiled is True:
        return True
    # Support older shapes, if any
    if obj.get("compiled") is True:
        return True
    return False


def _get_intent_text(obj: Dict[str, Any]) -> Optional[str]:
    # Cloud Run /generate uses "annotation"
    ann = obj.get("annotation")
    if isinstance(ann, str) and ann.strip():
        return ann.strip()
    return None


def _get_p4_code(obj: Dict[str, Any]) -> Optional[str]:
    p4 = obj.get("p4_code") or obj.get("code")
    if isinstance(p4, str) and p4.strip():
        return p4.strip()
    return None


def to_training_text(intent: str, p4_code: str) -> str:
    return (
        "### Instruction:\n"
        f"{intent}\n\n"
        "### Response:\n"
        "<p4>\n"
        f"{p4_code}\n"
        "</p4>\n"
    )


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--in", dest="in_path", default="-", help="Input file path or '-' for stdin")
    ap.add_argument("--out", dest="out_path", required=True, help="Output JSONL path")
    args = ap.parse_args()

    if args.in_path == "-":
        raw = sys.stdin.read()
    else:
        raw = Path(args.in_path).read_text(encoding="utf-8")

    out = Path(args.out_path)
    out.parent.mkdir(parents=True, exist_ok=True)

    written = 0
    skipped = 0
    with out.open("a", encoding="utf-8") as f:
        for obj in _iter_json_objects(raw) or []:
            if not isinstance(obj, dict):
                skipped += 1
                continue
            if not _compiled_true(obj):
                skipped += 1
                continue
            intent = _get_intent_text(obj)
            p4 = _get_p4_code(obj)
            if not intent or not p4:
                skipped += 1
                continue
            entry = {
                "text": to_training_text(intent, p4),
                # Keep a little metadata if present; harmless for training.
                "job_id": obj.get("job_id"),
                "intent_label": obj.get("intent"),
            }
            f.write(json.dumps(entry, ensure_ascii=False) + "\n")
            written += 1

    print(json.dumps({"written": written, "skipped": skipped, "out": str(out)}, indent=2))


if __name__ == "__main__":
    main()

