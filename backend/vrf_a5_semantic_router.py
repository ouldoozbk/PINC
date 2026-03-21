"""
VRF A.5: Semantic Intent Router — Map natural language intent to the 9-bucket taxonomy
using sentence transformer embeddings (all-MiniLM-L6-v2) and cosine similarity.

Each bucket has one canonical template description. The router embeds the user's intent
and compares it against all nine templates; buckets whose cosine similarity exceeds
SIMILARITY_THRESHOLD are returned as matched.
"""

from __future__ import annotations

import re
from typing import Dict, FrozenSet, List, Optional, Tuple

# Similarity threshold from the proposal (Section 2.2).
SIMILARITY_THRESHOLD = 0.8

# Lightweight keyword rules used when semantic model imports are unavailable.
_KEYWORD_RULES: Dict[str, Tuple[str, ...]] = {
    "forwarding": ("forward", "route", "routing", "switch", "next hop", "nexthop", "ecmp", "multipath"),
    "encapsulation": ("encapsulat", "encap", "tunnel", "vxlan", "gre", "ip-in-ip", "ip in ip"),
    "header_rewriting": ("rewrite", "nat", "masquerad", "translate", "source ip", "dst ip", "tcp src", "tcp dst"),
    "filtering": ("filter", "firewall", "acl", "drop", "mark_to_drop", "block", "deny"),
    "monitoring": ("monitor", "telemetry", "clone", "mirror", "counter", "meter", "int", "timestamp"),
    "label_tag": ("vlan", "mpls", "802.1q", "vlan tag", "label"),
    "group_service": ("multicast", "broadcast", "replicat", "set_mgid", "anycast"),
    "error_detection": ("checksum", "verify_checksum", "update_checksum", "integrity", "crc"),
    "vpn_crypto": ("ipsec", "vpn", "crypto", "esp", "ah", "tls", "ike"),
}

# Canonical intent template for each of the nine buckets.
# Written to be paraphrase-rich so the embedding captures the full semantic scope.
BUCKET_TEMPLATES: Dict[str, str] = {
    "forwarding": (
        "Route and forward packets toward their destination using match-action tables, "
        "longest prefix match on IP destination addresses, egress port selection, "
        "next-hop resolution, and multipath or ECMP load balancing across multiple paths."
    ),
    "encapsulation": (
        "Add or remove entire protocol headers to encapsulate or decapsulate packets "
        "inside tunnels such as VXLAN, GRE, or IP-in-IP overlays using add_header "
        "and remove_header operations."
    ),
    "header_rewriting": (
        "Modify individual packet header field values such as source and destination "
        "IP addresses or TCP and UDP port numbers to perform network address translation "
        "NAT, masquerading, or stateless header field rewriting."
    ),
    "filtering": (
        "Permit or drop packets based on access control lists, firewall rules, or "
        "security policies that match on IP address, port, protocol, or other fields "
        "by invoking drop or mark_to_drop actions."
    ),
    "monitoring": (
        "Observe and measure network traffic without altering forwarding behavior using "
        "in-band network telemetry INT, packet counting, per-flow metering, timestamps, "
        "and packet cloning or mirroring to an external collector."
    ),
    "label_tag": (
        "Push or pop MPLS label stack entries or IEEE 802.1Q VLAN tags to steer packets "
        "through label-switched paths and virtual LAN segments without rewriting payload headers."
    ),
    "group_service": (
        "Replicate and deliver packets to multiple destinations simultaneously using "
        "multicast group assignment via set_mgid, anycast distribution, or "
        "link-layer broadcast services."
    ),
    "error_detection": (
        "Compute or verify checksum and data integrity fields over packet header or "
        "payload data using verify_checksum and update_checksum in the "
        "MyVerifyChecksum and MyComputeChecksum control blocks."
    ),
    "vpn_crypto": (
        "Tunnel or encrypt traffic using cryptographic encapsulation protocols such as "
        "IPSec ESP, IPSec AH, IKE key exchange, or TLS VPN to provide secure "
        "authenticated delivery between network endpoints."
    ),
}

# Headers typically required by each bucket (used for expected_behavior headers_required).
BUCKET_HEADERS: Dict[str, List[str]] = {
    "forwarding":       ["ethernet", "ipv4"],
    "encapsulation":    ["ethernet", "ipv4"],
    "header_rewriting": ["ethernet", "ipv4"],
    "filtering":        ["ethernet", "ipv4"],
    "monitoring":       ["ethernet"],
    "label_tag":        ["ethernet", "vlan"],
    "group_service":    ["ethernet"],
    "error_detection":  ["ethernet", "ipv4"],
    "vpn_crypto":       ["ethernet", "ipv4"],
}


