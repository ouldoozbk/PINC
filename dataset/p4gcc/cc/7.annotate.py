import os, json, re, time, sys
from pathlib import Path
from groq import Groq
from tqdm import tqdm
from datasets import load_dataset

API_KEY = "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"
# MODEL = "meta-llama/llama-4-maverick-17b-128e-instruct"
MODEL = "meta-llama/llama-4-scout-17b-16e-instruct"

MAX_CHARS = 100000

TEMPERATURE = 0.4
MAX_TOKENS = 512

client = Groq(api_key=API_KEY)


def build_prompt(cleaned_p4):
    prompt = f"""
    You are an expert in the P4 programming language. Given a compilable P4 program, summarize its behavior at two levels of abstraction for use in a code generation dataset:

    1. A single high-level task description enclosed in <DESC>...</DESC>. This should state the program’s main purpose in 25 words or fewer, starting with a verb like “Implement”, “Create”, or “Design”. Be concise and avoid vague phrases like “modify headers” or “specific logic”.

    2. A list of important technical details about the implementation, enclosed in <DETAILS>...</DETAILS>. Each bullet should describe one non-trivial mechanism or behavior used by the program, such as protocol-specific parsing, state tracking, checksum computation, or packet transformation. Use 3–6 bullet points. Do not include obvious boilerplate.

    Output format:
    <DESC>Your high-level instruction here</DESC>
    <DETAILS>
    - Detail 1
    - Detail 2
    - Detail 3
    </DETAILS>

    Only return the <DESC> and <DETAILS> sections. Do not include the code.

    Here is the program:

    {cleaned_p4}
    """

    if len(prompt) > MAX_CHARS:
        print("truncating \n")
        prompt = prompt[:MAX_CHARS]

    return prompt


def annotate(example):

    prompt = build_prompt(example["cleaned_p4"])
    prompt

    resp = client.chat.completions.create(
        model=MODEL,
        temperature=TEMPERATURE,
        max_tokens=MAX_TOKENS,
        messages=[{"role": "system", "content": prompt}],
    )

    text = resp.choices[0].message.content.strip()

    desc_match = re.search(r"<DESC>(.*?)</DESC>", text, re.DOTALL)
    desc = desc_match.group(1).strip() if desc_match else None

    details_match = re.search(r"<DETAILS>(.*?)</DETAILS>", text, re.DOTALL)
    details_raw = details_match.group(1).strip() if details_match else ""
    details = [line.strip("-–* ").strip() for line in details_raw.splitlines() if line.strip()]

    example["annotation"] = desc
    example["detailed_annotation"] = details

    return example


def main():
    ds = load_dataset("json", data_files="p4_ds_training_ready_comp_flag.jsonl")["train"]
    annotated_ds = ds.map(annotate, num_proc=1)
    annotated_ds.to_json("FINAL_p4_ds.jsonl")


if __name__ == "__main__":
    main()
