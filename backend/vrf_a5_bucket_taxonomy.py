"""
VRF A.5: Bucket Taxonomy — Shared constants for the 9-bucket compositional classifier.
Both the intent parser and behavior extractor import from here.
"""

from __future__ import annotations

BUCKETS = {
    "forwarding", "encapsulation", "header_rewriting",
    "filtering", "monitoring", "label_tag",
    "group_service", "error_detection", "vpn_crypto",
}

