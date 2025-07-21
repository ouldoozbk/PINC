import os
import json
import subprocess
from pathlib import Path
from datasets import load_dataset

INPUT_PATH  = "debug/p4_ds_training_ready.jsonl"
OUTPUT_PATH = "debug/p4_ds_training_ready_comp_flag.jsonl"
TEMP_DIR = Path("p4_files")
TEMP_DIR.mkdir(exist_ok=True)

VALIDATE_SCRIPT = str(Path(__file__).parent / "validate.sh")

def compile_worker(example):
    """Run p4c in Docker for one snippet."""
    cleaned_p4 = example["cleaned_p4"]
    file_path = TEMP_DIR / f"tmp_{example["p4_file_path"].replace("/", "_")}.p4"
    file_path.write_text(cleaned_p4)
    result = False
    try:
        subprocess.run(
            [VALIDATE_SCRIPT, file_path.name],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        result = True
    except subprocess.CalledProcessError:
        result = False

    example["compiles"] = result
    return example

def main():
    ds = load_dataset("json", data_files=INPUT_PATH)["train"]
    compiled_ds = ds.map(compile_worker, num_proc=os.cpu_count())

    print(compiled_ds)
    compilable = 0
    for example in compiled_ds:
        if example["compiles"]:
            compilable += 1

    print(f"TOTAL COMPILABLE FILES: {compilable}")

    compiled_ds.to_json(OUTPUT_PATH)

if __name__ == "__main__":
    main()
