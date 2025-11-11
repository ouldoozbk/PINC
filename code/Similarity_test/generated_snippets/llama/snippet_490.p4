/work_space/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

============ Test 2 ============
============ End Test 2 ============

============ Test 3 ============
============ End Test 3 ============

+ p4c --target bmv2 --arch v1model --p4runtime-files 77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.p4info.txtpb /work_space/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.p4
/work_space/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
+ /bin/rm -f ss-log.txt
+ echo ''
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
+ for i in {1..20}
+ simple_switch_grpc --log-file ss-log --log-flush --dump-packet-data 10000 -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 -i 5@veth10 -i 6@veth12 -i 7@veth14 --no-p4
+ nc -z localhost 9559
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.p4info.txtpb'\'';config='\''77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.Test1 ... FAIL

======================================================================
FAIL: 77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.Test1
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.py", line 154, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.py", line 149, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0020  00 00 12 34 56 78 90 AB CD EF DE AD BE EF 12 34  ...4Vx.........4
0030  56 78 00 00 00 00 00 00 00 00 00 00 00 00 00 00  Vx..............
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
0110  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0120  00                                               .
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
0110   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0120   ff  

========== RECEIVED ==========
1 total packets. Displaying most recent 1 packets:
------------------------------
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
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
0110  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0120  00                                               .
==============================


----------------------------------------------------------------------
Ran 1 test in 2.011s

FAILED (failures=1)
77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.Test2 ... FAIL

======================================================================
FAIL: 77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.py", line 228, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.py", line 223, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 12 34  ...............4
0010  56 78 90 AB CD EF DE AD BE EF 12 34 56 78 00 00  Vx.........4Vx..
0020  00                                               .
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff  

========== RECEIVED ==========
1 total packets. Displaying most recent 1 packets:
------------------------------
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0020  00                                               .
==============================


----------------------------------------------------------------------
Ran 1 test in 2.006s

FAILED (failures=1)
77c75a17-31f5-4f0f-9e56-ef1dc5841d5b.Test3 ... + echo ''
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