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

# Intent-side: regex patterns → bucket name
# Each entry: (pattern_string, bucket_name)
INTENT_BUCKET_PATTERNS = [
    (r"\b(forward|route|routing|switch|multipath|ecmp|nexthop)\w*\b", "forwarding"),
    (r"\b(encapsulat|tunnel|vxlan|gre|mpls\s+encap)\w*\b", "encapsulation"),
    (r"\b(nat|network\s+address\s+translat|rewrite|masquerad)\w*\b", "header_rewriting"),
    (r"\b(filter|firewall|block|drop|deny|acl|access\s+control)\w*\b", "filtering"),
    (r"\b(monitor|telemetry|int|mirror|clone|count|timestamp|meter)\w*\b", "monitoring"),
    (r"\b(vlan|mpls\s+label|label\s+push|label\s+pop|802\.1q|tag)\w*\b", "label_tag"),
    (r"\b(multicast|anycast|broadcast|replicat)\w*\b", "group_service"),
    (r"\b(checksum|crc|error\s+detect|integrity)\w*\b", "error_detection"),
    (r"\b(ipsec|vpn|esp|ah\s+header|crypto|tls\s+vpn|ike)\w*\b", "vpn_crypto"),
]

# Code-side: P4 signal type + pattern → bucket name
# signal_type in {"action_call", "action_body", "header_type", "table_key",
#                 "table_name", "extern_call", "control_name"}
CODE_BUCKET_SIGNALS = [
    # forwarding
    ("action_call",  r"\b(ipv4_forward|l3_forward|set_egress|set_nhop|ecmp)\b", "forwarding"),
    ("table_key",    r"\bipv4\.(dst|src)Addr\b",                                 "forwarding"),
    ("table_key",    r"\bstandard_metadata\.egress_spec\b",                      "forwarding"),
    # encapsulation
    ("action_call",  r"\badd_header\s*\(",                                        "encapsulation"),
    ("action_call",  r"\bremove_header\s*\(",                                     "encapsulation"),
    # header_rewriting
    ("action_body",  r"\b(ipv4\.srcAddr|ipv4\.dstAddr|tcp\.srcPort|tcp\.dstPort)\s*=", "header_rewriting"),
    # filtering
    ("action_call",  r"\b(drop|mark_to_drop)\s*\(",                               "filtering"),
    ("table_name",   r"\b(acl|firewall|filter|block)\b",                          "filtering"),
    # monitoring
    ("extern_call",  r"\bclone[3]?\(",                                            "monitoring"),
    ("header_type",  r"\bint_\w+",                                                "monitoring"),
    ("extern_call",  r"\b(counter|meter)\b",                                      "monitoring"),
    ("extern_call",  r"\bregister\b",                                             "monitoring"),
    # label_tag
    ("header_type",  r"\b(vlan_tag_t|mpls_t)\b",                                 "label_tag"),
    ("action_body",  r"\bhdr\.(vlan|mpls)\b",                                     "label_tag"),
    # group_service
    ("action_call",  r"\bset_mgid\s*\(",                                          "group_service"),
    ("extern_call",  r"\bclone_preserving_field_list\(",                          "group_service"),
    # error_detection
    ("control_name", r"\b(MyVerifyChecksum|MyComputeChecksum)\b",                 "error_detection"),
    ("action_call",  r"\b(verify_checksum|update_checksum)\s*\(",                 "error_detection"),
    # vpn_crypto
    ("header_type",  r"\b(esp_t|ah_t|ipsec_\w+)\b",                              "vpn_crypto"),
    ("table_name",   r"\b(ipsec|vpn|crypto)\b",                                   "vpn_crypto"),
]
