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

+ p4c --target bmv2 --arch v1model --p4runtime-files 1732e8f2-e1c5-4c14-99eb-eb57fef345fc.p4info.txtpb /work_space/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.p4
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''1732e8f2-e1c5-4c14-99eb-eb57fef345fc.p4info.txtpb'\'';config='\''1732e8f2-e1c5-4c14-99eb-eb57fef345fc.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.171s

OK
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test2 ... ERROR

======================================================================
ERROR: 1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 299, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 294, in verifyPackets
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
Ran 1 test in 0.043s

FAILED (errors=1)
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.129s

OK
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test5 ... ERROR

======================================================================
ERROR: 1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 635, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 630, in verifyPackets
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
KeyError: (0, 255)

----------------------------------------------------------------------
Ran 1 test in 0.013s

FAILED (errors=1)
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test7 ... ERROR

======================================================================
ERROR: 1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 856, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 851, in verifyPackets
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
KeyError: (0, 255)

----------------------------------------------------------------------
Ran 1 test in 0.012s

FAILED (errors=1)
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test9 ... ERROR

======================================================================
ERROR: 1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test9
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 1071, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/1732e8f2-e1c5-4c14-99eb-eb57fef345fc.py", line 1066, in verifyPackets
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
Ran 1 test in 0.010s

FAILED (errors=1)
1732e8f2-e1c5-4c14-99eb-eb57fef345fc.Test10 ... + echo ''
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