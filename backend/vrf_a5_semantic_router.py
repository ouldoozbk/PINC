"""
VRF A.5: Semantic Intent Router — Map natural language intent to the 9-bucket taxonomy
using Claude Haiku (claude-haiku-4-5-20251001 for testing) via the Anthropic API.

Each bucket has one canonical template description. The router asks the LLM to classify
the intent against the nine templates and returns the matched set.

Raises RuntimeError if no API key is provided no silent fallback.
"""

from __future__ import annotations

import json
import os
import re
import requests
from typing import Dict, FrozenSet, List, Tuple

# Kept for callers that still reference it (not actively used by LLM path).
SIMILARITY_THRESHOLD = 0.50

_ANTHROPIC_API_URL = "https://api.anthropic.com/v1/messages"
_HAIKU_MODEL = "claude-haiku-4-5-20251001"

# Canonical intent template for each of the nine buckets.
BUCKET_TEMPLATES: Dict[str, str] = {
    "forwarding": (
        "Route and forward packets toward their destination using match-action tables, "
        "longest prefix match on IP destination addresses, egress port selection, "
        "next-hop resolution, and multipath or ECMP load balancing across multiple paths."
    ),
    "encapsulation": (
        "Encapsulates packets by adding outer tunnel headers such as GRE, VXLAN, "
        "GENEVE, IP-in-IP, or MPLS. Wraps inner packets inside an outer IP or "
        "Ethernet header for tunneling traffic across networks. Used for overlay "
        "networking, connecting virtual machines across data centers, software-defined "
        "networking fabrics, and WAN tunneling. Decapsulates by removing outer headers "
        "at tunnel endpoints. Adds and removes headers, sets valid bits, configures "
        "tunnel source and destination addresses."
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

# Anthropic API helper
def _call_haiku(system: str, user: str, api_key: str) -> str:
    """POST to Anthropic messages API and return the raw text response."""
    response = requests.post(
        _ANTHROPIC_API_URL,
        headers={
            "Content-Type": "application/json",
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
        },
        json={
            "model": _HAIKU_MODEL,
            "max_tokens": 256,
            "system": system,
            "messages": [{"role": "user", "content": user}],
        },
        timeout=15,
    )
    response.raise_for_status()
    return response.json()["content"][0]["text"].strip()


# Public API
def route_intent_to_buckets(
    intent: str,
    api_key: str = "",
) -> Tuple[FrozenSet[str], Dict[str, float]]:
    """
    Classify *intent* into the 9-bucket taxonomy using Claude Haiku.

    Raises RuntimeError if api_key is not provided.
    Returns (matched_buckets, similarities) where similarities maps every bucket
    to 1.0 (matched) or 0.0 (not matched) — kept for API compatibility.
    Returns empty frozenset if intent is blank or no buckets match.
    """
    if not api_key:
        api_key = os.environ.get("ANTHROPIC_API_KEY") or os.environ.get("CLAUDE_API_KEY") or ""
    if not api_key:
        raise RuntimeError(
            "CLAUDE_API_KEY is required for intent routing. "
            "Pass --api-key or set the CLAUDE_API_KEY environment variable."
        )

    intent = (intent or "").strip()
    if not intent:
        return frozenset(), {b: 0.0 for b in BUCKET_TEMPLATES}

    bucket_block = "\n".join(
        f'- "{name}": {desc}' for name, desc in BUCKET_TEMPLATES.items()
    )
    system_prompt = (
        "You are a P4 network program intent classifier. "
        "Given a natural-language network programming intent, return ONLY a JSON array "
        "of matching bucket names from the list below. "
        "Return [] if nothing matches. No explanation, no markdown, no extra text.\n"
        "Valid buckets:\n" + bucket_block
    )
    user_prompt = (
        f"Classify this network intent into buckets:\n\n{intent}\n\n"
        "Return ONLY a JSON array of matching bucket name strings."
    )

    raw = _call_haiku(system_prompt, user_prompt, api_key)
    raw = re.sub(r'^```[a-z]*\n?', '', raw)
    raw = re.sub(r'\n?```$', '', raw)
    parsed = json.loads(raw)
    if not isinstance(parsed, list):
        raise ValueError(f"Expected JSON array from Haiku, got: {raw!r}")
    matched = frozenset(b for b in parsed if b in BUCKET_TEMPLATES)

    similarities = {b: (1.0 if b in matched else 0.0) for b in BUCKET_TEMPLATES}
    return matched, similarities


def classify_code_buckets(description: str, api_key: str = "") -> FrozenSet[str]:
    """Classify a code behavioral description into the 9-bucket taxonomy using Claude Haiku."""
    return route_intent_to_buckets(description, api_key=api_key)[0]


def describe_routing(intent: str, api_key: str = "") -> str:
    """Human-readable summary of routing result (useful for debugging)."""
    buckets, sims = route_intent_to_buckets(intent, api_key=api_key)
    lines = [f"Intent: {intent!r}", "Similarities:"]
    for bucket in sorted(BUCKET_TEMPLATES):
        marker = "✓" if bucket in buckets else " "
        lines.append(f"  [{marker}] {bucket:<20} {sims[bucket]:.4f}")
    lines.append(f"Matched buckets: {sorted(buckets)}")
    return "\n".join(lines)


if __name__ == "__main__":
    import os
    import sys
    _intent = " ".join(sys.argv[1:]) if len(sys.argv) > 1 else "Implement an IP router"
    _key = os.environ.get("CLAUDE_API_KEY") or os.environ.get("ANTHROPIC_API_KEY") or ""
    print(describe_routing(_intent, api_key=_key))
