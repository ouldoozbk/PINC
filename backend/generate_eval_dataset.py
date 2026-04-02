"""
Generate the eval dataset seed file — intents only, no P4 code yet.
P4 code is generated later via the /api/eval-generate endpoint (Claude Sonnet + VRF A).

Run once:  python3 backend/generate_eval_dataset.py
Then use the Eval Dataset tab to generate P4 for each intent and annotate.
"""

import csv, json
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
OUT_CSV  = PROJECT_ROOT / "eval_dataset.csv"
OUT_JSON = PROJECT_ROOT / "eval_dataset.json"

CASES = [
    # ── FIREWALL ──────────────────────────────────────────────────────────────
    {"id": 1,  "bucket": "firewall",       "intent": "Drop all packets from source IP 1.2.3.4."},
    {"id": 2,  "bucket": "firewall",       "intent": "Allow only inbound TCP port 80. Drop everything else."},
    {"id": 3,  "bucket": "firewall",       "intent": "Block all UDP traffic on port 53 (DNS) from entering the network."},
    # ── BASIC TUNNEL ──────────────────────────────────────────────────────────
    {"id": 4,  "bucket": "basic_tunnel",   "intent": "Encapsulate IPv4 packets inside a GRE tunnel with a fixed tunnel endpoint."},
    {"id": 5,  "bucket": "basic_tunnel",   "intent": "Strip the outer IP header from tunneled packets arriving at the tunnel endpoint."},
    # ── LOAD BALANCE ──────────────────────────────────────────────────────────
    {"id": 6,  "bucket": "load_balance",   "intent": "Distribute traffic across 4 servers using a hash of the 5-tuple."},
    {"id": 7,  "bucket": "load_balance",   "intent": "Implement round-robin load balancing across 3 backend servers using a register counter."},
    # ── DEFAULT FORWARDING ────────────────────────────────────────────────────
    {"id": 8,  "bucket": "default",        "intent": "Route IPv4 packets to the correct output port using longest prefix match on destination address."},
    {"id": 9,  "bucket": "default",        "intent": "Forward Ethernet frames based on destination MAC address with a learned MAC table."},
    # ── QoS ───────────────────────────────────────────────────────────────────
    {"id": 10, "bucket": "qos",            "intent": "Mark packets with DSCP EF (value 46) when they arrive on port 1."},
    # ── SOURCE ROUTING ────────────────────────────────────────────────────────
    {"id": 11, "bucket": "source_routing", "intent": "Forward packets along an explicit path stored as a stack of port IDs in the packet header."},
    # ── ECN ───────────────────────────────────────────────────────────────────
    {"id": 12, "bucket": "ecn",            "intent": "Set the ECN bits to Congestion Experienced (0b11) when the queue depth exceeds a threshold."},
]

def blank_case(c):
    return {**c, "p4_code": "", "vrf_a_passed": None, "attempts": None, "your_label": "", "notes": ""}

cases = [blank_case(c) for c in CASES]

csv_fields = ["id", "bucket", "intent", "vrf_a_passed", "your_label", "notes"]
with open(OUT_CSV, "w", newline="") as f:
    w = csv.DictWriter(f, fieldnames=csv_fields)
    w.writeheader()
    for c in cases:
        w.writerow({k: c[k] for k in csv_fields})

with open(OUT_JSON, "w") as f:
    json.dump(cases, f, indent=2)

print(f"Generated {len(cases)} intent-only cases → eval_dataset.json")
print("Next: open the Eval Dataset tab and click 'Generate P4' on each card.")
