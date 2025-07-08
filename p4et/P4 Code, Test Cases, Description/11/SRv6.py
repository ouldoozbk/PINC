# P4Runtime PTF test for out-p4testgen/SRv6
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
    Date generated: 2025-07-08-21:13:16.488
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x01 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.srv6_end]
    [MethodCall]: srv6_end();
    [AssignmentStatement]: hdr.ipv6.dstAddr = tmp;| Computed: hdr.ipv6.dstAddr = 0;
    [AssignmentStatement]: hdr.ipv6.nextHdr = hdr.srv6.nextHdr;| Computed: hdr.ipv6.nextHdr = 0;
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
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:0;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:1;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
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
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.srv6_end',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test2(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.509
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x01 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.drop]
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
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:1;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
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
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.drop',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test3(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.519
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x01 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.srv6_forward]
    [MethodCall]: srv6_forward(|MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 511;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
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
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:1;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.srv6_forward',
            [
                ('port', 0x1FF),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test4(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.522
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x01 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.srv6_forward]
    [MethodCall]: srv6_forward(|MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 0;
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
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:1;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.srv6_forward',
            [
                ('port', 0x000),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test5(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.549
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x01 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact Choosing default action: drop;]
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
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:1;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
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
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test6(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.562
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x02 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 2;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids1
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[1]);
    [ExtractSuccess] hdr.srv6_sids[32w1]@640 | Condition: |*packetLen_bits(bit<32>)| >= 768; | Extract Size: 128 -> hdr.srv6_sids[32w1].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.srv6_end]
    [MethodCall]: srv6_end();
    [AssignmentStatement]: hdr.ipv6.dstAddr = tmp;| Computed: hdr.ipv6.dstAddr = 0;
    [AssignmentStatement]: hdr.ipv6.nextHdr = hdr.srv6.nextHdr;| Computed: hdr.ipv6.nextHdr = 0;
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
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:0;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:2;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
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
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.srv6_end',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test7(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.567
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x02 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 2;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids1
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[1]);
    [ExtractSuccess] hdr.srv6_sids[32w1]@640 | Condition: |*packetLen_bits(bit<32>)| >= 768; | Extract Size: 128 -> hdr.srv6_sids[32w1].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.drop]
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
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:2;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
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
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.drop',
            [
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test8(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.572
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x02 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 2;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids1
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[1]);
    [ExtractSuccess] hdr.srv6_sids[32w1]@640 | Condition: |*packetLen_bits(bit<32>)| >= 768; | Extract Size: 128 -> hdr.srv6_sids[32w1].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.srv6_forward]
    [MethodCall]: srv6_forward(|MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 511;
    [P4Testgen MethodCall]: *.copy_out("MyIngress");
    [P4Testgen AssignmentStatement]: *standard_metadata.egress_port = 511;
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
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:2;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|; Result: true
    [P4Testgen MethodCall]: *.drop_and_exit();
    [Packet marked dropped]
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.srv6_forward',
            [
                ('port', 0x1FF),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test9(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.574
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x02 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 2;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids1
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[1]);
    [ExtractSuccess] hdr.srv6_sids[32w1]@640 | Condition: |*packetLen_bits(bit<32>)| >= 768; | Extract Size: 128 -> hdr.srv6_sids[32w1].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact | Key(s): |pktvar_10(bit<128>)|| Chosen action: MyIngress.srv6_forward]
    [MethodCall]: srv6_forward(|MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|);
    [AssignmentStatement]: standard_metadata.egress_spec = port;| Computed: standard_metadata.egress_spec = 0;
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
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:2;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [P4Testgen MethodCall]: *.copy_out("MyDeparser");
    [P4Testgen MethodCall]: *.prepend_emit_buffer();
    [Prepending the emit buffer to the program packet]
    [P4Testgen If Statement]: Condition: 511 == |MyIngress.srv6_exact_MyIngress.srv6_forward_arg_port(bit<9>)|; Result: false
    [P4Testgen MethodCall]: *.invoke_traffic_manager();
    '''

    def setupCtrlPlane(self):
        # Simple noop that is always called as filler.
        pass
        self.table_add(
            ('MyIngress.srv6_exact',
            [
                self.Exact('hdr.ipv6.dstAddr', 0x00000000000000000000000000000000),
            ]),
            ('MyIngress.srv6_forward',
            [
                ('port', 0x000),
            ])
            , None
            
        )


    def sendPacket(self):
        ig_port = 0
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        eg_port = 0
        exp_pkt = Mask(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
        ptfutils.verify_packet(self, exp_pkt, eg_port)
        bt.testutils.log.info("Verifying no other packets ...")
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()


class Test10(AbstractTest):
    '''
    Date generated: 2025-07-08-21:13:16.579
    Current node coverage: 0
    Trace:
    [P4Testgen MethodCall]: *.copy_in("MyParser");
    [Parser] MyParser
    [State] start
    [MethodCall]: packet.extract<ethernet_t>(hdr.ethernet);
    [ExtractSuccess] hdr.ethernet@0 | Condition: |*packetLen_bits(bit<32>)| >= 112; | Extract Size: 112 -> hdr.ethernet.dstAddr = 0x0000_0000_0000 | hdr.ethernet.srcAddr = 0x0000_0000_0000 | hdr.ethernet.etherType = 0x86DD
    [State] parse_ipv6
    [MethodCall]: packet.extract<ipv6_t>(hdr.ipv6);
    [ExtractSuccess] hdr.ipv6@112 | Condition: |*packetLen_bits(bit<32>)| >= 432; | Extract Size: 320 -> hdr.ipv6.version = 0x0 | hdr.ipv6.trafficClass = 0x00 | hdr.ipv6.flowLabel = 0x0000_0000 | hdr.ipv6.payloadLen = 0x0000 | hdr.ipv6.nextHdr = 0x43 | hdr.ipv6.hopLimit = 0x00 | hdr.ipv6.srcAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000 | hdr.ipv6.dstAddr = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [State] parse_srv6
    [MethodCall]: packet.extract<srv6_t>(hdr.srv6);
    [ExtractSuccess] hdr.srv6@432 | Condition: |*packetLen_bits(bit<32>)| >= 512; | Extract Size: 80 -> hdr.srv6.nextHdr = 0x00 | hdr.srv6.hdrExtLen = 0x00 | hdr.srv6.routingType = 0x00 | hdr.srv6.segmentsLeft = 0x02 | hdr.srv6.lastEntry = 0x00 | hdr.srv6.flags = 0x00 | hdr.srv6.tag = 0x0000_0000
    [AssignmentStatement]: meta.remaining = hdr.srv6.segmentsLeft;| Computed: meta.remaining = 2;
    [State] parse_srv6_sids
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[0]);
    [ExtractSuccess] hdr.srv6_sids[32w0]@512 | Condition: |*packetLen_bits(bit<32>)| >= 640; | Extract Size: 128 -> hdr.srv6_sids[32w0].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 1;
    [State] parse_srv6_sids1
    [MethodCall]: packet.extract<srv6_sid_t>(hdr.srv6_sids[1]);
    [ExtractSuccess] hdr.srv6_sids[32w1]@640 | Condition: |*packetLen_bits(bit<32>)| >= 768; | Extract Size: 128 -> hdr.srv6_sids[32w1].sid = 0x0000_0000_0000_0000_0000_0000_0000_0000
    [AssignmentStatement]: meta.remaining = meta.remaining - 1;| Computed: meta.remaining = 0;
    [State] accept
    [P4Testgen MethodCall]: *.copy_out("MyParser");
    [P4Testgen MethodCall]: *.copy_in("MyVerifyChecksum");
    [Control MyVerifyChecksum start]
    [P4Testgen MethodCall]: *.copy_out("MyVerifyChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyIngress");
    [Control MyIngress start]
    [P4Testgen If Statement]: Condition: true; Result: true
    [MethodCall]: srv6_exact_0/srv6_exact.apply();
    [Table Branch: MyIngress.srv6_exact Choosing default action: drop;]
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
    [P4Testgen MethodCall]: *.copy_out("MyComputeChecksum");
    [P4Testgen MethodCall]: *.copy_in("MyDeparser");
    [Control MyDeparser start]
    [MethodCall]: packet.emit<ethernet_t>(hdr.ethernet);
    [Emit]: {$headerValid:true;;    dstAddr:0;  srcAddr:0;  etherType:34525;  }
    [MethodCall]: packet.emit<ipv6_t>(hdr.ipv6);
    [Emit]: {$headerValid:true;;    version:0;  trafficClass:0;  flowLabel:0;  payloadLen:0;  nextHdr:67;  hopLimit:0;  srcAddr:0;  dstAddr:0;  }
    [MethodCall]: packet.emit<srv6_t>(hdr.srv6);
    [Emit]: {$headerValid:true;;    nextHdr:0;  hdrExtLen:0;  routingType:0;  segmentsLeft:2;  lastEntry:0;  flags:0;  tag:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[0]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[1]);
    [Emit]: {$headerValid:true;;    sid:0;  }
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[2]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[3]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[4]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[5]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[6]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[7]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[8]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[9]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[10]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[11]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[12]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[13]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[14]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
    [MethodCall]: packet.emit<srv6_sid_t>(hdr.srv6_sids[15]);
    [Invalid emit: { sid = TaintedExpression(bit<128>) }]
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
        pkt = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x86\xDD\x00\x00\x00\x00\x00\x00\x43\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
        ptfutils.send_packet(self, ig_port, pkt)

    def verifyPackets(self):
        ptfutils.verify_no_other_packets(self, self.device_id, timeout=self.packet_wait_time)

    def runTest(self):
        self.runTestImpl()
