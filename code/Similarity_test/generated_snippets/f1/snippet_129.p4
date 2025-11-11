<｜begin▁of▁sentence｜>You are a P4 code generator. Respond with one compilable P4_16 program wrapped in <p4>...</p4> tags. Do not include any explanation or comments. Always include headers, parser, ingress/egress controls, deparser, and main block (e.g., V1Switch(...)). Target BMv2 with v1model and ensure the output works with p4c.

User: 
You are generating one compilable P4_16 program for BMv2 v1model.

TASK:
Implement the network intent: Monitors DNS traffic, tracks known domains, and counts packets and bytes for associated non-DNS traffic.

YANG MODEL SCHEMA:
The following YANG model defines the data structure and constraints:
```yang
module network-config {
    yang-version 1.1;
    namespace "http://example.com/network-config";
    prefix "net";

    organization "Example Organization";
    contact "admin@example.com";
    description "Simple network configuration model for P4 system";

    revision 2024-01-01 {
        description "Initial version";
    }

    // Custom type definitions
    typedef port-number {
        type uint16 {
            range "1..65535";  // Valid port range
        }
        description "Valid port number (1-65535)";
    }

    typedef interface-name {
        type string {
            pattern "^port[0-9]+$";  // Must be "port" followed by numbers
        }
        description "Interface name (e.g., port1, port2)";
    }

    typedef rule-id {
        type uint32 {
            range "1..1000";  // Reasonable rule ID range
        }
        description "Firewall rule identifier";
    }

    // Network interfaces configuration
    //this container holds the child nodes
    container interfaces {
        description "Network interface settings";
        
        list interface {
            key "name";
            description "Individual interface";
            
            leaf name {
                type interface-name;  // Uses our custom type
                description "Interface name (e.g., port1, port2)";
            }
            
            leaf action {
                type enumeration {
                    enum forward;
                    enum drop;
                }
                default forward;
                description "What to do with packets on this interface";
            }
        }
    }

    // Simple firewall rules
    container firewall {
        description "Firewall rules";
        
        list rule {
            key "id";
            description "Individual firewall rule";
            
            leaf id {
                type rule-id;  // Uses our custom type
                description "Rule number";
            }
            
            leaf port {
                type port-number;  // Uses our custom type
                description "Port number to match";
            }
            
            leaf action {
                type enumeration {
                    enum allow;
                    enum deny;
                }
                description "Action for matching packets";
            }
        }
    }
} 
```

CURRENT NETWORK CONFIGURATION:
```json
{
    "interfaces": {
      "interface": [
        {
          "name": "port1",
          "action": "forward"
        },
        {
          "name": "port2",
          "action": "drop"
        }
      ]
    },
    "firewall": {
      "rule": [
        {
          "id": 1,
          "port": 80,
          "action": "allow"
        },
        {
          "id": 2,
          "port": 22,
          "action": "deny"
        }
      ]
    }
  }
```

EXAMPLES:
Here are examples of similar network intents and their P4 implementations:

