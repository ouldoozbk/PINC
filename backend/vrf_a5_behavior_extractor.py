"""
VRF A.5: Behavior Extractor — Walk the p4c JSON IR and produce actual_behavior.json.

Bucket classification uses sentence-transformer embeddings (all-MiniLM-L6-v2) over a
natural-language serialisation of the AST feature dict extracted from ir.json (written
by the p4test --toJSON step in vrf_a_compile.sh).  The model and template embeddings
are cached in vrf_a5_semantic_router module globals — no second model load.

If ir.json is absent (p4test step unavailable), buckets/headers/control_blocks are
left empty and only suspicious_patterns (source-text regex) is populated.
"""

from __future__ import annotations

import json
import re
import uuid
from datetime import datetime, timezone
from typing import Dict, List, Optional, Set

import numpy as np

import requests

from vrf_a5_ast_parser import features_from_ir_file
from vrf_a5_bucket_taxonomy import BUCKETS
from vrf_a5_semantic_router import (
    SIMILARITY_THRESHOLD,
    _get_template_embeddings,
    _load_model,
)


def _detect_suspicious_patterns(code: str) -> List[str]:
    """Detect patterns matching prohibited_behaviors in the intent spec."""
    suspicious: List[str] = []
    if re.search(r'default_action\s*=\s*\w*drop\w*\s*', code, re.IGNORECASE):
        suspicious.append("packet_drop_by_default")
    if re.search(r'\b(hardcoded|static\s+route)\b', code, re.IGNORECASE):
        suspicious.append("static_routing")
    return suspicious


def _features_to_description(features: dict) -> str:
    """
    Convert extracted IR features into natural-language behavioral prose.

    Interprets primitives and header patterns semantically — detects encapsulation
    from outer/inner header pairs and add_header ops, forwarding from egress_spec
    assignments, filtering from mark_to_drop, etc. Output is sentence-structured
    prose that embeds in the same region of semantic space as natural-language
    intent text and LLM prompts.
    """
    parts: List[str] = []

    header_names  = features.get("header_names", [])
    action_ops    = set(features.get("action_ops", []))
    action_names  = features.get("action_names", [])
    key_fields    = features.get("table_key_fields", [])
    extern_types  = features.get("extern_types", [])
    control_names = features.get("control_names", [])

    # Strip _t suffix to recover protocol names the model understands
    protocols = [re.sub(r'_t$', '', h) for h in header_names]

    # --- Encapsulation ---
    TUNNEL_PROTOCOLS = {
        "gre", "vxlan", "geneve", "mpls", "esp",
        "ah", "ipip", "udp", "nvgre", "vxlan_gpe",
    }
    outer_headers    = [h for h in header_names if "outer" in h.lower()]
    inner_headers    = [h for h in header_names if "inner" in h.lower()]
    found_tunnels    = [p for p in protocols if p in TUNNEL_PROTOCOLS]
    encap_action_kws = ("encap", "tunnel", "decap", "wrap",
                        "add_gre", "add_vxlan", "push_header")
    encap_actions    = [n for n in action_names
                        if any(k in n.lower() for k in encap_action_kws)]

    if (outer_headers and inner_headers) \
            or ("add_header" in action_ops and found_tunnels) \
            or encap_actions:
        tunnel_str = ', '.join(found_tunnels) if found_tunnels else "tunnel"
        parts.append(
            f"This program encapsulates or decapsulates packets using "
            f"{tunnel_str} tunnel headers, wrapping inner packets inside "
            f"an outer header for tunneling across networks."
        )

    # --- Forwarding ---
    fwd_key_kws  = ("dstAddr", "dst", "nhop", "egress_spec")
    fwd_act_kws  = ("forward", "route", "nhop", "set_port", "set_egress")
    fwd_keys     = [f for f in key_fields if any(k in f for k in fwd_key_kws)]
    fwd_actions  = [n for n in action_names
                    if any(k in n.lower() for k in fwd_act_kws)]
    if fwd_keys or fwd_actions or "assign" in action_ops:
        parts.append(
            "It forwards packets by matching destination addresses and "
            "setting the output port."
        )

    # --- Filtering / drop ---
    if "mark_to_drop" in action_ops:
        parts.append(
            "It filters and drops packets that do not match forwarding rules."
        )

    # --- Label / tag operations ---
    LABEL_PROTOCOLS = {"mpls", "vlan"}
    label_act_kws   = ("push", "pop", "tag", "label", "vlan", "mpls", "swap")
    found_labels    = [p for p in protocols if p in LABEL_PROTOCOLS]
    label_actions   = [n for n in action_names
                       if any(k in n.lower() for k in label_act_kws)]
    if found_labels or label_actions:
        parts.append(
            f"It applies label or tag operations "
            f"({', '.join(found_labels + label_actions)}) "
            f"for MPLS or VLAN traffic classification and switching."
        )

    # --- Monitoring / cloning ---
    EXTERN_MONITOR = {"counter", "meter", "register"}
    if any(e in extern_types for e in EXTERN_MONITOR):
        parts.append(
            "It uses stateful externs (counters, meters, or registers) "
            "for traffic monitoring or rate limiting."
        )
    clone_kws     = ("clone", "mirror", "digest", "recirculate")
    clone_actions = [n for n in action_names
                     if any(k in n.lower() for k in clone_kws)]
    if clone_actions or any(op in action_ops for op in clone_kws):
        parts.append("It clones or mirrors packets for network monitoring.")

    # --- Checksum / error detection ---
    checksum_controls = [n for n in control_names
                         if "checksum" in n.lower() or "verify" in n.lower()]
    if checksum_controls:
        parts.append(
            "It verifies and recomputes IP checksums for error detection "
            "and packet integrity."
        )

    # --- VPN / crypto ---
    CRYPTO_PROTOCOLS = {"esp", "ah", "ipsec"}
    found_crypto = [p for p in protocols if p in CRYPTO_PROTOCOLS]
    if found_crypto:
        parts.append(
            f"It processes IPsec/VPN headers ({', '.join(found_crypto)}) "
            f"for encrypted tunnel traffic."
        )

    # --- Multicast / group service ---
    mcast_kws    = ("mcast", "multicast", "group", "replication")
    mcast_fields = [f for f in key_fields if any(k in f for k in mcast_kws)]
    mcast_acts   = [n for n in action_names
                    if any(k in n.lower() for k in mcast_kws)]
    if mcast_fields or mcast_acts:
        parts.append(
            "It performs multicast or group replication for one-to-many delivery."
        )

    # Fallback — never return empty string
    if not parts:
        parts.append(
            f"This program processes "
            f"{', '.join(protocols or ['network'])} headers."
        )

    return " ".join(parts)


