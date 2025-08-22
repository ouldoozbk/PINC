from pathlib import Path
from multiprocessing import Pool, cpu_count
from tqdm import tqdm
import json
from utils import process_p4_file, detect_license, inline_local_includes
import re

RAW_ROOT = Path("raw-repositories")
INPUT_FILE = Path("indexed_p4_files.json")
OUTPUT_FILE = Path("p4_ds.json")
# INPUT_FILE = Path("debug/dependency_resolution/in.json")
# OUTPUT_FILE = Path("debug/dependency_resolution/p4_dsddddd.json")

def find_nearest_readme(p4_path: Path, readme_paths: list[Path]) -> Path | None:
    current = p4_path.parent
    while current != RAW_ROOT.parent:
        for r in readme_paths:
            if r.parent == current:
                return r
        current = current.parent
    return None


def load_metadata(repo_root: Path) -> dict:
    metadata_path = repo_root / "metadata.json"
    if metadata_path.exists() and metadata_path.is_file():
        try:
            with open(metadata_path, encoding="utf-8") as f:
                return json.load(f)
        except Exception as e:
            print(f"[!] Failed to load metadata from {metadata_path}: {e}")
    return {}


def process(repo_entry: dict) -> list[dict]:
    repo_path = Path(repo_entry["repo_path"])
    # I check for is_file() because some directories are named readme / license as well
    readme_paths = [Path(p) for p in repo_entry.get("readme_files", []) if Path(p).is_file()]
    license_paths = [Path(p) for p in repo_entry.get("license_files", []) if Path(p).is_file()]
    metadata = load_metadata(repo_path)

    license_from_file = None

    if license_paths:
        try:
            # todo: resolve the license path instead of just picking 0th
            license_text = license_paths[0].read_text(encoding="utf-8", errors="ignore")
            license_from_file = detect_license(license_text)
        except Exception as e:
            print(f"[!] Failed to process LICENSE file {license_paths[0]}: {e}")

    results = []
    # process .p4 files within a repository
    for p4_path_str in repo_entry.get("p4_files", []):
        p4_path = Path(p4_path_str)
        # some paths ending in .p4 are folders, not files, so without this you will see errors
        if not p4_path.is_file():
            continue

        try:
            raw_p4 = p4_path.read_text(encoding="utf-8", errors="ignore")
            # TODO: ADD DEPENDENCY RESOLUTION -> done
            resolved_p4 = inline_local_includes(raw_p4, p4_path.parent)
        except Exception as e:
            print(f"[!] Failed to read {p4_path}: {e}")
            continue

        readme_path = find_nearest_readme(p4_path, readme_paths)
        try:
            raw_readme = (
                readme_path.read_text(encoding="utf-8", errors="ignore")
                if readme_path and readme_path.is_file() else ""
            )
        except Exception as e:
            print(f"[!] Failed to read README {readme_path}: {e}")
            raw_readme = ""

        # cleaned_p4, info = process_p4_file(raw_p4)
        cleaned_p4, info = process_p4_file(resolved_p4)

        cleaned_p4 = re.sub(r'\bmark_to_drop\s*\(\s*\)', 'mark_to_drop(standard_metadata)', cleaned_p4)
        cleaned_p4 = re.sub(r'\bclone3\s*\(', 'clone_preserving_field_list(', cleaned_p4)

        inferred_license = info.get("license")
        inferred_version = info.get("version")

        license_meta = metadata.get("license")
        fallback_license = license_meta.get("spdx_id") if isinstance(license_meta, dict) else None

        if inferred_license:
            final_license = inferred_license
            inferred_from = "P4_FILE"
        elif license_from_file:
            final_license = license_from_file
            inferred_from = "LICENSE_FILE"
        elif fallback_license:
            final_license = fallback_license
            inferred_from = "REPOSITORY_META"
        else:
            final_license = None
            inferred_from = None


        results.append({
            "repo_name": metadata.get("full_name"),
            "desc": metadata.get("description"),
            "repo_path": str(repo_path),
            "p4_version": inferred_version or "unknown",
            "p4_file_path": str(p4_path),
            "readme_path": str(readme_path) if readme_path else None,
            "license": final_license,
            "inferred_from": inferred_from,
            "raw_p4": raw_p4,
            "raw_readme": raw_readme,
            "cleaned_p4": cleaned_p4,
        })


    return results


if __name__ == "__main__":
    with open(INPUT_FILE, encoding="utf-8") as f:
        repo_entries = json.load(f)

    with Pool(cpu_count()) as pool:
        all_results_nested = list(
            tqdm(pool.imap_unordered(process, repo_entries, chunksize=1),
                 total=len(repo_entries),
                 desc="Processing repositories")
        )

    # [ [repo1/file1.p4 object, repo1/file2.p4 object], [repo2/file1.p4 object], ... ] -> [repo1/file1.p4 obj , repo1/file2.p4 obj, ... ]
    all_results = [item for sublist in all_results_nested for item in sublist if item]

    with open(OUTPUT_FILE.with_suffix(".jsonl"), "w", encoding="utf-8") as f:
        for item in all_results:
            f.write(json.dumps(item, ensure_ascii=False) + "\n")

    print(f"Saved {len(all_results)} entries to {OUTPUT_FILE.with_suffix('.jsonl')}")
