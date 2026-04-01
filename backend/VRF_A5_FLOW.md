# VRF A.5 — System Flow

## Overview

VRF A.5 validates whether a generated P4 program actually implements what the natural-language intent described. It works in two parallel tracks — one for the **intent** (what the user asked for), one for the **code** (what was generated) — then scores how well they match.

---

## The 9-Bucket Taxonomy

Everything in this system revolves around 9 canonical behavior categories ("buckets"):

| Bucket | What it means |
|---|---|
| `forwarding` | Routes packets by IP dest, LPM/exact match tables, port selection |
| `encapsulation` | Adds/removes tunnel headers (GRE, VXLAN, GENEVE, IP-in-IP, MPLS) |
| `header_rewriting` | Modifies field values in place — TTL decrement, NAT, MAC rewrite, metadata copying |
| `filtering` | Drops/permits packets via ACL/firewall rules using `mark_to_drop` |
| `monitoring` | Counters, meters, packet cloning, INT telemetry, ECN marking |
| `label_tag` | Pushes/pops MPLS labels or 802.1Q VLAN tags |
| `group_service` | Multicasts to multiple destinations via `mcast_grp` |
| `error_detection` | Checksum verify/recompute via `MyVerifyChecksum`/`MyComputeChecksum` |
| `vpn_crypto` | IPsec ESP/AH, encrypted VPN tunnels (security-first encapsulation) |

---

## Full Pipeline

```
Natural Language Intent
        │
        ▼
┌─────────────────────────────┐
│   vrf_a5_intent_parser.py   │
│   generate_expected_behavior│
└────────────┬────────────────┘
             │ calls route_intent_to_buckets()
             ▼
┌─────────────────────────────────────────────┐
│         vrf_a5_semantic_router.py           │
│         route_intent_to_buckets()           │
│                                             │
│  Claude Haiku ◄── system prompt with the   │
│  (Haiku call 1)    9 bucket definitions +  │
│                    the raw intent text      │
│                                             │
│  Returns: JSON array of matched bucket names│
└────────────┬────────────────────────────────┘
             │ e.g. ["forwarding", "monitoring"]
             ▼
     expected_behavior.json
     ┌─────────────────────┐
     │ buckets: [...]       │
     │ headers_required: [] │  ← derived from BUCKET_HEADERS lookup
     │ control_blocks: {}   │
     │ prohibited_behaviors │  ← regex scan of intent text
     └─────────────────────┘


P4 Source Code
        │
        ▼
┌──────────────────────────────┐
│  Docker: p4test --toJSON     │
│  Produces ir.json            │
└──────────────┬───────────────┘
               │
               ▼
┌──────────────────────────────┐
│   vrf_a5_ast_parser.py       │
│   features_from_ir_file()    │
│                              │
│  Walks p4c JSON IR, extracts:│
│  • header_names              │
│  • action_names / action_ops │
│  • extern_types              │
│  • control_names             │
│  • table_names               │
└──────────────┬───────────────┘
               │ features dict
               ▼
┌──────────────────────────────────────────────┐
│   vrf_a5_behavior_extractor.py               │
│   _features_to_description()                 │
│                                              │
│  Converts the raw feature signals into a     │
│  natural-language prose description of the   │
│  P4 program's behavior (no LLM — pure rules) │
└──────────────┬───────────────────────────────┘
               │ "This program processes Ethernet, IPv4..."
               ▼
┌──────────────────────────────────────────────┐
│   vrf_a5_behavior_extractor.py               │
│   _classify_buckets_llm()                    │
│                                              │
│  Claude Haiku ◄── system prompt with the    │
│  (Haiku call 2)    9 bucket definitions +   │
│                    prose description +       │
│                    raw signals (headers,     │
│                    action ops, extern types) │
│                                             │
│  Returns: JSON array of matched bucket names │
└──────────────┬───────────────────────────────┘
               │ e.g. ["forwarding", "error_detection"]
               ▼
     actual_behavior.json
     ┌──────────────────────┐
     │ buckets: [...]        │
     │ headers_defined: []   │  ← from AST features directly
     │ control_blocks: {}    │  ← ingress/egress by name convention
     │ suspicious_patterns   │  ← regex scan of P4 source text
     └──────────────────────┘


expected_behavior.json + actual_behavior.json
        │
        ▼
┌──────────────────────────────────────────────┐
│   vrf_a5_semantic_comparator.py              │
│   compute_intent_match_score()               │
│                                              │
│  (No LLM calls here — pure arithmetic)       │
│                                              │
│  score = weighted sum of 4 components:       │
│                                              │
│  bucket_recall    × 0.70                     │
│    |expected ∩ actual| / |expected|          │
│    (recall not Jaccard — extra buckets ok)   │
│                                              │
│  header_similarity × 0.10                   │
│    NED via difflib.SequenceMatcher on        │
│    sorted header lists                       │
│                                              │
│  control_blocks   × 0.10                    │
│    ingress required? egress required?        │
│    fraction of required blocks present       │
│                                              │
│  prohibited_check × 0.10                    │
│    0.0 if suspicious_patterns ∩ prohibited   │
│    1.0 otherwise (hard penalty)              │
└──────────────┬───────────────────────────────┘
               │ (final_score, detailed_scores)
               ▼
┌──────────────────────────────┐
│   vrf_a5_validator.py        │
│   validate_intent()          │
│                              │
│  score ≥ 0.85  →  PASS       │
│  score ≥ 0.60  →  PARTIAL    │
│  score <  0.60 →  FAIL       │
│                 + feedback   │
│                   for LLM    │
│                   regeneration│
└──────────────────────────────┘
```

---

## Where Claude Haiku Is Called

| Call | File | Function | Input | Output |
|------|------|----------|-------|--------|
| **1 — Intent routing** | `vrf_a5_semantic_router.py` | `route_intent_to_buckets()` | Raw intent text + 9 bucket definitions | JSON array of matched bucket names |
| **2 — Code classification** | `vrf_a5_behavior_extractor.py` | `_classify_buckets_llm()` | NL prose of P4 behavior + raw AST signals + 9 bucket definitions | JSON array of matched bucket names |

Both calls use `claude-haiku-4-5-20251001` via `POST https://api.anthropic.com/v1/messages` with `max_tokens: 256`. Both raise `RuntimeError` immediately if no API key is provided — no silent fallback.

---

## Pass Threshold

`THRESHOLD_PASS = 0.85` — a program must score at least 0.85 to pass VRF A.5.

With the production weights, a program with perfect bucket recall (1.0) and no prohibited patterns scores `0.70 + 0.10 + 0.10 = 0.90` before header similarity, comfortably above threshold. A program missing one of two expected buckets (recall = 0.50) scores at most `0.35 + 0.10 + 0.10 + 0.10 = 0.65` — always a FAIL.
