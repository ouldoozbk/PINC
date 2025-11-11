/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(83): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(96): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(83): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(96): [--Winfo=removed] info: removing table 'firewall_table'
    table firewall_table {
          ^^^^^^^^^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

warning: Concolic constraints for this path are unsatisfiable.
============ Test 3 ============
============ End Test 3 ============

warning: Concolic constraints for this path are unsatisfiable.
============ Test 5 ============
============ End Test 5 ============

warning: Concolic constraints for this path are unsatisfiable.
============ Test 7 ============
============ End Test 7 ============

============ Test 8 ============
============ End Test 8 ============

============ Test 9 ============
============ End Test 9 ============

============ Test 10 ============
============ End Test 10 ============

+ p4c --target bmv2 --arch v1model --p4runtime-files 7caf0828-74cf-4d98-b26e-6504bd3f9800.p4info.txtpb /work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(83): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(96): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(83): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/7caf0828-74cf-4d98-b26e-6504bd3f9800.p4(96): [--Winfo=removed] info: removing table 'firewall_table'
    table firewall_table {
          ^^^^^^^^^^^^^^
+ /bin/rm -f ss-log.txt
+ echo ''
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
+ simple_switch_grpc --log-file ss-log --log-flush --dump-packet-data 10000 -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 -i 5@veth10 -i 6@veth12 -i 7@veth14 --no-p4
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''7caf0828-74cf-4d98-b26e-6504bd3f9800.p4info.txtpb'\'';config='\''7caf0828-74cf-4d98-b26e-6504bd3f9800.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.109s

OK
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test5 ... 07:20:08.069  dataplane : ERROR   : send: no port 258 for device 0
FAIL

======================================================================
FAIL: 7caf0828-74cf-4d98-b26e-6504bd3f9800.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/7caf0828-74cf-4d98-b26e-6504bd3f9800.py", line 295, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/7caf0828-74cf-4d98-b26e-6504bd3f9800.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/7caf0828-74cf-4d98-b26e-6504bd3f9800.py", line 290, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 01 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 00 FF FF 00 00 00 00 00 00  ................
0020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0030  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0040  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0050  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0060  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0070  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0080  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0090  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00a0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00b0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00c0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00d0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00e0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
00f0  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0100  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0110  00                                               .
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0040   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0050   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0060   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0070   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0080   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0090   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00a0   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00b0   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00c0   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00d0   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00e0   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
00f0   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0100   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0110   ff  

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.007s

FAILED (failures=1)
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.107s

OK
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
7caf0828-74cf-4d98-b26e-6504bd3f9800.Test10 ... + echo ''
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