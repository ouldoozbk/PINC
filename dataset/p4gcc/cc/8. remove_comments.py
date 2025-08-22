from datasets import load_dataset
from utils import break_into_comment_code_blocks
import re
import os

def is_english(comment: str) -> bool:
    cleaned = comment.strip()
    return all(32 <= ord(c) <= 126 for c in cleaned)

dirty_comment_list = [
    "/*  P4_16  */", "END", "BEGIN",
    "TODO", "=", "^", "hdr", "ipv4",
    "tcp", "@", "bit<", "DEBUG", "pkt",
    "()", "#define", "merge_to", "0x",
    "const", ".emit(", "https:", "if(",
    "[", "WITH", "unresolved", "FIXME",
    "_", "////", ".h", "assignment", " NV",
    "http:", "24 bits", "debug"]

def filter_comments(example):

    new_code = ""

    code = example["cleaned_p4"]
    blocks = break_into_comment_code_blocks(code)
    for block in blocks:
        if block["is_comment"]:
            if (len(block["content"].split(" ")) < 20
                    and not any(sub in block["content"] for sub in dirty_comment_list)
                    and not block["content"].strip(" */'").replace("\n", "").isnumeric()
                    and is_english(block["content"])):

                new_code += block["content"]
            else:
                continue
        else:
            new_code += block["content"]


    example["cleaned_p4"] = new_code
    return example


ds = load_dataset("json", data_files="FINAL_p4_ds.jsonl")["train"]

ds_comment_filtered = ds.map(filter_comments, num_proc=os.cpu_count() *2)
# print(ds_comment_filtered)

ds_comment_filtered.to_json("FINAL_p4_ds_clean_comments.jsonl", lines=True, orient="records")