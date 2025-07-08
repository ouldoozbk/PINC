#include <core.p4>
#include <v1model.p4>

// Ethernet header
header ethernet_t {
    bit<48> dstAddr;
    bit<48> srcAddr;
    bit<16> etherType;
}

// IPv4 header
header ipv4_t {
    bit<4>  version;
    bit<4>  ihl;
    bit<8>  diffserv;
    bit<16> totalLen;
    bit<16> identification;
    bit<3>  flags;
    bit<13> fragOffset;
    bit<8>  ttl;
    bit<8>  protocol;
    bit<16> hdrChecksum;
    bit<32> srcAddr;
    bit<32> dstAddr;
}

// Header and metadata structures
struct headers_t {
    ethernet_t eth;
    ipv4_t ipv4;
}

struct metadata_t { }

// Actions with smeta as parameter
action forward_1(inout standard_metadata_t smeta) {
    smeta.egress_spec = 1;
}

action forward_2(inout standard_metadata_t smeta) {
    smeta.egress_spec = 2;
}

action drop_pkt(inout standard_metadata_t smeta) {
    mark_to_drop(smeta);
}

// Parser
parser MyParser(packet_in packet,
                out headers_t hdr,
                inout metadata_t meta,
                inout standard_metadata_t smeta) {
    state start {
        packet.extract(hdr.eth);
        transition select(hdr.eth.etherType) {
            0x0800: parse_ipv4;
            default: accept;
        }
    }

    state parse_ipv4 {
        packet.extract(hdr.ipv4);
        transition accept;
    }
}

// Checksum verification
control MyVerifyChecksum(inout headers_t hdr, inout metadata_t meta) {
    apply { }
}

// Ingress control
control MyIngress(inout headers_t hdr, inout metadata_t meta, inout standard_metadata_t smeta) {

    @counter("direct")
    table ipv4_fwd {
        key = {
            hdr.ipv4.dstAddr : lpm;
        }
        actions = {
            forward_1(smeta);
            forward_2(smeta);
            drop_pkt(smeta);
        }
        size = 1024;
        default_action = drop_pkt(smeta);
    }

    apply {
        ipv4_fwd.apply();
    }
}

// Egress
control MyEgress(inout headers_t hdr, inout metadata_t meta, inout standard_metadata_t smeta) {
    apply { }
}

// Checksum computation
control MyComputeChecksum(inout headers_t hdr, inout metadata_t meta) {
    apply { }
}

// Deparser
control MyDeparser(packet_out packet, in headers_t hdr) {
    apply {
        packet.emit(hdr.eth);
        packet.emit(hdr.ipv4);
    }
}

// Instantiate the switch
V1Switch(
    MyParser(),
    MyVerifyChecksum(),
    MyIngress(),
    MyEgress(),
    MyComputeChecksum(),
    MyDeparser()
) main;

