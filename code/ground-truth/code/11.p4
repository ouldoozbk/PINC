#include <core.p4>
#include <v1model.p4>




typedef bit<48> macAddr_t;
header ethernet_t {
    macAddr_t dstAddr;
    macAddr_t srcAddr;
    bit<16>   etherType;
}

struct metadata {

/* empty */
}

struct headers {
    ethernet_t   ethernet;
}




parser MyParser(packet_in packet,
                out headers hdr,
                inout metadata meta,
                inout standard_metadata_t standard_metadata) {

    state start {

        packet.extract(hdr.ethernet);
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


    action forward(bit<9> egress_port) {
        standard_metadata.egress_spec = egress_port;
    }


    table basic_forwarding {

        key = {
            hdr.ethernet.dstAddr: exact;
        }

        actions = {
            forward;
            drop;
        }

        size = 4;

        default_action = drop();

    }

    

    apply {

        basic_forwarding.apply();
    }
}



control MyEgress(inout headers hdr,
                 inout metadata meta,
                 inout standard_metadata_t standard_metadata) {


    apply {  }
}



control MyComputeChecksum(inout headers hdr, inout metadata meta) {
     apply {

    }
}




control MyDeparser(packet_out packet, in headers hdr) {
    apply {

        packet.emit(hdr.ethernet);
    }
}




//switch architecture
V1Switch(
MyParser(),
MyVerifyChecksum(),
MyIngress(),
MyEgress(),
MyComputeChecksum(),
MyDeparser()
) main;