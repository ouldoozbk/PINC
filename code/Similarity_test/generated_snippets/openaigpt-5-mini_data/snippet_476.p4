/work_space/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.p4(4): [--Wwarn=unused] warning: 'egressSpec_t' is unused
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

+ p4c --target bmv2 --arch v1model --p4runtime-files b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.p4info.txtpb /work_space/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.p4
/work_space/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.p4(4): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.p4info.txtpb'\'';config='\''b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test1 ... 21:29:11.916  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test2 ... 21:29:12.023  dataplane : ERROR   : send: no port 447 for device 0
ERROR

======================================================================
ERROR: b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.py", line 231, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.py", line 226, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3195, in verify_packet
    result = dp_poll(
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3171, in dp_poll
    result = test.dataplane.poll(
  File "/usr/local/lib/python3.8/site-packages/ptf/dataplane.py", line 956, in poll
    ret = ptfutils.timed_wait(self.cvar, grab, timeout=timeout)
  File "/usr/local/lib/python3.8/site-packages/ptf/ptfutils.py", line 34, in timed_wait
    val = fn()
  File "/usr/local/lib/python3.8/site-packages/ptf/dataplane.py", line 933, in grab
    for (rcv_port_number, pkt, time) in self.packets(
  File "/usr/local/lib/python3.8/site-packages/ptf/dataplane.py", line 757, in packets
    queue = self.packet_queues[(device, rcv_port)]
KeyError: (0, 447)

----------------------------------------------------------------------
Ran 1 test in 0.007s

FAILED (errors=1)
b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test3 ... 21:29:12.029  dataplane : ERROR   : send: no port 447 for device 0
FAIL

======================================================================
FAIL: b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test3
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.py", line 304, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.py", line 299, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0010  00                                               .
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff  

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.006s

FAILED (failures=1)
b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test4 ... 21:29:14.036  dataplane : ERROR   : send: no port 447 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test5 ... 21:29:14.142  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
b9f5dcd8-e6f9-457c-a46b-72dcd4ded7a4.Test6 ... + echo ''
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