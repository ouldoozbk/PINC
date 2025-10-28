from datasets import load_dataset
import os
import re

dataset = load_dataset("json", data_files="FINAL_p4_ds_clean_comments.jsonl")["train"]

output_dir = "individual_files/individual_files"
os.makedirs(output_dir, exist_ok=True)

def sanitize_filename(name: str) -> str:
    # replace slashes with double underscores
    name = name.replace("/", "__")
    return re.sub(r"[^a-zA-Z0-9._-]", "_", name)

def save_example(example, idx):
    repo_path = example["repo_path"]
    cleaned_p4 = example["cleaned_p4"]

    if cleaned_p4 is None or repo_path is None:
        return example

    filename = f"{idx:06d}__{sanitize_filename(repo_path)}.p4"
    file_path = os.path.join(output_dir, filename)

    with open(file_path, "w", encoding="utf-8") as f:
        f.write(cleaned_p4)

    return example

dataset.map(save_example, with_indices=True, num_proc=os.cpu_count())



