from pathlib import Path
import json
from tqdm import tqdm
from simhash import Simhash
from collections import defaultdict
from utils import normalize_for_deduplication

# Configurable paths
INPUT_FILE = Path("p4_ds.jsonl")
DEDUPED_OUTPUT_FILE = Path("p4_ds_deduped.jsonl")
DUPLICATE_LOG_FILE = Path("duplicates_log.json")

# SimHash + deduplication config
SHINGLE_N = 4
LSH_PREFIX_BITS = 16
DISTANCE_THRESHOLD = 4

def compute_simhash(code: str, n: int = SHINGLE_N) -> Simhash:
    shingles = [code[i:i+n] for i in range(len(code) - n + 1)] # todo: what if file not multiple of shingle?
    return Simhash(shingles)

def load_entries(path: Path):
    with open(path, "r", encoding="utf-8") as f:
        return [json.loads(line) for line in f if line.strip()]

def deduplicate_with_full_check(entries):
    buckets = defaultdict(list)
    retained_hashes = []
    deduped = []
    duplicate_log = []

    for entry in tqdm(entries, desc="Deduplicating (transitive-safe)"):
        raw = entry.get("raw_p4", "")
        # remove ALL comments, remove ALL spaces, \n, \r, \t, normalize variables
        norm = normalize_for_deduplication(raw)

        if len(norm) < SHINGLE_N:
            continue

        simhash = compute_simhash(norm)

        # LSH from here
        hash_val = simhash.value
        prefix = hash_val >> (64 - LSH_PREFIX_BITS)

        is_duplicate = False
        for prior_val in retained_hashes:
            dist = simhash.distance(Simhash(prior_val))
            if dist <= DISTANCE_THRESHOLD:
                duplicate_log.append({
                    "duplicate_file": entry["p4_file_path"],
                    "duplicate_of": "matched retained file",
                    "distance": dist
                })
                is_duplicate = True
                break

        if not is_duplicate:
            retained_hashes.append(hash_val)
            buckets[prefix].append((hash_val, entry))
            deduped.append(entry)

    return deduped, duplicate_log

if __name__ == "__main__":
    entries = load_entries(INPUT_FILE)
    deduped_entries, duplicate_log = deduplicate_with_full_check(entries)

    with open(DEDUPED_OUTPUT_FILE, "w", encoding="utf-8") as f:
        for entry in deduped_entries:
            f.write(json.dumps(entry, ensure_ascii=False) + "\n")

    with open(DUPLICATE_LOG_FILE, "w", encoding="utf-8") as f:
        json.dump(duplicate_log, f, indent=2)

    print(f"Deduplicated: {len(deduped_entries)} entries (from {len(entries)})")
    print(f"Duplicates logged: {len(duplicate_log)} → {DUPLICATE_LOG_FILE}")
