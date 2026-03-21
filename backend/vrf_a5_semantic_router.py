"""
VRF A.5: Semantic Intent Router — Map natural language intent to the 9-bucket taxonomy
using sentence transformer embeddings (all-MiniLM-L6-v2) and cosine similarity.

Each bucket has one canonical template description. The router embeds the user's intent
and compares it against all nine templates; buckets whose cosine similarity exceeds
SIMILARITY_THRESHOLD are returned as matched.
"""

from __future__ import annotations

from typing import Dict, FrozenSet, List, Optional, Tuple

# Similarity threshold from the proposal (Section 2.2).
SIMILARITY_THRESHOLD = 0.8

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


# ---------------------------------------------------------------------------
# Lazy model + embedding cache (avoid loading the model at import time)
# ---------------------------------------------------------------------------
_model = None
_template_embeddings: Optional[Dict[str, object]] = None  # bucket -> np.ndarray


def _load_model():
    global _model
    if _model is None:
        from sentence_transformers import SentenceTransformer  # type: ignore
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


# ---------------------------------------------------------------------------
# Public API
# ---------------------------------------------------------------------------

def route_intent_to_buckets(
    intent: str,
    threshold: float = SIMILARITY_THRESHOLD,
) -> Tuple[FrozenSet[str], Dict[str, float]]:
    """
    Embed *intent* and compare against all nine bucket templates via cosine similarity.

    Returns:
        matched_buckets: frozenset of bucket names with similarity >= threshold.
        similarities:    dict mapping every bucket name to its cosine similarity score.

    Falls back to the highest-scoring bucket when no template clears the threshold,
    so the caller always receives at least one bucket.
    """
    import numpy as np  # type: ignore

    model = _load_model()
    intent_vec = model.encode([intent.strip()], convert_to_numpy=True, normalize_embeddings=True)[0]

    template_embeddings = _get_template_embeddings()
    similarities: Dict[str, float] = {}
    for bucket, tmpl_vec in template_embeddings.items():
        # Vectors are L2-normalised, so dot product == cosine similarity.
        similarities[bucket] = float(np.dot(intent_vec, tmpl_vec))

    matched = frozenset(b for b, s in similarities.items() if s >= threshold)

    # Fallback: always return at least one bucket.
    if not matched:
        best_bucket = max(similarities, key=similarities.__getitem__)
        matched = frozenset({best_bucket})

    return matched, similarities


def describe_routing(intent: str, threshold: float = SIMILARITY_THRESHOLD) -> str:
    """Human-readable summary of routing result (useful for debugging)."""
    buckets, sims = route_intent_to_buckets(intent, threshold)
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
