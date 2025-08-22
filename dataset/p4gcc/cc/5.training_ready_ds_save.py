from pathlib import Path
import json
# import tiktoken  # pip install tiktoken
from transformers import AutoTokenizer

TOKENIZER = AutoTokenizer.from_pretrained(
    "codellama/CodeLlama-7b-hf", trust_remote_code=True
)
# TOKENIZER = tiktoken.get_encoding("gpt2")  # Change this if using another model


DEDUPED_FILE = Path("p4_ds_deduped.jsonl")
OUTPUT_FILE = Path("p4_ds_training_ready.jsonl")
LINE_THRESHOLD = 20

ALLOWED_LICENSES = {
    "apache-2.0", "mit", "bsd", "bsd-2-clause", "bsd-3-clause", "cc0-1.0", "wtfpl", "gpl",
}


def count_tokens(text: str) -> int:
    return len(TOKENIZER.encode(text))


def filter_and_save(path: Path, out_path: Path, min_lines: int):
    token_counts = []
    skipped_license = skipped_version = saved = 0
    skipped_repos = {}

    with open(path, "r", encoding="utf-8") as fin, open(out_path, "w", encoding="utf-8") as fout:
        for line in fin:
            entry = json.loads(line)

            license_str = str(entry.get("license", "")).strip().lower()
            if license_str not in ALLOWED_LICENSES:
                skipped_license += 1
                repo_name = entry.get("repo_name", "unknown")
                skipped_repos[repo_name] = license_str
                continue

            version = str(entry.get("p4_version", "")).strip().lower()
            if "16" not in version and "unknown" not in version:
                skipped_version += 1
                continue

            code = entry.get("cleaned_p4", "")
            # TODO: BRING THE SHUFFLE LOGIC ELSEWHERE
            if code.strip().count("\n") + 1 < min_lines:
                continue

            if "tna.p4" in code:
                continue

            p4_path = str(entry.get("p4_file_path", "")).lower()
            SKIP_PATH_FRAGMENT = "examples/checker_tests/bad"
            if SKIP_PATH_FRAGMENT in p4_path:
                continue

            token_count = count_tokens(code)
            token_counts.append(token_count)

            fout.write(json.dumps(entry, ensure_ascii=False) + "\n")
            saved += 1

    # Save skipped repos with license info
    skipped_file = out_path.with_name(out_path.stem + "_skipped_repos.jsonl")
    with open(skipped_file, "w", encoding="utf-8") as fskip:
        for repo, license_str in sorted(skipped_repos.items()):
            fskip.write(json.dumps({
                "repo_name": repo,
                "license": license_str
            }) + "\n")

    if not token_counts:
        print("No valid entries found.")
        return

    print(f"Saved training-ready dataset to: {out_path}")
    print(f"Valid entries: {saved}")
    print(f"Skipped due to license: {skipped_license}")
    print(f"Skipped due to non-P4_16: {skipped_version}")
    print(f"Token stats (GPT-2 encoding):")
    print(f"  * Total tokens: {sum(token_counts)}")
    print(f"  * Avg tokens: {sum(token_counts) / len(token_counts):.2f}")
    print(f"  * Min tokens: {min(token_counts)}")
    print(f"  *  Max tokens: {max(token_counts)}")
    print(f"  * Skipped repo list saved to: {skipped_file}")


if __name__ == "__main__":
    filter_and_save(DEDUPED_FILE, OUTPUT_FILE, LINE_THRESHOLD)
