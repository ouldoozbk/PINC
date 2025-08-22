import os

from huggingface_hub import login
from huggingface_hub import HfApi

login("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")
api = HfApi()

DS_PATH = "FINAL_p4_ds_clean_comments.jsonl"
DS_INDIVIDUAL_FILES_FOLDER = "individual_files"

print(" 1/2 Uploading the .jsonl")
api.upload_file(
    path_or_fileobj=DS_PATH,
    path_in_repo="p4_dataset.jsonl",
    repo_id="SFU-CONNECT/p4_dataset",
    repo_type="dataset",
)

print(" 2/2 Uploading the individual files folder")

api.upload_large_folder(
    folder_path="individual_files",
    repo_id="SFU-CONNECT/p4_dataset",
    repo_type="dataset",
    num_workers=os.cpu_count()
)