/work_space/bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4(97): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4info.txtpb /work_space/bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4
/work_space/bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4(97): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''bdce6b60-cbc7-4115-abf2-94ae10a30f50.p4info.txtpb'\'';config='\''bdce6b60-cbc7-4115-abf2-94ae10a30f50.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test5 ... 21:19:50.095  dataplane : ERROR   : send: no port 257 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test6 ... 21:19:50.200  dataplane : ERROR   : send: no port 257 for device 0
FAIL

======================================================================
FAIL: bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test6
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/bdce6b60-cbc7-4115-abf2-94ae10a30f50.py", line 535, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/bdce6b60-cbc7-4115-abf2-94ae10a30f50.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/bdce6b60-cbc7-4115-abf2-94ae10a30f50.py", line 530, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 2A  ...............*
0010  00 00 00 00 00 00 00 06 FF CF 00 00 00 00 00 00  ................
0020  00 00 00 00 00 50 00 00 00 00 00 00 00 00 00 00  .....P..........
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
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test7 ... 21:19:52.206  dataplane : ERROR   : send: no port 257 for device 0
FAIL

======================================================================
FAIL: bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/bdce6b60-cbc7-4115-abf2-94ae10a30f50.py", line 611, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/bdce6b60-cbc7-4115-abf2-94ae10a30f50.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/bdce6b60-cbc7-4115-abf2-94ae10a30f50.py", line 606, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 06 FF F9 00 00 00 00 00 00  ................
0020  00 00 00 00 00 40 00 00 00 00 00 00 00 00 00 00  .....@..........
0030  00 00 00 00 00 00 00 00 00                       .........
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.005s

FAILED (failures=1)
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
bdce6b60-cbc7-4115-abf2-94ae10a30f50.Test10 ... 21:19:54.422  dataplane : ERROR   : send: no port 257 for device 0
+ echo ''
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