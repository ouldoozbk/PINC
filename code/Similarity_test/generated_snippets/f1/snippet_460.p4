#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_IPV6 = 0x86DD;
const bit<8>  TYPE_ICMP = 1;

typedef bit<9>  egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<128> ip6Addr_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}

header ipv6_t {
    bit<4>    version;
    bit<4>    traffic_class;
    bit<8>    flow_label;
    bit<16>   payload_length;
    bit<8>    next_header;
    bit<8>    hop_limit;
    ip6Addr_t srcAddr;
    ip6Addr_t dstAddr;
}

header icmp6_t {
    bit<8>  type;
    bit<8>  code;
    bit<16> checksum;
    bit<32> reserved;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t   ethernet;
    ipv6_t       ipv6;
    icmp6_t      icmp6;
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
        transition select(hdr.ipv6.next_header){
            TYPE_ICMP: icmp6;
            default: accept;
        }
    }

    state icmp6 {
       packet.extract(hdr.icmp6);
       transition accept;
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {  }
}

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    action drop() {
        mark_to_drop(standard_metadata);
    }

    action ipv6_forward(macAddr_t dstAddr, egressSpec_t port) {
        standard_metadata.egress_spec = port;
        hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
        hdr.ethernet.dstAddr = dstAddr;
        hdr.ipv6.hop_limit = hdr.ipv6.hop_limit - 1;
    }

    table ipv6_lpm {
        key = {
            hdr.ipv6.dstAddr: lpm;
        }
        actions = {
            ipv6_forward;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = drop();
    }

    apply {
        if (hdr.ipv6.isValid()){
            ipv6_lpm.apply();
        }
    }
}

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply {  }
}

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
     apply {
        update_checksum(
            hdr.ipv6.isValid(),
            { hdr.ipv6.version,
              hdr.ipv6.traffic_class,
              hdr.ipv6.flow_label,
              hdr.ipv6.payload_length,
              hdr.ipv6.next_header,
              hdr.ipv6.hop_limit,
              hdr.ipv6.srcAddr,
              hdr.ipv6.dstAddr },
            hdr.ipv6.checksum,
            HashAlgorithm.csum16);
    }
}

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.ipv6);
        packet.emit(hdr.icmp6);
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