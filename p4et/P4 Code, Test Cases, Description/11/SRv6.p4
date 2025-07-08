#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_IPV6 = 0x86DD;
const bit<8> SRH_NEXT_HEADER = 0x43;

typedef bit<9> egressSpec_t;
typedef bit<128> ipv6Addr_t;

header ethernet_t {
    bit<48> dstAddr;
    bit<48> srcAddr;
    bit<16> etherType;
}

header ipv6_t {
    bit<4> version;
    bit<8> trafficClass;
    bit<20> flowLabel;
    bit<16> payloadLen;
    bit<8> nextHdr;
    bit<8> hopLimit;
    ipv6Addr_t srcAddr;
    ipv6Addr_t dstAddr;
}

header srv6_t {
    bit<8> nextHdr;
    bit<8> hdrExtLen;
    bit<8> routingType;
    bit<8> segmentsLeft;
    bit<8> lastEntry;
    bit<8> flags;
    bit<32> tag;
}

header srv6_sid_t {
    ipv6Addr_t sid;
}

struct metadata {
    bit<8> remaining;
}

struct headers {
    ethernet_t ethernet;
    ipv6_t ipv6;
    srv6_t srv6;
    srv6_sid_t[16] srv6_sids;
}

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
            TYPE_IPV6: parse_ipv6;
            default: accept;
        }
    }

    state parse_ipv6 {
        packet.extract(hdr.ipv6);
        transition select(hdr.ipv6.nextHdr) {
            SRH_NEXT_HEADER: parse_srv6;
            default: accept;
        }
    }

    state parse_srv6 {
        packet.extract(hdr.srv6);
        meta.remaining = hdr.srv6.segmentsLeft;
        transition parse_srv6_sids;
    }

    state parse_srv6_sids {
        packet.extract(hdr.srv6_sids.next);
        meta.remaining = meta.remaining - 1;
        transition select(meta.remaining) {
            0: accept;
            default: parse_srv6_sids;
        }
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply { }
}

control MyIngress(inout headers hdr,
                   inout metadata meta,
                   inout standard_metadata_t standard_metadata) {
    action drop() {
        mark_to_drop(standard_metadata);
    }

    action srv6_end() {
        ipv6Addr_t tmp = hdr.srv6_sids[0].sid;
        hdr.ipv6.dstAddr = tmp;
        hdr.ipv6.nextHdr = hdr.srv6.nextHdr;
    }

    action srv6_forward(egressSpec_t port) {
        standard_metadata.egress_spec = port;
    }

    table srv6_exact {
        key = { hdr.ipv6.dstAddr: exact; }
        actions = { srv6_end; srv6_forward; drop; }
        size = 1024;
        default_action = drop();
    }

    apply {
        if (hdr.ipv6.isValid()) {
            srv6_exact.apply();
        }
    }
}

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply { }
}

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
    apply { }
}

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.ipv6);
        packet.emit(hdr.srv6);
        packet.emit(hdr.srv6_sids);
    }
}

V1Switch(
    MyParser(),
    MyVerifyChecksum(),
    MyIngress(),
    MyEgress(),
    MyComputeChecksum(),
    MyDeparser()
) main;