# Lazy model + embedding cache (avoid loading the model at import time)
_model = None
_template_embeddings: Optional[Dict[str, object]] = None  # bucket -> np.ndarray


def _load_model():
    global _model
    if _model is None:
        try:
            from sentence_transformers import SentenceTransformer  # type: ignore
        except Exception as exc:
            raise RuntimeError(
                "sentence-transformers is not available. Install dependencies in backend/requirements.txt "
                "or route_intent_to_buckets will use keyword fallback only."
            ) from exc
        _model = SentenceTransformer("all-MiniLM-L6-v2")
    return _model


def _get_template_embeddings() -> Dict[str, object]:
    """Return cached template embeddings, computing them on first call."""
    global _template_embeddings
    if _template_embeddings is None:
        model = _load_model()
        texts = list(BUCKET_TEMPLATES.values())
        keys = list(BUCKET_TEMPLATES.keys())
        vecs = model.encode(texts, convert_to_numpy=True, normalize_embeddings=True)
        _template_embeddings = {k: vecs[i] for i, k in enumerate(keys)}
    return _template_embeddings


# Public API
def route_intent_to_buckets(
    intent: str,
    threshold: float = SIMILARITY_THRESHOLD,
    fallback_to_best: bool = False,
) -> Tuple[FrozenSet[str], Dict[str, float]]:
    """
    Embed *intent* and compare against all nine bucket templates via cosine similarity.

    Returns:
        matched_buckets: frozenset of bucket names with similarity >= threshold.
        similarities:    dict mapping every bucket name to its cosine similarity score.

    By default, no forced bucket fallback is applied. Set `fallback_to_best=True`
    to preserve the old behavior of always returning at least one bucket.
    """
    intent = (intent or "").strip()
    if not intent:
        return (frozenset({"forwarding"}) if fallback_to_best else frozenset(), {bucket: 0.0 for bucket in BUCKET_TEMPLATES})

    import numpy as np  # type: ignore

    similarities: Dict[str, float] = {bucket: 0.0 for bucket in BUCKET_TEMPLATES}
    matched = set()

    # Primary path: semantic similarity.
    try:
        model = _load_model()
        intent_vec = model.encode([intent], convert_to_numpy=True, normalize_embeddings=True)[0]

        template_embeddings = _get_template_embeddings()
        for bucket, tmpl_vec in template_embeddings.items():
            # Vectors are L2-normalised, so dot product == cosine similarity.
            similarities[bucket] = float(np.dot(intent_vec, tmpl_vec))
        matched = {bucket for bucket, score in similarities.items() if score >= threshold}
    except Exception:
        # Fallback to deterministic keyword heuristics when model dependencies are missing
        # or model load fails for any reason.
        lower_intent = intent.lower()
        keywords = set(re.findall(r"[a-z0-9_\\.]+", lower_intent))

        for bucket, patterns in _KEYWORD_RULES.items():
            if any(p in lower_intent for p in patterns) or any(any(k.startswith(p.rstrip("*")) for k in keywords) for p in patterns):
                matched.add(bucket)

    if not matched and fallback_to_best and similarities:
        # Preserve old behavior: choose the highest-scoring bucket for compatibility.
        best_bucket = max(similarities, key=similarities.__getitem__)
        matched = {best_bucket}

    return frozenset(sorted(matched)), similarities


def describe_routing(intent: str, threshold: float = SIMILARITY_THRESHOLD) -> str:
    """Human-readable summary of routing result (useful for debugging)."""
    buckets, sims = route_intent_to_buckets(intent, threshold, fallback_to_best=True)
    lines = [f"Intent: {intent!r}", f"Threshold: {threshold}", "Similarities:"]
    for bucket in sorted(BUCKET_TEMPLATES):
        marker = "✓" if bucket in buckets else " "
        lines.append(f"  [{marker}] {bucket:<20} {sims[bucket]:.4f}")
    lines.append(f"Matched buckets: {sorted(buckets)}")
    return "\n".join(lines)


if __name__ == "__main__":
    import sys
    _intent = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Implement an IP router"
    print(describe_routing(_intent))