def _classify_buckets_embedding(features: dict) -> Set[str]:
    """
    Embed the code description and compare against BUCKET_TEMPLATES via cosine
    similarity using the unified SIMILARITY_THRESHOLD — same model and threshold
    as the intent router, no keyword fallback.
    """
    description = _features_to_description(features)
    model = _load_model()
    template_embeddings = _get_template_embeddings()
    vec = model.encode(description, normalize_embeddings=True)
    return {
        bucket for bucket, templ_vec in template_embeddings.items()
        if float(np.dot(vec, templ_vec)) >= SIMILARITY_THRESHOLD
    }


def _classify_buckets_llm(features: dict, api_key: str = "") -> Set[str]:
    """
    Classify P4 program features into behavior buckets using the Anthropic API.

    Sends the behavioral description and raw feature signals to claude-haiku-4-5-20251001
    with the bucket taxonomy in the system prompt. Returns the set of matched bucket
    names. Falls back to _classify_buckets_embedding on any API error or missing key.
    """
    if not api_key:
        return _classify_buckets_embedding(features)
    description = _features_to_description(features)

    BUCKET_DEFINITIONS = {
        "forwarding":       "Routes packets based on IP destination, sets output port, uses LPM or exact match tables on dstAddr.",
        "encapsulation":    "Adds or removes tunnel headers (GRE, VXLAN, GENEVE, IP-in-IP, MPLS). Wraps inner packets in outer headers for overlay networking, VM connectivity across data centers, or WAN tunneling. Uses add_header / remove_header / setValid / setInvalid on outer headers.",
        "header_rewriting": "Modifies existing header field values without adding or removing headers. TTL decrement, MAC rewrite, DSCP marking, NAT address translation.",
        "filtering":        "Drops or permits packets based on ACL rules, firewall policy, or access control tables. Uses mark_to_drop. Table names include acl, firewall, filter.",
        "monitoring":       "Collects traffic statistics or mirrors packets. Uses counter/meter/register externs, clone primitives, INT headers, or digest calls.",
        "label_tag":        "Pushes or pops MPLS labels or VLAN tags. Uses mpls_t or vlan_tag_t headers, push/pop actions, label swapping for traffic engineering.",
        "group_service":    "Replicates packets to multiple destinations. Sets mcast_grp, uses multicast group tables, one-to-many delivery.",
        "error_detection":  "Verifies or recomputes checksums. Uses MyVerifyChecksum / MyComputeChecksum controls, verify_checksum / update_checksum calls.",
        "vpn_crypto":       "Processes IPsec/VPN headers (esp_t, ah_t). Table names include ipsec, vpn, crypto. Encrypts or authenticates tunnel traffic.",
    }

    bucket_block = "\n".join(
        f'- "{name}": {desc}'
        for name, desc in BUCKET_DEFINITIONS.items()
    )

    system_prompt = (
        "You are a P4 network program classifier. Given a behavioral description "
        "of a P4 program, return ONLY a JSON array of matching bucket names. "
        "Return [] if nothing matches. No explanation, no markdown, no extra text. "
        "Valid bucket names:\n" + bucket_block
    )

    user_prompt = (
        f"Classify this P4 program:\n\n{description}\n\n"
        f"Additional signals:\n"
        f"- Headers: {', '.join(features.get('header_names', []))}\n"
        f"- Action ops: {', '.join(set(features.get('action_ops', [])))}\n"
        f"- Action names: {', '.join(features.get('action_names', []))}\n"
        f"- Extern types: {', '.join(features.get('extern_types', []))}\n\n"
        f"Return ONLY a JSON array of matching bucket name strings."
    )

    try:
        response = requests.post(
            "https://api.anthropic.com/v1/messages",
            headers={
                "Content-Type": "application/json",
                "x-api-key": api_key,
                "anthropic-version": "2023-06-01",
            },
            json={
                "model": "claude-haiku-4-5-20251001",
                "max_tokens": 256,
                "system": system_prompt,
                "messages": [{"role": "user", "content": user_prompt}],
            },
            timeout=15,
        )
        response.raise_for_status()
        data = response.json()
        raw = data["content"][0]["text"].strip()

        # Strip accidental markdown fences
        raw = re.sub(r'^```[a-z]*\n?', '', raw)
        raw = re.sub(r'\n?```$', '', raw)

        matched = json.loads(raw)
        if not isinstance(matched, list):
            raise ValueError(f"Expected list, got {type(matched)}")

        # Validate — only return known bucket names
        return {b for b in matched if b in BUCKETS}

    except Exception as exc:
        print(f"[vrf_a5] LLM classifier failed ({exc}), falling back to embedding.")
        return _classify_buckets_embedding(features)