Example 1:
Intent: Provide basic IPv4 L3 forwarding using longest-prefix-match and TTL decrement.
Implementation:
```p4


// SPDX-License-Identifier: Apache-2.0
/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_IPV4 = 0x800;

/*************************************************************************
*********************** H E A D E R S  ***********************************
* This program skeleton defines minimal Ethernet and IPv4 headers and    *
* a simple LPM (Longest-Prefix Match) IPv4 forwarding pipeline.          *
* The exercise intentionally leaves TODOs for learners to implement.     *
*************************************************************************/

typedef bit<9>  egressSpec_t;   // Standard BMv2 uses 9 bits for egress_spec
typedef bit<48> macAddr_t;      // Ethernet MAC address
typedef bit<32> ip4Addr_t;      // IPv4 address

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}

header ipv4_t {
    bit<4>    version;
    bit<4>    ihl;
    bit<8>    diffserv;
    bit<16>   totalLen;
    bit<16>   identification;
    bit<3>    flags;
    bit<13>   fragOffset;
    bit<8>    ttl;
    bit<8>    protocol;
    bit<16>   hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
}

/*************************************************************************
*********************** P A R S E R  *************************************
* New to P4? A typical parser does this:
*   start -> parse_ethernet
*   parse_ethernet:
*       if etherType == TYPE_IPV4 -> parse_ipv4
*       else accept
*   parse_ipv4 -> accept
* This skeleton leaves the actual states as a TODO to implement later.   *
*************************************************************************/

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        /* TODO: add parser logic
         * Suggested outline:
         *   1) Extract Ethernet: packet.extract(hdr.ethernet);
         *   2) If hdr.ethernet.etherType == TYPE_IPV4 -> parse IPv4
         *   3) Otherwise -> transition accept
         */
        transition accept;
    }
}


/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}


/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
* High-level intent:
*   - Do an LPM lookup on IPv4 dstAddr
*   - On hit, call ipv4_forward(next-hop MAC, output port)
*   - Otherwise, drop or NoAction (as configured)                         *
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    action drop() {
        mark_to_drop(standard_metadata);
    }

    /*********************************************************************
     * NOTE FOR NEW READERS:
     * 'ipv4_forward(dstAddr, port)' is invoked by table 'ipv4_lpm'.
     *
     * The values for 'dstAddr' and 'port' are *action data* supplied by
     * the control plane when it installs entries in 'ipv4_lpm'.
     *
     * They mean:
     *   - dstAddr  => Ethernet destination MAC for the next hop
     *   - port     => output port (ultimately written to standard_metadata.egress_spec)
     *
     * Example (BMv2 simple_switch_CLI):
     *   table_add ipv4_lpm ipv4_forward 10.0.1.1/32 => 00:00:00:00:01:00 1
     * which passes MAC=00:00:00:00:01:00 and PORT=1 as action parameters
     * into ipv4_forward(dstAddr, port).
     *********************************************************************/
    action ipv4_forward(macAddr_t dstAddr, egressSpec_t port) {
        /*
            Action function for forwarding IPv4 packets.

            TODO: Implement the forwarding steps, for example:
              - standard_metadata.egress_spec = port;
              - hdr.ethernet.dstAddr = dstAddr;
              - (optionally) set hdr.ethernet.srcAddr to the switch MAC for 'port'
              - adjust IPv4 TTL and checksums as needed
        */
    }

    /*********************************************************************
     * LPM table for IPv4:
     *   - Matches on hdr.ipv4.dstAddr using longest-prefix match (lpm)
     *   - On hit, calls ipv4_forward with *action data* populated by the
     *     control plane when it installs the table entry.
     *********************************************************************/
    table ipv4_lpm {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }
        actions = {
            ipv4_forward;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    apply {
        /* TODO: fix ingress control logic
         *  - Good practice: apply ipv4_lpm only when the IPv4 header is valid, e.g.:
         *      if (hdr.ipv4.isValid()) { ipv4_lpm.apply(); }
         *    This skeleton currently applies unconditionally for the exercise.
         */
        ipv4_lpm.apply();
    }
}

/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
* Often used for queue marks, mirroring, or post-routing edits.          *
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
* This block shows how to compute IPv4 header checksum when needed.      *
*************************************************************************/

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
     apply {
        update_checksum(
            hdr.ipv4.isValid(),
            { hdr.ipv4.version,
              hdr.ipv4.ihl,
              hdr.ipv4.diffserv,
              hdr.ipv4.totalLen,
              hdr.ipv4.identification,
              hdr.ipv4.flags,
              hdr.ipv4.fragOffset,
              hdr.ipv4.ttl,
              hdr.ipv4.protocol,
              hdr.ipv4.srcAddr,
              hdr.ipv4.dstAddr },
            hdr.ipv4.hdrChecksum,
            HashAlgorithm.csum16);
    }
}


/*************************************************************************
***********************  D E P A R S E R  *******************************
* The deparser serializes headers back onto the packet in order.         *
*************************************************************************/

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        /*
        Typical implementation (left as a TODO for learners):
            packet.emit(hdr.ethernet);
            packet.emit(hdr.ipv4);   // per P4_16 spec, emit appends a header
                                     // only if it is valid; no 'if' needed.
        */
    }
}

/*************************************************************************
***********************  S W I T C H  ***********************************
*************************************************************************/

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;


```

