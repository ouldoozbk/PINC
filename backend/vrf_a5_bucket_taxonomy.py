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

# Code-side: P4 signal type + pattern → bucket name
# signal_type in {"action_call", "action_body", "header_type", "table_key",
#                 "table_name", "extern_call", "control_name"}
CODE_BUCKET_SIGNALS = [
    # forwarding
    ("action_call",  r"\b(ipv4_forward|l3_forward|set_egress|set_nhop|ecmp)\b", "forwarding"),
    ("action_call",  r"\b(set_nexthop|set_egress_port|set_output_port)\b",      "forwarding"),
    ("action_body",  r"\bstandard_metadata\.egress_spec\s*=",                    "forwarding"),
    ("table_name",   r"\b(fwd|forward|routing|route|lpm|nexthop|ecmp)\w*\b",     "forwarding"),
    ("table_key",    r"\bipv4\.(dst|src)Addr\b",                                 "forwarding"),
    ("table_key",    r"\bstandard_metadata\.egress_spec\b",                      "forwarding"),
    # encapsulation (P4_14 primitives + P4_16 setValid/setInvalid + tunnel names)
    ("action_call",  r"\badd_header\s*\(",                                        "encapsulation"),
    ("action_call",  r"\bremove_header\s*\(",                                     "encapsulation"),

    ("action_call",  r"\bsetValid\s*\(",                                          "encapsulation"),
    ("action_call",  r"\bsetInvalid\s*\(",                                        "encapsulation"),
    ("action_body",  r"\bhdr\.\w+\.setValid\s*\(",                                "encapsulation"),
    ("action_body",  r"\bhdr\.\w+\.setInvalid\s*\(",                              "encapsulation"),
    # setValid/setInvalid called directly in apply blocks (extern_call includes apply text)
    ("extern_call",  r"\bsetValid\s*\(",                                          "encapsulation"),
    ("extern_call",  r"\bsetInvalid\s*\(",                                        "encapsulation"),
    ("table_name",   r"\b(tunnel|encap|decap|gre|vxlan|ipip|overlay)\b",          "encapsulation"),
    ("action_call",  r"\b(encap|decap|tunnel_encap|tunnel_decap|add_tunnel)\b",   "encapsulation"),
    # tunnel-specific header type names
    ("header_type",  r"\b(vxlan_t|gre_t|geneve_t|ipip_t|tunnel_t)\b",            "encapsulation"),
    ("header_type",  r"\bouter_\w+",                                              "encapsulation"),
    ("header_type",  r"\binner_\w+",                                              "encapsulation"),

    ("action_call",  r"\bhdr\.\w*(gre|vxlan|geneve|ipip|tunnel|outer|mpls)\w*\.(setValid|setInvalid)\s*\(", "encapsulation"),
    ("action_call",  r"\b(push|pop)_(vxlan|gre|geneve|mpls|tunnel)\b",          "encapsulation"),
    ("action_body",  r"\bhdr\.\w*(outer|inner|tunnel)\w*\.",                     "encapsulation"),
    ("header_type",  r"\b\w*(gre|vxlan|geneve|ipip|tunnel|outer|mpls)\w*_t\b",  "encapsulation"),
    ("table_name",   r"\b(encap|decap|tunnel|vxlan|gre|geneve|ipip)\w*\b",      "encapsulation"),

    # header_rewriting
    ("action_body",  r"\b(ipv4\.srcAddr|ipv4\.dstAddr|tcp\.srcPort|tcp\.dstPort)\s*=", "header_rewriting"),
    ("action_body",  r"\bhdr\.\w+\.(src|dst)(Addr|Port)\s*=",                    "header_rewriting"),
    ("table_name",   r"\b(nat|rewrite|xlate|translate)\w*\b",                    "header_rewriting"),
    # filtering
    ("action_call",  r"\b(drop|mark_to_drop)\s*\(",                               "filtering"),
    ("action_call",  r"\b(permit|allow|deny|drop_pkt)\b",                         "filtering"),
    ("table_name",   r"\b(acl|firewall|filter|block|policy|deny)\w*\b",           "filtering"),
    # monitoring
    ("extern_call",  r"\bclone[3]?\(",                                            "monitoring"),
    ("extern_call",  r"\b(digest|recirculate|resubmit)\s*\(",                     "monitoring"),
    ("header_type",  r"\bint_\w+",                                                "monitoring"),
    ("extern_call",  r"\b(counter|meter)\b",                                      "monitoring"),
    ("extern_call",  r"\bregister\b",                                             "monitoring"),
    ("table_name",   r"\b(telemetry|monitor|stats|counter|meter)\w*\b",           "monitoring"),
    # label_tag
    ("header_type",  r"\b(vlan_tag_t|mpls_t)\b",                                 "label_tag"),

    ("header_type",  r"\bmpls\w*",                                                "label_tag"),
    ("header_type",  r"\blabel\w*",                                               "label_tag"),

    ("action_call",  r"\b(push|pop)_(vlan|mpls)\b",                               "label_tag"),
    ("action_call",  r"\bhdr\.\w*(vlan|mpls)\w*\.setValid\s*\(",                  "label_tag"),

    ("action_body",  r"\bhdr\.(vlan|mpls)\b",                                     "label_tag"),
    ("action_body",  r"\bhdr\.\w*(label|mpls)\w*",                                "label_tag"),
    ("action_call",  r"\b(push_label|pop_label|swap_label|push_mpls|pop_mpls|label_push|label_pop)\b", "label_tag"),
    ("table_name",   r"\b\w*(mpls|label_switch|lsp|fec)\w*\b",                   "label_tag"),
    # group_service
    ("action_call",  r"\bset_mgid\s*\(",                                          "group_service"),
    ("action_body",  r"\bstandard_metadata\.(mcast_grp|egress_rid)\s*=",          "group_service"),
    ("extern_call",  r"\bclone_preserving_field_list\(",                          "group_service"),
    ("table_name",   r"\b(multicast|broadcast|replica|group)\w*\b",               "group_service"),
    # error_detection
    ("control_name", r"\b(MyVerifyChecksum|MyComputeChecksum)\b",                 "error_detection"),
    ("action_call",  r"\b(verify_checksum|update_checksum)\s*\(",                 "error_detection"),
    ("action_call",  r"\b(verify|update)_\w*checksum\s*\(",                        "error_detection"),
    ("table_name",   r"\b(checksum|crc|integrity)\w*\b",                           "error_detection"),
    # vpn_crypto
    ("header_type",  r"\b(esp_t|ah_t|ipsec_\w+)\b",                              "vpn_crypto"),

    ("header_type",  r"\bl2tp\w*",                                                "vpn_crypto"),
    ("table_name",   r"\b(ipsec|vpn|crypto)\b",                                   "vpn_crypto"),
    ("table_name",   r"\bl2tp\w*",                                                "vpn_crypto"),
    ("action_call",  r"\bl2tp_\w+",                                               "vpn_crypto"),

    ("header_type",  r"\b\w*(esp|ah|ipsec|ike|tls|vpn)\w*_t\b",                  "vpn_crypto"),
    ("action_call",  r"\bhdr\.\w*(esp|ah|ipsec|vpn)\w*\.setValid\s*\(",           "vpn_crypto"),
    ("table_name",   r"\b(ipsec|vpn|crypto|encrypt|decrypt)\w*\b",                "vpn_crypto"),

]
