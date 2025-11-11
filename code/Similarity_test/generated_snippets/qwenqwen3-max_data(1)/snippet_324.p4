/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(125): [--Wwarn=unused] warning: 'apply_firewall' is unused
    action apply_firewall(bit<16> port, bit<8> action_code) {
           ^^^^^^^^^^^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(125): [--Wwarn=unused] warning: 'port' is unused
    action apply_firewall(bit<16> port, bit<8> action_code) {
                                  ^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(125): [--Wwarn=unused] warning: 'action_code' is unused
    action apply_firewall(bit<16> port, bit<8> action_code) {
                                               ^^^^^^^^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(126): [--Wwarn=unused] warning: 'match' is unused
        bool match = false;
        ^^^^^^^^^^^^^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

============ Test 2 ============
============ End Test 2 ============

============ Test 3 ============
============ End Test 3 ============

============ Test 4 ============
============ End Test 4 ============

============ Test 5 ============
============ End Test 5 ============

============ Test 6 ============
============ End Test 6 ============

============ Test 7 ============
============ End Test 7 ============

============ Test 8 ============
============ End Test 8 ============

============ Test 9 ============
============ End Test 9 ============

============ Test 10 ============
============ End Test 10 ============

+ p4c --target bmv2 --arch v1model --p4runtime-files 0c0497e7-bb74-4667-9975-39c3e6c26cab.p4info.txtpb /work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(125): [--Wwarn=unused] warning: 'apply_firewall' is unused
    action apply_firewall(bit<16> port, bit<8> action_code) {
           ^^^^^^^^^^^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(125): [--Wwarn=unused] warning: 'port' is unused
    action apply_firewall(bit<16> port, bit<8> action_code) {
                                  ^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(125): [--Wwarn=unused] warning: 'action_code' is unused
    action apply_firewall(bit<16> port, bit<8> action_code) {
                                               ^^^^^^^^^^^
/work_space/0c0497e7-bb74-4667-9975-39c3e6c26cab.p4(126): [--Wwarn=unused] warning: 'match' is unused
        bool match = false;
        ^^^^^^^^^^^^^^^^^^
+ /bin/rm -f ss-log.txt
+ echo ''
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
+ for i in {1..20}
+ nc -z localhost 9559
+ simple_switch_grpc --log-file ss-log --log-flush --dump-packet-data 10000 -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 -i 5@veth10 -i 6@veth12 -i 7@veth14 --no-p4
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''0c0497e7-bb74-4667-9975-39c3e6c26cab.p4info.txtpb'\'';config='\''0c0497e7-bb74-4667-9975-39c3e6c26cab.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test9 ... 07:32:05.505  dataplane : ERROR   : send: no port 9 for device 0
FAIL

======================================================================
FAIL: 0c0497e7-bb74-4667-9975-39c3e6c26cab.Test9
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/0c0497e7-bb74-4667-9975-39c3e6c26cab.py", line 755, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/0c0497e7-bb74-4667-9975-39c3e6c26cab.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/0c0497e7-bb74-4667-9975-39c3e6c26cab.py", line 750, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 04 FF FB 00 00 00 00 00 00  ................
0020  00 00 00 00 00 00 00 00 00 00 00 00 FF FF 00 00  ................
0030  00 00 00 00 00 00 00 00 00                       .........
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.006s

FAILED (failures=1)
0c0497e7-bb74-4667-9975-39c3e6c26cab.Test10 ... + echo ''
+ echo 'PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ...'
+ pkill --signal 9 --list-name simple_switch
+ echo ''
+ echo 'Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ...'
+ for i in {1..20}
+ pgrep -f simple_switch_grpc
+ echo 'simple_switch_grpc terminated'
+ break
+ ps axguwww
+ grep simple_switch