# P4Runtime PTF test for out-p4testgen/VLAN100
# p4testgen seed: none

from enum import Enum

from ptf.mask import Mask

from ptf.packet import *
from ptf import testutils as ptfutils


import base_test as bt


class AbstractTest(bt.P4RuntimeTest):
    EnumColor = Enum("EnumColor", ["GREEN", "YELLOW", "RED"], start=0)

    def setUp(self):
        bt.P4RuntimeTest.setUp(self)
        success = bt.P4RuntimeTest.updateConfig(self)
        assert success
        packet_wait_time = ptfutils.test_param_get("packet_wait_time")
        if not packet_wait_time:
            self.packet_wait_time = 0.1
        else:
            self.packet_wait_time = float(packet_wait_time)


    def tearDown(self):
        bt.P4RuntimeTest.tearDown(self)

    def setupCtrlPlane(self):
        pass

    def sendPacket(self):
        pass

    def verifyPackets(self):
        pass

    @bt.autocleanup
    def runTestImpl(self):
        self.setupCtrlPlane()
        bt.testutils.log.info("Sending Packet ...")
        self.sendPacket()
        bt.testutils.log.info("Verifying Packet ...")
        self.verifyPackets()

    def meter_write_with_predefined_config(self, meter_name, index, value, direct):
        """Since we can not blast the target with packets, we have to carefully craft an artificial scenario where the meter will return the color we want. We do this by setting the meter config in such a way that the meter is forced to assign the desired color. For example, for RED to the lowest threshold values, to force a RED assignment."""
        value = self.EnumColor(value)
        if value == self.EnumColor.GREEN:
            meter_config = bt.p4runtime_pb2.MeterConfig(
                cir=4294967295, cburst=4294967295, pir=4294967295, pburst=4294967295
            )
        elif value == self.EnumColor.YELLOW:
            meter_config = bt.p4runtime_pb2.MeterConfig(
                cir=1, cburst=1, pir=4294967295, pburst=4294967295
            )
        elif value == self.EnumColor.RED:
            meter_config = bt.p4runtime_pb2.MeterConfig(
                cir=1, cburst=1, pir=1, pburst=1
            )
        else:
            raise self.failureException(f"Unsupported meter value {value}")
        if direct:
            meter_obj = self.get_obj("direct_meters", meter_name)
            table_id = meter_obj.direct_table_id
            req, _ = self.make_table_read_request_by_id(table_id)
            table_entry = None
            for response in self.response_dump_helper(req):
                for entity in response.entities:
                    assert entity.WhichOneof("entity") == "table_entry"
                    table_entry = entity.table_entry
                    break
            if table_entry is None:
                raise self.failureException(
                    "No entry in the table that the meter is attached to."
                )
            return self.direct_meter_write(meter_config, table_id, table_entry)
        return self.meter_write(meter_name, index, meter_config)

