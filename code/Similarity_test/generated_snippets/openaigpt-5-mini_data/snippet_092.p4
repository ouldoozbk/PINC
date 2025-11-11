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

+ p4c --target bmv2 --arch v1model --p4runtime-files feb3a087-5e24-45a8-8376-32f2f5e2e341.p4info.txtpb /work_space/feb3a087-5e24-45a8-8376-32f2f5e2e341.p4
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''feb3a087-5e24-45a8-8376-32f2f5e2e341.p4info.txtpb'\'';config='\''feb3a087-5e24-45a8-8376-32f2f5e2e341.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
feb3a087-5e24-45a8-8376-32f2f5e2e341.Test1 ... 21:10:04.830  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
feb3a087-5e24-45a8-8376-32f2f5e2e341.Test2 ... 21:10:04.938  dataplane : ERROR   : send: no port 447 for device 0
ERROR

======================================================================
ERROR: feb3a087-5e24-45a8-8376-32f2f5e2e341.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/feb3a087-5e24-45a8-8376-32f2f5e2e341.py", line 225, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/feb3a087-5e24-45a8-8376-32f2f5e2e341.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/feb3a087-5e24-45a8-8376-32f2f5e2e341.py", line 220, in verifyPackets
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
Ran 1 test in 0.008s

FAILED (errors=1)
feb3a087-5e24-45a8-8376-32f2f5e2e341.Test3 ... 21:10:04.945  dataplane : ERROR   : send: no port 447 for device 0
FAIL

======================================================================
FAIL: feb3a087-5e24-45a8-8376-32f2f5e2e341.Test3
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/feb3a087-5e24-45a8-8376-32f2f5e2e341.py", line 298, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/feb3a087-5e24-45a8-8376-32f2f5e2e341.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/feb3a087-5e24-45a8-8376-32f2f5e2e341.py", line 293, in verifyPackets
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
Ran 1 test in 2.007s

FAILED (failures=1)
feb3a087-5e24-45a8-8376-32f2f5e2e341.Test4 ... 21:10:06.953  dataplane : ERROR   : send: no port 447 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
feb3a087-5e24-45a8-8376-32f2f5e2e341.Test5 ... 21:10:07.059  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.109s

OK
feb3a087-5e24-45a8-8376-32f2f5e2e341.Test6 ... + echo ''
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