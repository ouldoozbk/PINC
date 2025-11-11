/work_space/2b994a69-5338-4785-8db5-53669c9269cc.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 2b994a69-5338-4785-8db5-53669c9269cc.p4info.txtpb /work_space/2b994a69-5338-4785-8db5-53669c9269cc.p4
/work_space/2b994a69-5338-4785-8db5-53669c9269cc.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''2b994a69-5338-4785-8db5-53669c9269cc.p4info.txtpb'\'';config='\''2b994a69-5338-4785-8db5-53669c9269cc.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
2b994a69-5338-4785-8db5-53669c9269cc.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.107s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test3 ... 21:15:33.527  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test4 ... 21:15:33.633  dataplane : ERROR   : send: no port 509 for device 0
ERROR

======================================================================
ERROR: 2b994a69-5338-4785-8db5-53669c9269cc.Test4
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/2b994a69-5338-4785-8db5-53669c9269cc.py", line 371, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/2b994a69-5338-4785-8db5-53669c9269cc.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/2b994a69-5338-4785-8db5-53669c9269cc.py", line 366, in verifyPackets
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
KeyError: (0, 509)

----------------------------------------------------------------------
Ran 1 test in 0.006s

FAILED (errors=1)
2b994a69-5338-4785-8db5-53669c9269cc.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test6 ... 21:15:33.745  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test7 ... 21:15:33.851  dataplane : ERROR   : send: no port 479 for device 0
ERROR

======================================================================
ERROR: 2b994a69-5338-4785-8db5-53669c9269cc.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/2b994a69-5338-4785-8db5-53669c9269cc.py", line 586, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/2b994a69-5338-4785-8db5-53669c9269cc.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/2b994a69-5338-4785-8db5-53669c9269cc.py", line 581, in verifyPackets
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
KeyError: (0, 479)

----------------------------------------------------------------------
Ran 1 test in 0.005s

FAILED (errors=1)
2b994a69-5338-4785-8db5-53669c9269cc.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.105s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test9 ... 21:15:33.962  dataplane : ERROR   : send: no port 511 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.106s

OK
2b994a69-5338-4785-8db5-53669c9269cc.Test10 ... 21:15:34.068  dataplane : ERROR   : send: no port 479 for device 0
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