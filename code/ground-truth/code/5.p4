#include <core.p4>
#include <v1model.p4>

const bit<16> ETHERTYPE_IPV4 = 0x0800;
const bit<8> PROTOCOL_GRE = 47;
const bit<16> GRE_PROTOCOL_IPV4 = 0x0800;

typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16> etherType;
}

header ipv4_t {
    bit<4> version;
    bit<4> ihl;
    bit<8> diffserv;
    bit<16> totalLen;
    bit<16> identification;
    bit<3> flags;
    bit<13> fragOffset;
    bit<8> ttl;
    bit<8> protocol;
    bit<16> hdrChecksum;
    ip4Addr_t srcAddr;
    ip4Addr_t dstAddr;
}

header gre_t {
    bit<1> C;
    bit<1> R;
    bit<1> K;
    bit<1> S;
    bit<1> s;
    bit<3> recurse;
    bit<5> flags;
    bit<3> version;
    bit<16> protocol;
}

struct metadata {
    bit<1> needs_gre_encap;
}

struct headers {
    ethernet_t ethernet;
    ipv4_t outer_ipv4;
    gre_t gre;
    ipv4_t inner_ipv4;
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
            ETHERTYPE_IPV4: parse_ipv4;
            default: accept;
        }
    }

    state parse_ipv4 {
        packet.extract(hdr.inner_ipv4);
        transition accept;
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {
        verify_checksum(
            hdr.inner_ipv4.isValid(),
            {
                hdr.inner_ipv4.version,
                hdr.inner_ipv4.ihl,
                hdr.inner_ipv4.diffserv,
                hdr.inner_ipv4.totalLen,
                hdr.inner_ipv4.identification,
                hdr.inner_ipv4.flags,
                hdr.inner_ipv4.fragOffset,
                hdr.inner_ipv4.ttl,
                hdr.inner_ipv4.protocol,
                hdr.inner_ipv4.srcAddr,
                hdr.inner_ipv4.dstAddr
            },
            hdr.inner_ipv4.hdrChecksum,
            HashAlgorithm.csum16
        );
    }
}

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    action gre_encap(ip4Addr_t tunnel_src, ip4Addr_t tunnel_dst, bit<9> egress_port) {
        hdr.outer_ipv4.setValid();
        hdr.outer_ipv4.version = 4;
        hdr.outer_ipv4.ihl = 5;
        hdr.outer_ipv4.diffserv = 0;
        hdr.outer_ipv4.totalLen = hdr.inner_ipv4.totalLen + 24;
        hdr.outer_ipv4.identification = 0;
        hdr.outer_ipv4.flags = 0;
        hdr.outer_ipv4.fragOffset = 0;
        hdr.outer_ipv4.ttl = 64;
        hdr.outer_ipv4.protocol = PROTOCOL_GRE;
        hdr.outer_ipv4.hdrChecksum = 0;
        hdr.outer_ipv4.srcAddr = tunnel_src;
        hdr.outer_ipv4.dstAddr = tunnel_dst;

        hdr.gre.setValid();
        hdr.gre.C = 0;
        hdr.gre.R = 0;
        hdr.gre.K = 0;
        hdr.gre.S = 0;
        hdr.gre.s = 0;
        hdr.gre.recurse = 0;
        hdr.gre.flags = 0;
        hdr.gre.version = 0;
        hdr.gre.protocol = GRE_PROTOCOL_IPV4;

        standard_metadata.egress_spec = egress_port;
    }

    action drop() {
        mark_to_drop(standard_metadata);
    }

    table gre_tunnel {
        key = {
            hdr.inner_ipv4.dstAddr: lpm;
        }
        actions = {
            gre_encap;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    apply {
        if (hdr.inner_ipv4.isValid()) {
            gre_tunnel.apply();
        }
    }
}

control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {
    apply { }
}

control MyComputeChecksum(inout headers hdr, inout metadata meta) {
    apply {
        update_checksum(
            hdr.outer_ipv4.isValid(),
            {
                hdr.outer_ipv4.version,
                hdr.outer_ipv4.ihl,
                hdr.outer_ipv4.diffserv,
                hdr.outer_ipv4.totalLen,
                hdr.outer_ipv4.identification,
                hdr.outer_ipv4.flags,
                hdr.outer_ipv4.fragOffset,
                hdr.outer_ipv4.ttl,
                hdr.outer_ipv4.protocol,
                hdr.outer_ipv4.srcAddr,
                hdr.outer_ipv4.dstAddr
            },
            hdr.outer_ipv4.hdrChecksum,
            HashAlgorithm.csum16
        );

        update_checksum(
            hdr.inner_ipv4.isValid(),
            {
                hdr.inner_ipv4.version,
                hdr.inner_ipv4.ihl,
                hdr.inner_ipv4.diffserv,
                hdr.inner_ipv4.totalLen,
                hdr.inner_ipv4.identification,
                hdr.inner_ipv4.flags,
                hdr.inner_ipv4.fragOffset,
                hdr.inner_ipv4.ttl,
                hdr.inner_ipv4.protocol,
                hdr.inner_ipv4.srcAddr,
                hdr.inner_ipv4.dstAddr
            },
            hdr.inner_ipv4.hdrChecksum,
            HashAlgorithm.csum16
        );
    }
}

control MyDeparser(packet_out packet, in headers hdr) {
    apply {
        packet.emit(hdr.ethernet);
        packet.emit(hdr.outer_ipv4);
        packet.emit(hdr.gre);
        packet.emit(hdr.inner_ipv4);
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