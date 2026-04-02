#include <core.p4>
#include <v1model.p4>

const bit<16> ETHERTYPE_IPV4 = 0x0800;
const bit<8> IPPROTO_IPIP = 4;

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

struct metadata {
    bool is_tunneled;
}

struct headers {
    ethernet_t ethernet;
    ipv4_t outer_ipv4;
    ipv4_t inner_ipv4;
}

parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {
        meta.is_tunneled = false;
        transition parse_ethernet;
    }

    state parse_ethernet {
        packet.extract(hdr.ethernet);
        transition select(hdr.ethernet.etherType) {
            ETHERTYPE_IPV4: parse_outer_ipv4;
            default: accept;
        }
    }

    state parse_outer_ipv4 {
        packet.extract(hdr.outer_ipv4);
        transition select(hdr.outer_ipv4.protocol) {
            IPPROTO_IPIP: parse_inner_ipv4;
            default: accept;
        }
    }

    state parse_inner_ipv4 {
        packet.extract(hdr.inner_ipv4);
        meta.is_tunneled = true;
        transition accept;
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply {
        verify_checksum(
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
    }
}

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {

    action decapsulate_tunnel() {
        hdr.outer_ipv4.setInvalid();
        hdr.ethernet.etherType = ETHERTYPE_IPV4;
    }

    action forward(bit<9> port) {
        standard_metadata.egress_spec = port;
    }

    action drop() {
        mark_to_drop(standard_metadata);
    }

    table tunnel_decap {
        key = {
            hdr.outer_ipv4.dstAddr: exact;
            hdr.outer_ipv4.protocol: exact;
        }
        actions = {
            decapsulate_tunnel;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    table ipv4_forward {
        key = {
            hdr.inner_ipv4.dstAddr: lpm;
        }
        actions = {
            forward;
            drop;
            NoAction;
        }
        size = 1024;
        default_action = drop();
    }

    apply {
        if (hdr.outer_ipv4.isValid() && hdr.inner_ipv4.isValid()) {
            tunnel_decap.apply();
            ipv4_forward.apply();
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