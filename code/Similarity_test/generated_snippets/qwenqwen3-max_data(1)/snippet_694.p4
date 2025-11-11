/work_space/0e50a686-3a1e-4ec4-a199-e6339f66976f.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 0e50a686-3a1e-4ec4-a199-e6339f66976f.p4info.txtpb /work_space/0e50a686-3a1e-4ec4-a199-e6339f66976f.p4
/work_space/0e50a686-3a1e-4ec4-a199-e6339f66976f.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''0e50a686-3a1e-4ec4-a199-e6339f66976f.p4info.txtpb'\'';config='\''0e50a686-3a1e-4ec4-a199-e6339f66976f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.107s

OK
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test5 ... 07:45:57.248  dataplane : ERROR   : send: no port 258 for device 0
FAIL

======================================================================
FAIL: 0e50a686-3a1e-4ec4-a199-e6339f66976f.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 552, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 547, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 12 34 FF FF  .............4..
0010  FF FF 00 00 FF 00 00 00 00 00 00 00              ............
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.009s

FAILED (failures=1)
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test6 ... 07:45:59.257  dataplane : ERROR   : send: no port 258 for device 0
FAIL

======================================================================
FAIL: 0e50a686-3a1e-4ec4-a199-e6339f66976f.Test6
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 649, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 644, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 12 34 FF FF  .............4..
0010  FF FF 00 00 FF 00 00 00 00 00 00 00              ............
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.008s

FAILED (failures=1)
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test7 ... 07:46:01.265  dataplane : ERROR   : send: no port 258 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test8 ... 07:46:01.373  dataplane : ERROR   : send: no port 258 for device 0
FAIL

======================================================================
FAIL: 0e50a686-3a1e-4ec4-a199-e6339f66976f.Test8
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 831, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/0e50a686-3a1e-4ec4-a199-e6339f66976f.py", line 826, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 12 34 FF FF  .............4..
0010  FF FF 00 00 FF 00 00 00 00 00 00 00              ............
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.008s

FAILED (failures=1)
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test9 ... 07:46:03.381  dataplane : ERROR   : send: no port 258 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
0e50a686-3a1e-4ec4-a199-e6339f66976f.Test10 ... 07:46:03.489  dataplane : ERROR   : send: no port 258 for device 0
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