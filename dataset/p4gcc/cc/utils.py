import re

def break_into_comment_code_blocks(content: str):
    content = re.sub(r'[\n \t\r\u00A0]+$', '\n', content)
    lines = content.splitlines()
    blocks = []

    curr_block = ""
    inline_comment_block = False
    multiline_comment_block = False

    for line in lines:
        stripped = line.strip()

        # --- MULTI-LINE COMMENT START ---
        if stripped.startswith(("/*", "/**")):
            if curr_block:
                blocks.append({"content": curr_block, "is_comment": inline_comment_block})
                curr_block = ""
            curr_block += line + "\n"
            multiline_comment_block = True

            if "*/" in stripped:
                blocks.append({"content": curr_block, "is_comment": True})
                curr_block = ""
                multiline_comment_block = False
            continue

        # --- MULTI-LINE COMMENT BODY ---
        if multiline_comment_block:
            curr_block += line + "\n"
            if "*/" in stripped:
                blocks.append({"content": curr_block, "is_comment": True})
                curr_block = ""
                multiline_comment_block = False
            continue

        # --- FULL-LINE // COMMENT ---
        if stripped.startswith("//"):
            if not inline_comment_block and curr_block:
                blocks.append({"content": curr_block, "is_comment": False})
                curr_block = ""
            curr_block += line + "\n"
            inline_comment_block = True
            continue

        # --- REGULAR CODE OR INLINE // COMMENT ---
        if inline_comment_block:
            blocks.append({"content": curr_block, "is_comment": True})
            curr_block = ""
            inline_comment_block = False

        if '//' in line:
            code_part, comment_part = line.split('//', 1)
            code_part = code_part.rstrip()
            comment_part = '// ' + comment_part.strip()

            if code_part:
                curr_block += code_part + "\n"
                blocks.append({"content": curr_block, "is_comment": False})
                curr_block = ""
            blocks.append({"content": comment_part + "\n", "is_comment": True})
            continue

        curr_block += line + "\n"

    # --- FINALIZE ---
    if curr_block:
        blocks.append({
            "content": curr_block,
            "is_comment": multiline_comment_block or inline_comment_block
        })

    return blocks


def detect_license(text):
    LICENSE_PATTERNS = {
        "proprietary": [
            "all rights reserved",
            "strictly forbidden unless prior written permission is obtained",
            "confidential & proprietary"
        ],
        "gpl": [
            "gnu general public license",
            "general public license",
            "www.gnu.org/licenses",
            "gpl"
        ],
        "cc-by-nd": [
            "creative commons attribution-no derivatives",
            "cc-by-nd"
        ],
        "apache-2.0": [
            "apache license",
            "licensed under the apache license",
            "www.apache.org/licenses",
            "apache-2.0"
        ],
        "bsd": [
            "BSD 3-Clause License",
            "BSD 2-Clause License",
        ],
        "mit": [
            "MIT License",
            "Permission is hereby granted, free of charge"
        ]
    }

    for license_name, patterns in LICENSE_PATTERNS.items():
        for pattern in patterns:
            # print(text)
            if pattern.lower() in text.lower():
                return license_name
    return None


def detect_version(text: str, comment_block: bool) -> str:
    text_lower = text.lower()

    p4_14_signals = ["p4_14"] if comment_block else [
        "#include <core.p4>", "header_type", "field_list",
        "calculate_checksum", "control ingress;", "control egress;"
    ]

    p4_16_signals = ["p4_16"] if comment_block else [
        "bit<", "int<", "extern", "@name", "parser",
        "package", "typedef"
    ]

    if any(sig in text_lower for sig in p4_14_signals):
        return "p4_14"
    if any(sig in text_lower for sig in p4_16_signals):
        return "p4_16"

    return "unknown"


def inspect_for_metadata(blocks):
    ret = {"version": None, "license": None}

    for block in blocks:
        # if it's a comment block, can extract license data, version
        if block["is_comment"]:
            # or serves as a guard operator, if there's already string for ret["license"],
            # and detect_license returns none from other block, it won't be overriden
            ret["license"] = ret["license"] or detect_license(block["content"])
            ret["version"] = ret["version"] or detect_version(block["content"], block["is_comment"])
        # if code block, can extract version data
        else:
            ret["version"] = detect_version(block["content"], block["is_comment"])

    return ret


