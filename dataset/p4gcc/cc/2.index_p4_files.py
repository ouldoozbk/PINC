from pathlib import Path
from multiprocessing import Pool, cpu_count
from tqdm import tqdm
import json

RAW_ROOT = Path("raw-repos")
OUTPUT_FILE = Path("indexed_p4_files.json")

README_NAMES = {"readme", "readme.md", "readme.txt"}
LICENSE_NAMES = {"LICENSE", "license", "LICENSE.txt", "COPYING", "COPYRIGHT"}

def get_all_repos(raw_root: Path):
    return [d for d in raw_root.iterdir() if d.is_dir()]


def index_repo(repo_dir: Path) -> dict:
    p4_files = [str(p) for p in repo_dir.rglob("*.p4") if p.is_file()]

    readme_files = [
        str(p) for p in repo_dir.rglob("*")
        if p.name.lower() in README_NAMES and p.is_file() #verify that it works
    ]

    license_files = [
        str(repo_dir / name) for name in LICENSE_NAMES # todo: lower() check?
        if (repo_dir / name).exists() and (repo_dir / name).is_file()
    ]

    return {
        "repo_path": str(repo_dir),
        "p4_files": p4_files,
        "readme_files": readme_files,
        "license_files": license_files
    }


if __name__ == "__main__":
    repos = get_all_repos(RAW_ROOT)

    with Pool(cpu_count()) as pool:
        indexed = list(
            tqdm(pool.imap(index_repo, repos), total=len(repos), desc="Indexing repos")
        )

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        json.dump(indexed, f, indent=2, ensure_ascii=False)

    total_p4 = sum(len(repo["p4_files"]) for repo in indexed)
    print(f"Indexed {total_p4} .p4 files across {len(indexed)} repos into {OUTPUT_FILE}")
