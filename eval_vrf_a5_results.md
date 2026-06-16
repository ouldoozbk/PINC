# VRF A.5 Ground-Truth Evaluation

**Test cases:** 12  |  **Compiled:** 12/12  |  **IR JSON:** 12/12  |  **Avg score:** 90.07%

**Exact match:** 6/12  |  **Close:** 1/12  |  **Disagree:** 5/12

## Per-Case Results

| ID | Bucket | Intent (truncated) | Human | VRF A.5 | Score | Expected Buckets | Actual Buckets | Agreement |
|----|--------|--------------------|-------|---------|-------|------------------|----------------|-----------|
| 1 | firewall | Drop all packets from source IP 1.2.3.4. | yes | PASS | 98.75% | filtering | error_detection, filtering | **exact** |
| 2 | firewall | Drop all packets from source IP 1.2.3.4. | no | PASS | 86.67% | filtering | error_detection, filtering, forwarding | **disagree** |
| 3 | firewall | Allow only inbound TCP port 80. Drop everythi… | partial | PASS | 87.18% | filtering | error_detection, filtering, forwarding | **close** |
| 4 | firewall | Allow only inbound TCP port 80. Drop everythi… | no | PASS | 98.75% | filtering | error_detection, filtering, forwarding | **disagree** |
| 5 | basic_tunnel | Encapsulate IPv4 packets inside a GRE tunnel … | yes | PASS | 97.18% | encapsulation | encapsulation, error_detection, filtering, forwarding | **exact** |
| 6 | basic_tunnel | Encapsulate IPv4 packets inside a GRE tunnel … | no | FAIL | 26.09% | encapsulation | error_detection, filtering, forwarding | **exact** |
| 7 | basic_tunnel | Strip the outer IP header from tunneled packe… | yes | PASS | 98.75% | encapsulation | encapsulation, error_detection, filtering, forwarding | **exact** |
| 8 | load_balance | Distribute traffic across 4 servers using a h… | yes | PASS | 96.09% | forwarding | error_detection, filtering, forwarding | **exact** |
| 9 | load_balance | Distribute traffic across 4 servers using a h… | no | PASS | 98.75% | forwarding | error_detection, filtering, forwarding | **disagree** |
| 10 | default | Route IPv4 packets to the correct output port… | yes | PASS | 98.75% | forwarding | error_detection, filtering, forwarding | **exact** |
| 11 | default | Route IPv4 packets to the correct output port… | no | PASS | 96.67% | forwarding | error_detection, filtering, forwarding | **disagree** |
| 12 | firewall | Block all UDP traffic on port 53 (DNS) from e… | no | PASS | 97.18% | filtering | error_detection, filtering, forwarding | **disagree** |

## Detailed Scores

| ID | Intent (truncated) | Compiled | IR | Bucket Recall | Header Similarity | Control Blocks | Prohibited |
|----|-------------------|----------|----|---------------|-------------------|----------------|------------|
| 1 | Drop all packets from source IP 1.2… | yes | yes | 100.00% | 87.50% | 100.00% | 100.00% |
| 2 | Drop all packets from source IP 1.2… | yes | yes | 100.00% | 66.67% | 100.00% | 0.00% |
| 3 | Allow only inbound TCP port 80. Dro… | yes | yes | 100.00% | 71.79% | 100.00% | 0.00% |
| 4 | Allow only inbound TCP port 80. Dro… | yes | yes | 100.00% | 87.50% | 100.00% | 100.00% |
| 5 | Encapsulate IPv4 packets inside a G… | yes | yes | 100.00% | 71.79% | 100.00% | 100.00% |
| 6 | Encapsulate IPv4 packets inside a G… | yes | yes | 0.00% | 60.87% | 100.00% | 100.00% |
| 7 | Strip the outer IP header from tunn… | yes | yes | 100.00% | 87.50% | 100.00% | 100.00% |
| 8 | Distribute traffic across 4 servers… | yes | yes | 100.00% | 60.87% | 100.00% | 100.00% |
| 9 | Distribute traffic across 4 servers… | yes | yes | 100.00% | 87.50% | 100.00% | 100.00% |
| 10 | Route IPv4 packets to the correct o… | yes | yes | 100.00% | 87.50% | 100.00% | 100.00% |
| 11 | Route IPv4 packets to the correct o… | yes | yes | 100.00% | 66.67% | 100.00% | 100.00% |
| 12 | Block all UDP traffic on port 53 (D… | yes | yes | 100.00% | 71.79% | 100.00% | 100.00% |

## Summary

- Test cases evaluated: **12**
- Successfully compiled: **12/12**
- IR JSON generated (enables full bucket classification): **12/12**
- Exact agreement (human label = VRF A.5 label): **6/12** (50%)
- Close agreement (both positive): **1/12** (8%)
- Disagreement: **5/12** (42%)
- Average VRF A.5 score: **90.07%**