def is_decorative_comment(comment):
    num_alnum = sum(c.isalnum() for c in comment)
    num_spaces = comment.count(' ')
    return num_alnum != 0 and num_spaces / num_alnum > 1


def clean_comments(blocks):
    """
    :param blocks: [ {content: str, is_comment: bool}, ... ]
    :return: new blocks that have cleaned comments
    """
    new_blocks = []

    for block in blocks:
        if block["is_comment"]:
            # replace occurances of 3 or more -, =, *
            comment = block["content"]
            comment = comment.strip()
            # this is to prevent the start of the comment /* and end */ being also removed in cases like: /***** H E A D E R *****/
            comment = comment.replace('/*', '<<OPEN>>').replace('*/', '<<CLOSE>>')
            # remove trailing ****** , -----, ====== (more than 3 inclusively)
            cleaned_comment = re.sub(r'[=\-*]{3,}', '', comment)
            cleaned_comment = cleaned_comment.replace('<<OPEN>>', '/*').replace('<<CLOSE>>', '*/')

            # license filtering keywords
            license_keywords = ["license", "copyright", "gnu", "apache", "bsd", "mit license",
                                "SPDX-License-Identifier"]

            # remove license block
            if any(keyword.lower() in block["content"].lower() for keyword in license_keywords):
                continue

            # handle decorative comments very prevalent in p4 code bases
            if is_decorative_comment(cleaned_comment):
                # 3 or more spaces -> separates a word
                cleaned_comment = re.sub(r' {3,}', '<<<TEMP>>>', cleaned_comment)
                # up to 3 (exclusively) -> separates a character of a word
                cleaned_comment = re.sub(r' {1,2}', '', cleaned_comment)
                cleaned_comment = cleaned_comment.replace('<<<TEMP>>>', ' ')
                cleaned_comment = cleaned_comment.lower()

            new_blocks.append({"content": cleaned_comment, "is_comment": True})
        else:
            new_blocks.append(block)

    return new_blocks


def process_p4_file(content):
    blocks = break_into_comment_code_blocks(content)
    meta = inspect_for_metadata(blocks)
    cleaned_blocks = clean_comments(blocks)

    ret = ""
    for block in cleaned_blocks:
        ret = ret + "\n" + block["content"]

    ret = ret.strip("\n")

    return ret, meta


# normalize_p4_vars done via GPT
P4_KEYWORDS = {
    "action", "apply", "bit", "bool", "const", "control", "default", "else", "enum",
    "error", "extern", "false", "header", "header_union", "if", "in", "inout", "int",
    "key", "match_kind", "parser", "packet_in", "packet_out", "return", "select",
    "state", "struct", "switch", "table", "transition", "true", "typedef", "varbit",
    "verify", "void", "out", "this", "default", "type", "value_set"
}

def normalize_p4_vars(code: str):
    # Find all words that could be identifiers
    tokens = re.findall(r'\b[a-zA-Z_][a-zA-Z0-9_]*\b', code)

    replacements = {}
    var_index = 1
    for token in tokens:
        if token in P4_KEYWORDS:
            continue
        if token not in replacements:
            replacements[token] = f'v{var_index}'
            var_index += 1

    # Replace identifiers (whole word only)
    def replace_identifier(match):
        word = match.group(0)
        return replacements.get(word, word)

    normalized = re.sub(r'\b[a-zA-Z_][a-zA-Z0-9_]*\b', replace_identifier, code)
    return normalized


def normalize_for_deduplication(code: str):
    blocks = break_into_comment_code_blocks(code)
    just_code = ""
    for block in blocks:
        if not block["is_comment"]:
            just_code += block["content"] + "\n"

    # # this is a good stage to normalize vars:
    just_code = normalize_p4_vars(just_code)

    replace_to_empty_str = ["\n", "\r", "\t", " "]
    for ch in replace_to_empty_str:
        just_code = just_code.replace(ch, '')

    return just_code