Example 2:
Intent: Implement a stateful firewall that tracks TCP connections with Bloom filters and only allows approved flows.
Implementation:
```p4


// SPDX-License-Identifier: Apache-2.0
/* -*- P4_16 -*- */
#include <core.p4>
#include <v1model.p4>

/* CONSTANTS */

const bit<16> TYPE_IPV4 = 0x800;
const bit<8>  TYPE_TCP  = 6;

#define BLOOM_FILTER_ENTRIES 4096
#define BLOOM_FILTER_BIT_WIDTH 1

/*************************************************************************
*********************** H E A D E R S  ***********************************
*************************************************************************/

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}

header ipv4_t {
    bit<4>    version;
    bit<4>    ihl;
    bit<8>    diffserv;
    bit<16>   totalLen;
    bit<16>   identification;
    bit<3>    flags;
    bit<13>   fragOffset;
    bit<8>    ttl;
    bit<8>    protocol;
    bit<16>   hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}

header tcp_t{
    bit<16> srcPort;
    bit<16> dstPort;
    bit<32> seqNo;
    bit<32> ackNo;
    bit<4>  dataOffset;
    bit<4>  res;
    bit<1>  cwr;
    bit<1>  ece;
    bit<1>  urg;
    bit<1>  ack;
    bit<1>  psh;
    bit<1>  rst;
    bit<1>  syn;
    bit<1>  fin;
    bit<16> window;
    bit<16> checksum;
    bit<16> urgentPtr;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
    tcp_t        tcp;
}

/*************************************************************************
*********************** P A R S E R  ***********************************
*************************************************************************/

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        transition parse_ethernet;
    }

    state parse_ethernet {
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            TYPE_IPV4: parse_ipv4;
            default: accept;
        }
    }

    state parse_ipv4 {
        packet.extract(hdr.ipv4);
        transition select(hdr.ipv4.protocol){
            TYPE_TCP: tcp;
            default: accept;
        }
    }

    state tcp {
       packet.extract(hdr.tcp);
       transition accept;
    }
}

/*************************************************************************
************   C H E C K S U M    V E R I F I C A T I O N   *************
*************************************************************************/

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}


/*************************************************************************
**************  I N G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    register<bit<BLOOM_FILTER_BIT_WIDTH>>(BLOOM_FILTER_ENTRIES) bloom_filter_1;
    register<bit<BLOOM_FILTER_BIT_WIDTH>>(BLOOM_FILTER_ENTRIES) bloom_filter_2;
    bit<32> reg_pos_one; bit<32> reg_pos_two;
    bit<1> reg_val_one; bit<1> reg_val_two;
    bit<1> direction;

    action drop() {
        mark_to_drop(standard_metadata);
    }

    action compute_hashes(ip4Addr_t ipAddr1, ip4Addr_t ipAddr2, bit<16> port1, bit<16> port2){
       //Get register position
       hash(reg_pos_one, HashAlgorithm.crc16, (bit<32>)0, {ipAddr1,
                                                           ipAddr2,
                                                           port1,
                                                           port2,
                                                           hdr.ipv4.protocol},
                                                           (bit<32>)BLOOM_FILTER_ENTRIES);

       hash(reg_pos_two, HashAlgorithm.crc32, (bit<32>)0, {ipAddr1,
                                                           ipAddr2,
                                                           port1,
                                                           port2,
                                                           hdr.ipv4.protocol},
                                                           (bit<32>)BLOOM_FILTER_ENTRIES);
    }

    action ipv4_forward(macAddr_t dstAddr, egressSpec_t port) {
        standard_metadata.egress_spec = port;
        hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
        hdr.ethernet.dstAddr = dstAddr;
        hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
    }

    table ipv4_lpm {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }
        actions = {
            ipv4_forward;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = drop();
    }

    action set_direction(bit<1> dir) {
        direction = dir;
    }

    table check_ports {
        key = {
            standard_metadata.ingress_port: exact;
            standard_metadata.egress_spec: exact;
        }
        actions = {
            set_direction;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    apply {
        if (hdr.ipv4.isValid()){
            ipv4_lpm.apply();
            if (hdr.tcp.isValid()){
                direction = 0; // default
                if (check_ports.apply().hit) {
                    // test and set the bloom filter
                    if (direction == 0) {
                        compute_hashes(hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort);
                    }
                    else {
                        compute_hashes(hdr.ipv4.dstAddr, hdr.ipv4.srcAddr, hdr.tcp.dstPort, hdr.tcp.srcPort);
                    }
                    // Packet comes from internal network
                    if (direction == 0){
                        // If there is a syn we update the bloom filter and add the entry
                        if (hdr.tcp.syn == 1){
                            bloom_filter_1.write(reg_pos_one, 1);
                            bloom_filter_2.write(reg_pos_two, 1);
                        }
                    }
                    // Packet comes from outside
                    else if (direction == 1){
                        // Read bloom filter cells to check if there are 1's
                        bloom_filter_1.read(reg_val_one, reg_pos_one);
                        bloom_filter_2.read(reg_val_two, reg_pos_two);
                        // only allow flow to pass if both entries are set
                        if (reg_val_one != 1 || reg_val_two != 1){
                            drop();
                        }
                    }
                }
            }
        }
    }
}

/*************************************************************************
****************  E G R E S S   P R O C E S S I N G   *******************
*************************************************************************/

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}

/*************************************************************************
*************   C H E C K S U M    C O M P U T A T I O N   **************
*************************************************************************/

control MyComputeChecksum(inout headers  hdr, inout metadata meta) {
     apply {
        update_checksum(
            hdr.ipv4.isValid(),
            { hdr.ipv4.version,
              hdr.ipv4.ihl,
              hdr.ipv4.diffserv,
              hdr.ipv4.totalLen,
              hdr.ipv4.identification,
              hdr.ipv4.flags,
              hdr.ipv4.fragOffset,
              hdr.ipv4.ttl,
              hdr.ipv4.protocol,
              hdr.ipv4.srcAddr,
              hdr.ipv4.dstAddr },
            hdr.ipv4.hdrChecksum,
            HashAlgorithm.csum16);
    }
}

/*************************************************************************
***********************  D E P A R S E R  *******************************
*************************************************************************/

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.ipv4);
        packet.emit(hdr.tcp);
    }
}

/*************************************************************************
***********************  S W I T C H  *******************************
*************************************************************************/

V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;


```


REQUIREMENTS:
- Target: BMv2 with v1model architecture
- Include all required components: headers, parser, ingress/egress controls, deparser, and V1Switch main block
- Ensure compatibility with p4c compiler
- Use the YANG model schema to understand data structures
- Consider the current network configuration when implementing logic
- Follow the patterns shown in the examples above
- Output exactly one complete, compilable program
- No prose, comments, or markdown in the output
- Start your reply with <p4> on the first line and end with </p4> on the last line

Generate the P4 program now:


Assistant:<p4>