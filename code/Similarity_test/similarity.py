#!/usr/bin/env python3
"""Extract every string snippet from each Pass@k pickle and dump to disk."""

import glob
import os
import pickle
from typing import Any, Iterable, List

PKL_DIR = "passk_results"
OUTPUT_DIR = "generated_snippets"


class SafeUnpickler(pickle.Unpickler):
    """Stub out missing modules (e.g. vllm) while loading pickles."""

    def find_class(self, module, name):
        try:
            return super().find_class(module, name)
        except ModuleNotFoundError:

            class Stub:
                def __init__(self, *args, **kwargs):
                    pass

                def __repr__(self):
                    return f"<Stub {module}.{name}>"

            return Stub


def load_pickle(path: str) -> Any:
    with open(path, "rb") as fh:
        try:
            return pickle.load(fh)
        except ModuleNotFoundError as exc:
            print(f"  Missing module while unpickling ({exc}). Retrying with SafeUnpickler.")
            fh.seek(0)
            return SafeUnpickler(fh).load()


def extract_snippets(obj: Any) -> Iterable[str]:
    if isinstance(obj, str):
        yield obj
        return

    if isinstance(obj, (list, tuple)):
        for item in obj:
            yield from extract_snippets(item)
        return

    if isinstance(obj, dict):
        for value in obj.values():
            yield from extract_snippets(value)
        return

    if hasattr(obj, "__dict__"):
        for value in obj.__dict__.values():
            yield from extract_snippets(value)
        return


def dump_snippets(snippets: List[str], base_name: str) -> None:
    dump_dir = os.path.join(OUTPUT_DIR, base_name)
    os.makedirs(dump_dir, exist_ok=True)

    for idx, snippet in enumerate(snippets):
        out_path = os.path.join(dump_dir, f"snippet_{idx:03d}.p4")
        with open(out_path, "w", encoding="utf-8") as fh:
            fh.write(snippet.strip())


def main() -> None:
    pkl_files = sorted(glob.glob(os.path.join(PKL_DIR, "*.pkl")))
    if not pkl_files:
        print(f"No .pkl files found in {PKL_DIR}")
        return

    os.makedirs(OUTPUT_DIR, exist_ok=True)

    for pkl_path in pkl_files:
        print(f"\nExtracting from {os.path.basename(pkl_path)}...")
        obj = load_pickle(pkl_path)
        snippets = [s for s in extract_snippets(obj) if s.strip()]
        print(f"  found {len(snippets)} snippets")
        base_name = os.path.splitext(os.path.basename(pkl_path))[0]
        dump_snippets(snippets, base_name)
        print(f"  wrote to {os.path.join(OUTPUT_DIR, base_name)}")


if __name__ == "__main__":
    main()