class Test1(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.875
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractSuccess] hdr.vlan@112 | Condition: |*packetLen_bits(bit<32>)| >= 144; | Extract Size: 32 -> hdr.vlan.pcp = 0x0 | hdr.vlan.cfi = 0x0 | hdr.vlan.vid = 0x000 | hdr.vlan.etherType = 0x0800
    [State] parse_inner_ethernet
    [MethodCall]: packet.extract<ethernet_t>(hdr.inner_ethernet);
    [ExtractSuccess] hdr.inner_ethernet@144 | Condition: |*packetLen_bits(bit<32>)| >= 256; | Extract Size: 112 -> hdr.inner_ethernet.dstAddr = 0x0000_0000_0000 | hdr.inner_ethernet.srcAddr = 0x0000_0000_0000 | hdr.inner_ethernet.etherType = 0x0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !true && |bmv2_ingress_port(bit<9>)| == 1; Result: false
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Emit]: {$headerValid:true;;    pcp:0;  cfi:0;  vid:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:0;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test2(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.898
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractSuccess] hdr.vlan@112 | Condition: |*packetLen_bits(bit<32>)| >= 144; | Extract Size: 32 -> hdr.vlan.pcp = 0x0 | hdr.vlan.cfi = 0x0 | hdr.vlan.vid = 0x000 | hdr.vlan.etherType = 0x0800
    [State] parse_inner_ethernet
    [MethodCall]: packet.extract<ethernet_t>(hdr.inner_ethernet);
    [ExtractFailure] hdr.inner_ethernet@144 | Condition: !(|*packetLen_bits(bit<32>)| >= 256); | Extract Size: 112
    [P4Testgen AssignmentStatement]: standard_metadata.parser_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !true && |bmv2_ingress_port(bit<9>)| == 1; Result: false
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Emit]: {$headerValid:true;;    pcp:0;  cfi:0;  vid:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test3(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.909
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractSuccess] hdr.vlan@112 | Condition: |*packetLen_bits(bit<32>)| >= 144; | Extract Size: 32 -> hdr.vlan.pcp = 0x0 | hdr.vlan.cfi = 0x0 | hdr.vlan.vid = 0x000 | hdr.vlan.etherType = 0x0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !true && |bmv2_ingress_port(bit<9>)| == 1; Result: false
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Emit]: {$headerValid:true;;    pcp:0;  cfi:0;  vid:0;  etherType:0;  }
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test4(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.937
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractFailure] hdr.vlan@112 | Condition: !(|*packetLen_bits(bit<32>)| >= 144); | Extract Size: 32
    [P4Testgen AssignmentStatement]: standard_metadata.parser_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: true
    [MethodCall]: add_vlan_0/add_vlan.apply();
    [Table Branch: MyIngress.add_vlan | Key(s): |bmv2_ingress_port(bit<9>)|| Chosen action: MyIngress.add_vlan_tag]
    [MethodCall]: add_vlan_tag(|MyIngress.add_vlan_MyIngress.add_vlan_tag_arg_vid_1(bit<12>)|);
    [MethodCall]: hdr.vlan.setValid();
    [AssignmentStatement]: hdr.vlan.vid = vid;| Computed: hdr.vlan.vid = 0;
    [AssignmentStatement]: hdr.vlan.etherType = hdr.ethernet.etherType;| Computed: hdr.vlan.etherType = 33024;
    [AssignmentStatement]: hdr.ethernet.etherType = TYPE_VLAN;| Computed: hdr.ethernet.etherType = 33024;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Emit]: {$headerValid:true;;    pcp:0;  cfi:0;  vid:0;  etherType:33024;  }
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.add_vlan',
            [
                self.Exact('standard_metadata.ingress_port', 0x001),
            ]),
            ('MyIngress.add_vlan_tag',
            [
                ('vid', 0x000),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 1
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x81\x00\x00\x00\x00')
        exp_pkt.set_do_not_care(112, 4)
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test5(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.942
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractFailure] hdr.vlan@112 | Condition: !(|*packetLen_bits(bit<32>)| >= 144); | Extract Size: 32
    [P4Testgen AssignmentStatement]: standard_metadata.parser_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: true
    [MethodCall]: add_vlan_0/add_vlan.apply();
    [Table Branch: MyIngress.add_vlan | Key(s): |bmv2_ingress_port(bit<9>)|| Chosen action: NoAction]
    [MethodCall]: NoAction_1/NoAction();
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Invalid emit: { pcp = TaintedExpression(bit<3>), cfi = TaintedExpression(bit<1>), vid = TaintedExpression(bit<12>), etherType = TaintedExpression(bit<16>) }]
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.add_vlan',
            [
                self.Exact('standard_metadata.ingress_port', 0x001),
            ]),
            ('NoAction',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 1
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test6(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.948
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractFailure] hdr.vlan@112 | Condition: !(|*packetLen_bits(bit<32>)| >= 144); | Extract Size: 32
    [P4Testgen AssignmentStatement]: standard_metadata.parser_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: true
    [MethodCall]: add_vlan_0/add_vlan.apply();
    [Table Branch: MyIngress.add_vlan Choosing default action: NoAction_1/NoAction;]
    [MethodCall]: NoAction_1/NoAction();
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Invalid emit: { pcp = TaintedExpression(bit<3>), cfi = TaintedExpression(bit<1>), vid = TaintedExpression(bit<12>), etherType = TaintedExpression(bit<16>) }]
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 1
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test7(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.951
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x8100
    [State] parse_vlan
    [MethodCall]: packet.extract<vlan_t>(hdr.vlan);
    [ExtractFailure] hdr.vlan@112 | Condition: !(|*packetLen_bits(bit<32>)| >= 144); | Extract Size: 32
    [P4Testgen AssignmentStatement]: standard_metadata.parser_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: false
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Invalid emit: { pcp = TaintedExpression(bit<3>), cfi = TaintedExpression(bit<1>), vid = TaintedExpression(bit<12>), etherType = TaintedExpression(bit<16>) }]
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test8(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.957
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: true
    [MethodCall]: add_vlan_0/add_vlan.apply();
    [Table Branch: MyIngress.add_vlan | Key(s): |bmv2_ingress_port(bit<9>)|| Chosen action: MyIngress.add_vlan_tag]
    [MethodCall]: add_vlan_tag(|MyIngress.add_vlan_MyIngress.add_vlan_tag_arg_vid_1(bit<12>)|);
    [MethodCall]: hdr.vlan.setValid();
    [AssignmentStatement]: hdr.vlan.vid = vid;| Computed: hdr.vlan.vid = 0;
    [AssignmentStatement]: hdr.vlan.etherType = hdr.ethernet.etherType;| Computed: hdr.vlan.etherType = 0;
    [AssignmentStatement]: hdr.ethernet.etherType = TYPE_VLAN;| Computed: hdr.ethernet.etherType = 33024;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:33024;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Emit]: {$headerValid:true;;    pcp:0;  cfi:0;  vid:0;  etherType:0;  }
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.add_vlan',
            [
                self.Exact('standard_metadata.ingress_port', 0x001),
            ]),
            ('MyIngress.add_vlan_tag',
            [
                ('vid', 0x000),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 1
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x81\x00\x00\x00\x00\x00\x00\x00\x00')
        exp_pkt.set_do_not_care(112, 4)
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test9(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.960
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: true
    [MethodCall]: add_vlan_0/add_vlan.apply();
    [Table Branch: MyIngress.add_vlan | Key(s): |bmv2_ingress_port(bit<9>)|| Chosen action: NoAction]
    [MethodCall]: NoAction_1/NoAction();
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:0;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Invalid emit: { pcp = TaintedExpression(bit<3>), cfi = TaintedExpression(bit<1>), vid = TaintedExpression(bit<12>), etherType = TaintedExpression(bit<16>) }]
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.add_vlan',
            [
                self.Exact('standard_metadata.ingress_port', 0x001),
            ]),
            ('NoAction',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 1
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test10(AbstractTest):
    '''
    Date generated: 2025-07-06-03:06:00.963
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [If Statement]: hdr.vlan.isValid() == false && standard_metadata.ingress_port == PORT_1 Condition: !false && |bmv2_ingress_port(bit<9>)| == 1; Result: true
    [MethodCall]: add_vlan_0/add_vlan.apply();
    [Table Branch: MyIngress.add_vlan Choosing default action: NoAction_1/NoAction;]
    [MethodCall]: NoAction_1/NoAction();
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:0;  }
    [MethodCall]: packet.emit<vlan_t>(hdr.vlan);
    [Invalid emit: { pcp = TaintedExpression(bit<3>), cfi = TaintedExpression(bit<1>), vid = TaintedExpression(bit<12>), etherType = TaintedExpression(bit<16>) }]
    [MethodCall]: packet.emit<ethernet_t>(hdr.inner_ethernet);
    [Invalid emit: { dstAddr = TaintedExpression(bit<48>), srcAddr = TaintedExpression(bit<48>), etherType = TaintedExpression(bit<16>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 0; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 1
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()