# Public API
def extract_behavior_from_code(
    p4_code: str,
    code_id: Optional[str] = None,
    ir_path: str = "ir.json",
    api_key: str = "",
) -> dict:
    """
    Extract actual behavior and return the actual_behavior.json structure.

    Bucket classification reads the p4c IR at *ir_path* (written by the p4test
    --toJSON step in vrf_a_compile.sh) and classifies using embedding similarity
    against BUCKET_TEMPLATES.  If ir.json is absent (p4test step failed or was
    skipped) buckets and related fields are left empty rather than raising.

    suspicious_patterns is the only field always derived from source text.
    """
    if not p4_code or not p4_code.strip():
        return _empty_actual_behavior(code_id)

    try:
        features = features_from_ir_file(ir_path)
    except RuntimeError:
        # ir.json missing — p4test --toJSON step did not run or failed.
        # Return partial behavior with suspicious_patterns only.
        return {
            **_empty_actual_behavior(code_id),
            "suspicious_patterns": _detect_suspicious_patterns(p4_code),
        }
    buckets = _classify_buckets_llm(features, api_key=api_key)
    headers_defined = features.get("header_names", [])

    # Categorise control names into ingress / egress by name convention.
    control_blocks: Dict[str, List[str]] = {"ingress": [], "egress": []}
    for name in features.get("control_names", []):
        name_lower = name.lower()
        if "ingress" in name_lower and name not in control_blocks["ingress"]:
            control_blocks["ingress"].append(name)
        elif "egress" in name_lower and name not in control_blocks["egress"]:
            control_blocks["egress"].append(name)

    suspicious_patterns = _detect_suspicious_patterns(p4_code)

    detected_behaviors = [
        {
            "behavior_id": bucket,
            "evidence": {"source": "embedding_classification"},
        }
        for bucket in sorted(buckets)
    ]

    return {
        "code_id": code_id or f"code_{uuid.uuid4().hex[:12]}",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "buckets": sorted(buckets),
        "code_description": _features_to_description(features),
        "detected_behaviors": detected_behaviors,
        "headers_defined": headers_defined,  # debug field; not scored
        "control_blocks": control_blocks,
        "suspicious_patterns": suspicious_patterns,
    }


def _empty_actual_behavior(code_id: Optional[str] = None) -> dict:
    return {
        "code_id": code_id or "unknown",
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
        "buckets": [],
        "code_description": "",
        "detected_behaviors": [],
        "headers_defined": [],
        "control_blocks": {"ingress": [], "egress": []},
        "suspicious_patterns": [],
    }


def save_actual_behavior(actual: dict, path: str = "actual_behavior.json") -> None:
    """Write actual behavior JSON to file."""
    with open(path, "w") as f:
        json.dump(actual, f, indent=2)


if __name__ == "__main__":
    import sys
    p4_path = sys.argv[1] if len(sys.argv) > 1 else "test.p4"
    ir_path  = sys.argv[2] if len(sys.argv) > 2 else "ir.json"
    try:
        with open(p4_path) as f:
            code = f.read()
    except FileNotFoundError:
        code = ""
    out = extract_behavior_from_code(code, ir_path=ir_path)
    save_actual_behavior(out)
    print(json.dumps(out, indent=2))
