import requests
import json
import os
import subprocess
import sys
from multiprocessing import Pool, cpu_count
from tqdm import tqdm

TOKEN = "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"

SAVE_DIR = "raw-repositories"
os.makedirs(SAVE_DIR, exist_ok=True)

STAR_BUCKETS = [
    "stars:>=3",
    "stars:<3",
]

def sanitize_folder_name(full_name):
    return full_name.replace("/", "__")

def is_already_downloaded(repo):
    folder = sanitize_folder_name(repo["full_name"])
    target_dir = os.path.join(SAVE_DIR, folder)
    already_downloaded = os.path.exists(target_dir)
    if already_downloaded:
        print(f"[SKIP] {repo['full_name']} already downloaded.")
    return already_downloaded

def get_p4_repositories_binned_by_stars():
    base_url = "https://api.github.com/search/repositories"
    headers = {
        'Accept': "application/vnd.github+json",
        "Authorization": f"token {TOKEN}"
    }
    per_page = 100

    for bucket in STAR_BUCKETS:
        print(f"\n[INFO] Querying: {bucket}")
        page = 1
        while True:
            params = {
                "q": f"language:p4 {bucket}",
                "per_page": per_page,
                "page": page
            }
            response = requests.get(base_url, headers=headers, params=params)

            if response.status_code != 200:
                print(f"[ERROR] GitHub API returned {response.status_code}: {response.text}")
                break

            data = response.json()
            items = data.get("items", [])

            if not items:
                break

            yield from items

            if len(items) < per_page or page >= 10:  # GitHub caps at 1000 results
                break
            page += 1

def clone_repo_and_save_metadata(repo):
    full_name = repo["full_name"]
    folder = sanitize_folder_name(full_name)
    target_dir = os.path.join(SAVE_DIR, folder)

    if os.path.exists(target_dir):
        return f"[SKIP] {full_name}"

    try:
        subprocess.run(
            ["git", "clone", "--depth", "1", repo["clone_url"], target_dir],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=True
        )
    except subprocess.CalledProcessError:
        return f"[FAIL] {full_name}"

    try:
        with open(os.path.join(target_dir, "metadata.json"), "w", encoding="utf-8") as f:
            json.dump(repo, f, indent=2)
    except Exception as e:
        return f"[FAIL-METADATA] {full_name}: {e}"

    return f"[DONE] {full_name}"

def download_repos_parallel(repo_items, workers=None):
    if workers is None:
        workers = cpu_count()

    repos_to_download = [repo for repo in repo_items if not is_already_downloaded(repo)]
    print(f"\n[INFO] Found {len(repo_items)} total repos, {len(repos_to_download)} to download.")

    if not repos_to_download:
        print("[INFO] All repositories already downloaded.")
        return

    pool = Pool(processes=workers)
    try:
        for result in tqdm(pool.imap_unordered(clone_repo_and_save_metadata, repos_to_download), total=len(repos_to_download), file=sys.stdout):
            if result:
                print(result)
    finally:
        pool.close()
        pool.join()

def main():
    repo_items = list(get_p4_repositories_binned_by_stars())
    download_repos_parallel(repo_items)

if __name__ == '__main__':
    main()
