#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_IPV4 = 0x800;
const bit<8>  TYPE_ARP  = 0x806;
const bit<8>  TYPE_ICMP = 1;

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

header arp_t {
    bit<16> hwType;
    bit<16> protoType;
    bit<8>  hwSize;
    bit<8>  protoSize;
    bit<16> opcode;
    macAddr_t srcMac;
    ip4Addr_t srcIp;
    macAddr_t dstMac;
    ip4Addr_t dstIp;
}

header icmp_t {
    bit<8> type;
    bit<8> code;
    bit<16> checksum;
    bit<16> id;
    bit<16> seq;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t   ethernet;
    ipv4_t       ipv4;
    arp_t        arp;
    icmp_t       icmp;
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
            TYPE_IPV4: parse_ipv4;
            TYPE_ARP: parse_arp;
            TYPE_ICMP: parse_icmp;
            default: accept;
        }
    }

    state parse_ipv4 {
        packet.extract(hdr.ipv4);
        transition select(hdr.ipv4.protocol){
            TYPE_ARP: parse_arp;
            TYPE_ICMP: parse_icmp;
            default: accept;
        }
    }

    state parse_arp {
        packet.extract(hdr.arp);
        transition accept;
    }

    state parse_icmp {
        packet.extract(hdr.icmp);
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

    action ipv4_forward(macAddr_t dstAddr, egressSpec_t port) {
        standard_metadata.egress_spec = port;
        hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
        hdr.ethernet.dstAddr = dstAddr;
        hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
    }

    action arp_reply(macAddr_t srcMac, macAddr_t dstMac, ip4Addr_t srcIp, ip4Addr_t dstIp) {
        hdr.ethernet.srcAddr = srcMac;
        hdr.ethernet.dstAddr = dstMac;
        hdr.arp.hwType = 1;
        hdr.arp.protoType = TYPE_IPV4;
        hdr.arp.hwSize = 6;
        hdr.arp.protoSize = 4;
        hdr.arp.opcode = 2;
        hdr.arp.srcMac = srcMac;
        hdr.arp.srcIp = srcIp;
        hdr.arp.dstMac = dstMac;
        hdr.arp.dstIp = dstIp;
    }

    action icmp_echo_reply(ip4Addr_t srcIp, ip4Addr_t dstIp) {
        hdr.icmp.type = 0;
        hdr.icmp.code = 0;
        hdr.icmp.checksum = 0;
        hdr.icmp.id = hdr.icmp.id + 1;
        hdr.icmp.seq = hdr.icmp.seq + 1;
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

    table arp_table {
        key = {
            hdr.arp.dstIp: exact;
        }
        actions = {
            arp_reply;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    table icmp_table {
        key = {
            hdr.icmp.id: exact;
            hdr.icmp.seq: exact;
        }
        actions = {
            icmp_echo_reply;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    apply {
        if (hdr.ipv4.isValid()){
            ipv4_lpm.apply();
        }
        if (hdr.arp.isValid()){
            arp_table.apply();
        }
        if (hdr.icmp.isValid()){
            icmp_table.apply();
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

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.ipv4);
        packet.emit(hdr.arp);
        packet.emit(hdr.icmp);
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