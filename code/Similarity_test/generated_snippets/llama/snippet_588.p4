/work_space/3914a1d8-fceb-42ab-9ebe-8350c51009f9.p4(107): [--Wwarn=unused] warning: 'ecmp_group_id' is unused
    action ecmp_group(bit<32> ecmp_group_id) {
                              ^^^^^^^^^^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 3914a1d8-fceb-42ab-9ebe-8350c51009f9.p4info.txtpb /work_space/3914a1d8-fceb-42ab-9ebe-8350c51009f9.p4
/work_space/3914a1d8-fceb-42ab-9ebe-8350c51009f9.p4(107): [--Wwarn=unused] warning: 'ecmp_group_id' is unused
    action ecmp_group(bit<32> ecmp_group_id) {
                              ^^^^^^^^^^^^^
/work_space/3914a1d8-fceb-42ab-9ebe-8350c51009f9.p4(107): [--Wwarn=unused] warning: Unused action parameter ecmp_group_id
    action ecmp_group(bit<32> ecmp_group_id) {
                              ^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''3914a1d8-fceb-42ab-9ebe-8350c51009f9.p4info.txtpb'\'';config='\''3914a1d8-fceb-42ab-9ebe-8350c51009f9.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.123s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test2 ... ERROR

======================================================================
ERROR: 3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/3914a1d8-fceb-42ab-9ebe-8350c51009f9.py", line 343, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/3914a1d8-fceb-42ab-9ebe-8350c51009f9.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/3914a1d8-fceb-42ab-9ebe-8350c51009f9.py", line 338, in verifyPackets
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
Ran 1 test in 0.014s

FAILED (errors=1)
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test5 ... ERROR

======================================================================
ERROR: 3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/3914a1d8-fceb-42ab-9ebe-8350c51009f9.py", line 733, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/3914a1d8-fceb-42ab-9ebe-8350c51009f9.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/3914a1d8-fceb-42ab-9ebe-8350c51009f9.py", line 728, in verifyPackets
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
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
3914a1d8-fceb-42ab-9ebe-8350c51009f9.Test10 ... + echo ''
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