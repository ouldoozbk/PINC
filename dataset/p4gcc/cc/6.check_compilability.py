import os
import json
import subprocess
from pathlib import Path
from datasets import load_dataset
import requests, json, textwrap

# INPUT_PATH  = "debug/p4_ds_training_ready.jsonl"
# OUTPUT_PATH = "debug/p4_ds_training_ready_comp_flag.jsonl"

INPUT_PATH = "p4_ds_training_ready.jsonl"
OUTPUT_PATH = "p4_ds_training_ready_comp_flag.jsonl"

TEMP_DIR = Path("p4_files")
TEMP_DIR.mkdir(exist_ok=True)

VALIDATE_SCRIPT = str(Path(__file__).parent / "validate.sh")
print(VALIDATE_SCRIPT)

def compile_p4(code: str):
    IP = "34.55.163.44"  # your VM public IP
    PORT = 8000

    BASE_URL = f"http://{IP}:{PORT}"
    SUBMIT_URL = f"{BASE_URL}/submit"
    HEALTH_URL = f"{BASE_URL}/healthz"

    for i in range(10):
        try:
            resp = requests.post(
                SUBMIT_URL,
                json={"code": code},
                timeout=(3.0, 360)
            )
            if resp.status_code == 400:
                print(f"400 Error Details: {resp.text}")
                print(f"Request size: {len(json.dumps({'code': code}))} bytes")
                print(f"Code length: {len(code)} characters")
            resp.raise_for_status()
            return resp.json()
        except (requests.exceptions.ConnectTimeout,
                requests.exceptions.ReadTimeout,
                requests.exceptions.ConnectionError) as e:
            if i == 9:
                raise


def compile_worker(example):
    """Run p4c in Docker for one snippet."""
    cleaned_p4 = example["cleaned_p4"]

    result = False

    MAX_ATTEMPTS = 5
    attempts = 0
    while attempts < MAX_ATTEMPTS:
        try:
            result = compile_p4(cleaned_p4)["ok"]
            break
        except Exception as e:
            print("Exception has occurred: ", e)
            attempts += 1
            continue

    example["compiles"] = result

    if result:
        print("[COMPILED] ", example["repo_name"])

    return example


def main():
    ds = load_dataset("json", data_files=INPUT_PATH)["train"]
    compiled_ds = ds.map(compile_worker, num_proc=os.cpu_count() * 2)

    print(compiled_ds)
    compilable = 0
    for example in compiled_ds:
        if example["compiles"]:
            compilable += 1

    print(f"TOTAL COMPILABLE FILES: {compilable}")

    compiled_ds.to_json(OUTPUT_PATH)


if __name__ == "__main__":
    main()
