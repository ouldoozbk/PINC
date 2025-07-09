import requests
import json
import os
import subprocess
from multiprocessing import Pool, cpu_count
from tqdm import tqdm

TOKEN = "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"


def get_p4_repositories(min_forks=None, min_stars=None):
    base_url = "https://api.github.com/search/repositories"

    headers = {
        'Accept': "application/vnd.github+json",
        "Authorization": f"token {TOKEN}"
    }

    min_forks_q_param = " forks:>=" + str(min_forks) + " " if min_forks is not None else ""
    min_stars_q_param = " stars:>=" + str(min_stars) + " " if min_stars is not None else ""

    per_page = 100
    page = 1
    while True:
        print("Getting page", page)

        params = {
            "q": f'language:p4{min_forks_q_param}{min_stars_q_param} ',
            "per_page": per_page,
            "page": page,
        }

        response = requests.get(base_url, headers=headers, params=params)
        data = response.json()

        page_items = data.get("items", [])

        if not page_items or page > 1000 / per_page:
            break

        page += 1
        yield from page_items


def sanitize_folder_name(full_name):
    return full_name.replace("/", "__")


def clone_repo_and_save_metadata(repo):
    # make a folder for the repo

    full_name = repo["full_name"]
    folder = sanitize_folder_name(full_name)
    target_dir = os.path.join(SAVE_DIR, folder)

    if os.path.exists(target_dir):
        print(f"[SKIP] Already exists: {full_name}")
        return

    os.makedirs(target_dir, exist_ok=True)

    # clone the repo using a subprocess
    try:
        subprocess.run(
            ["git", "clone", "--depth", "1", repo["clone_url"], target_dir],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=True
        )
    except subprocess.CalledProcessError:
        print(f"[FAIL] Failed to clone: {full_name}")
        return

    # save the metadata
    with open(os.path.join(target_dir, "metadata.json"), "w", encoding="utf-8") as f:
        json.dump(repo, f, indent=2)


def download_repos_parallel(repo_items, workers=None):
    if workers is None:
        workers = cpu_count()
    with Pool(workers) as pool:
        list(tqdm(pool.imap_unordered(clone_repo_and_save_metadata, repo_items), total=len(repo_items)))


def main():
    SAVE_DIR = "raw-repos"
    os.makedirs(SAVE_DIR, exist_ok=True)
    repo_items = list(get_p4_repositories())
    download_repos_parallel(repo_items)


if __name__ == '__main__':
    main()
