# P4Runtime PTF test for out-p4testgen/Verify
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
    Date generated: 2025-07-08-21:49:24.547
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0x0000 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: MyIngress.ipv4_forward]
    [MethodCall]: ipv4_forward(|MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_dstAddr_1(bit<48>)|, |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 511;
    [AssignmentStatement]: hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;| Computed: hdr.ethernet.srcAddr = 0;
    [AssignmentStatement]: hdr.ethernet.dstAddr = dstAddr;| Computed: hdr.ethernet.dstAddr = 0;
    [AssignmentStatement]: hdr.ipv4.ttl = hdr.ipv4.ttl - 1;| Computed: hdr.ipv4.ttl = 255;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:255;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('MyIngress.ipv4_forward',
            [
                ('dstAddr', 0x000000000000),
                ('port', 0x1FF),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x00\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test2(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.591
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0xFC00 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: MyIngress.ipv4_forward]
    [MethodCall]: ipv4_forward(|MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_dstAddr_1(bit<48>)|, |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 0;
    [AssignmentStatement]: hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;| Computed: hdr.ethernet.srcAddr = 0;
    [AssignmentStatement]: hdr.ethernet.dstAddr = dstAddr;| Computed: hdr.ethernet.dstAddr = 0;
    [AssignmentStatement]: hdr.ipv4.ttl = hdr.ipv4.ttl - 1;| Computed: hdr.ipv4.ttl = 255;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:255;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('MyIngress.ipv4_forward',
            [
                ('dstAddr', 0x000000000000),
                ('port', 0x000),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x00\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\x00\xFC\xFF\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test3(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.606
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0xFC00 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: NoAction]
    [MethodCall]: NoAction_1/NoAction();
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:0;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
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
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('NoAction',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x00\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x00\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test4(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.636
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0xFC00 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: MyIngress.drop]
    [MethodCall]: drop();
    [MethodCall]: mark_to_drop(standard_metadata);
    [mark_to_drop executed.]
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:0;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 511; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('MyIngress.drop',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x00\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test5(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.650
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0xFC00 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x0000_0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm Choosing default action: drop;]
    [MethodCall]: drop();
    [MethodCall]: mark_to_drop(standard_metadata);
    [mark_to_drop executed.]
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:0;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:0;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 511; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test6(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.665
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0x0000 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen AssignmentStatement]: *standard_metadata.checksum_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: MyIngress.ipv4_forward]
    [MethodCall]: ipv4_forward(|MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_dstAddr_1(bit<48>)|, |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 511;
    [AssignmentStatement]: hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;| Computed: hdr.ethernet.srcAddr = 0;
    [AssignmentStatement]: hdr.ethernet.dstAddr = dstAddr;| Computed: hdr.ethernet.dstAddr = 0;
    [AssignmentStatement]: hdr.ipv4.ttl = hdr.ipv4.ttl - 1;| Computed: hdr.ipv4.ttl = 255;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:255;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('MyIngress.ipv4_forward',
            [
                ('dstAddr', 0x000000000000),
                ('port', 0x1FF),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test7(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.670
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0x0093 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen AssignmentStatement]: *standard_metadata.checksum_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: MyIngress.ipv4_forward]
    [MethodCall]: ipv4_forward(|MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_dstAddr_1(bit<48>)|, |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 0;
    [AssignmentStatement]: hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;| Computed: hdr.ethernet.srcAddr = 0;
    [AssignmentStatement]: hdr.ethernet.dstAddr = dstAddr;| Computed: hdr.ethernet.dstAddr = 0;
    [AssignmentStatement]: hdr.ipv4.ttl = hdr.ipv4.ttl - 1;| Computed: hdr.ipv4.ttl = 255;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:255;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.ipv4_lpm_MyIngress.ipv4_forward_arg_port(bit<9>)|; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('MyIngress.ipv4_forward',
            [
                ('dstAddr', 0x000000000000),
                ('port', 0x000),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFF\x00\xFC\xFF\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test8(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.678
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0x0093 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen AssignmentStatement]: *standard_metadata.checksum_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: NoAction]
    [MethodCall]: NoAction_1/NoAction();
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 0;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:0;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
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
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('NoAction',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xFC\x00\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test9(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.686
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0x0093 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x03FF_FFFF
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen AssignmentStatement]: *standard_metadata.checksum_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm | Key(s): |pktvar_14(bit<32>)|| Chosen action: MyIngress.drop]
    [MethodCall]: drop();
    [MethodCall]: mark_to_drop(standard_metadata);
    [mark_to_drop executed.]
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:0;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:67108863;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 511; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.ipv4_lpm',
            [
                self.Lpm('hdr.ipv4.dstAddr', 0x03FFFFFF, 32),
            ]),
            ('MyIngress.drop',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x93\x00\x00\x00\x00\x03\xFF\xFF\xFF\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test10(AbstractTest):
    '''
    Date generated: 2025-07-08-21:49:24.697
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x0800
    [State] parse_ipv4
    [MethodCall]: packet.extract<ipv4_t>(hdr.ipv4);
    [ExtractSuccess] hdr.ipv4@112 | Condition: |*packetLen_bits(bit<32>)| >= 272; | Extract Size: 160 -> hdr.ipv4.version = 0x0 | hdr.ipv4.ihl = 0x0 | hdr.ipv4.diffserv = 0x00 | hdr.ipv4.totalLen = 0x0000 | hdr.ipv4.identification = 0x0000 | hdr.ipv4.flags = 0x0 | hdr.ipv4.fragOffset = 0x0000 | hdr.ipv4.ttl = 0x00 | hdr.ipv4.protocol = 0x00 | hdr.ipv4.hdrChecksum = 0x0093 | hdr.ipv4.srcAddr = 0x0000_0000 | hdr.ipv4.dstAddr = 0x0000_0000
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [MethodCall]: verify_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen AssignmentStatement]: *standard_metadata.checksum_error = 1;
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: ipv4_lpm_0/ipv4_lpm.apply();
    [Table Branch: MyIngress.ipv4_lpm Choosing default action: drop;]
    [MethodCall]: drop();
    [MethodCall]: mark_to_drop(standard_metadata);
    [mark_to_drop executed.]
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
    [P4Testgen If Statement]: Condition: 0 != 0; Result: false
    [P4Testgen MethodCall]: *.copy_in("MyEgress");
    [Control MyEgress start]
    [P4Testgen MethodCall]: *.copy_out("MyEgress");
    [P4Testgen MethodCall]: *.copy_in("MyComputeChecksum");
    [Control MyComputeChecksum start]
    [MethodCall]: update_checksum<tuple_0, bit<16>>(hdr.ipv4.isValid(), {  f0:hdr.ipv4.version;  f1:hdr.ipv4.ihl;  f2:hdr.ipv4.diffserv;  f3:hdr.ipv4.totalLen;  f4:hdr.ipv4.identification;  f5:hdr.ipv4.flags;  f6:hdr.ipv4.fragOffset;  f7:hdr.ipv4.ttl;  f8:hdr.ipv4.protocol;  f9:hdr.ipv4.srcAddr;  f10:hdr.ipv4.dstAddr; }, hdr.ipv4.hdrChecksum, 6);
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:2048;  }
    [MethodCall]: packet.emit<ipv4_t>(hdr.ipv4);
    [Emit]: {$headerValid:true;;    version:0;  ihl:0;  diffserv:0;  totalLen:0;  identification:0;  flags:0;  fragOffset:0;  ttl:0;  protocol:0;  hdrChecksum:0;  srcAddr:0;  dstAddr:0;  }
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == 511; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x08\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x10\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()