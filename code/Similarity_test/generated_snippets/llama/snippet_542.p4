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

+ p4c --target bmv2 --arch v1model --p4runtime-files 7715247e-3c5c-46df-a09e-ea91709e8f0a.p4info.txtpb /work_space/7715247e-3c5c-46df-a09e-ea91709e8f0a.p4
+ /bin/rm -f ss-log.txt
+ echo ''
+ simple_switch_grpc --log-file ss-log --log-flush --dump-packet-data 10000 -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 -i 5@veth10 -i 6@veth12 -i 7@veth14 --no-p4
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''7715247e-3c5c-46df-a09e-ea91709e8f0a.p4info.txtpb'\'';config='\''7715247e-3c5c-46df-a09e-ea91709e8f0a.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.115s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.114s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test5 ... FAIL

======================================================================
FAIL: 7715247e-3c5c-46df-a09e-ea91709e8f0a.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/7715247e-3c5c-46df-a09e-ea91709e8f0a.py", line 718, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/7715247e-3c5c-46df-a09e-ea91709e8f0a.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/7715247e-3c5c-46df-a09e-ea91709e8f0a.py", line 713, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 FF 06 FC F9 00 00 00 00 03 FF  ................
0020  FF FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0030  00 00 00 00 00 00 00 00 00                       .........
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.011s

FAILED (failures=1)
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test7 ... FAIL

======================================================================
FAIL: 7715247e-3c5c-46df-a09e-ea91709e8f0a.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/7715247e-3c5c-46df-a09e-ea91709e8f0a.py", line 973, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/7715247e-3c5c-46df-a09e-ea91709e8f0a.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/7715247e-3c5c-46df-a09e-ea91709e8f0a.py", line 968, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 FF 06 FC F9 00 00 00 00 03 FF  ................
0020  FF FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0030  00 00 00 00 00 00 00 00 00                       .........
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.010s

FAILED (failures=1)
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
7715247e-3c5c-46df-a09e-ea91709e8f0a.Test10 ... + echo ''
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