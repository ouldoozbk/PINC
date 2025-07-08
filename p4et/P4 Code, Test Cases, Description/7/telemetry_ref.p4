// telemetry_ref.p4
#include <core.p4>
#include <v1model.p4>

const bit<8> SWITCH_ID = 0x42;

header ethernet_t {
    bit<48> dstAddr;
    bit<48> srcAddr;
    bit<16> etherType;
}

struct metadata_t {
    bit<8> switch_id;
}

struct headers_t {
    ethernet_t eth;
}

parser MyParser(packet_in packet, out headers_t hdr, inout metadata_t meta, inout standard_metadata_t smeta) {
    state start {
        packet.extract(hdr.eth);
        transition accept;
    }
}

control MyVerifyChecksum(inout headers_t hdr, inout metadata_t meta) {
    apply {}
}

control MyIngress(inout headers_t hdr, inout metadata_t meta, inout standard_metadata_t smeta) {
    apply {
        meta.switch_id = SWITCH_ID;
    }
}

control MyEgress(inout headers_t hdr, inout metadata_t meta, inout standard_metadata_t smeta) {
    apply {}
}

control MyComputeChecksum(inout headers_t hdr, inout metadata_t meta) {
    apply {}
}

control MyDeparser(packet_out packet, in headers_t hdr) {
    apply {
        packet.emit(hdr.eth);
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

