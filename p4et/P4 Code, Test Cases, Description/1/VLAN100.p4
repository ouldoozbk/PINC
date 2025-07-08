#include <core.p4>
#include <v1model.p4>

const bit<16> TYPE_VLAN = 0x8100;
const bit<16> TYPE_IPV4 = 0x800;
const bit<12> VLAN_ID = 100;
const bit<9> PORT_1 = 1;

typedef bit<9> egressSpec_t;
typedef bit<48> macAddr_t;
typedef bit<32> ip4Addr_t;
typedef bit<12> vlan_id_t;
typedef bit<3> vlan_pcp_t;

header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16> etherType;
}

header vlan_t {
    bit<3> pcp;
    bit<1> cfi;
    vlan_id_t vid;
    bit<16> etherType;
}

struct metadata {
    /* empty */
}

struct headers {
    ethernet_t ethernet;
    vlan_t vlan;
    ethernet_t inner_ethernet;
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
            TYPE_VLAN: parse_vlan;
            default: accept;
        }
    }

    state parse_vlan {
        packet.extract(hdr.vlan);
        transition select(hdr.vlan.etherType) {
            TYPE_IPV4: parse_inner_ethernet;
            default: accept;
        }
    }

    state parse_inner_ethernet {
        packet.extract(hdr.inner_ethernet);
        transition accept;
    }
}

control MyVerifyChecksum(inout headers hdr, inout metadata meta) {
    apply { }
}

control MyIngress(inout headers hdr,
                  inout metadata meta,
                  inout standard_metadata_t standard_metadata) {
    action add_vlan_tag(vlan_id_t vid) {
        hdr.vlan.setValid();
        hdr.vlan.vid = vid;
        hdr.vlan.etherType = hdr.ethernet.etherType;
        hdr.ethernet.etherType = TYPE_VLAN;
    }

    action set_egress_port(egressSpec_t port) {
        standard_metadata.egress_spec = port;
    }

    table add_vlan {
        key = {
            standard_metadata.ingress_port: exact;
        }
        actions = {
            add_vlan_tag;
            NoAction;
        }
        size = 1024;
        default_action = NoAction();
    }

    apply {
        if (hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1) {
            add_vlan.apply();
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
        packet.emit(hdr.vlan);
        packet.emit(hdr.inner_ethernet);
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