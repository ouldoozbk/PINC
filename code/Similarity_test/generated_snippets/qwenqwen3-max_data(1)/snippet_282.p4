/work_space/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4(103): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4(103): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4info.txtpb /work_space/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4
/work_space/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4(103): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4(103): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.p4info.txtpb'\'';config='\''45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.114s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test7 ... 07:30:10.825  dataplane : ERROR   : send: no port 257 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test8 ... 07:30:10.934  dataplane : ERROR   : send: no port 257 for device 0
FAIL

======================================================================
FAIL: 45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test8
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.py", line 743, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.py", line 738, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 06 FF F9 00 00 00 00 00 00  ................
0020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0030  00 00 00 00 00 00 00 00 00                       .........
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.009s

FAILED (failures=1)
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test9 ... 07:30:12.943  dataplane : ERROR   : send: no port 257 for device 0
FAIL

======================================================================
FAIL: 45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test9
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.py", line 818, in runTest
    self.runTestImpl()
  File "/root/p4c/tools/ptf/base_test.py", line 1150, in handle
    return f(*args, **kwargs)
  File "out-p4testgen/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.py", line 47, in runTestImpl
    self.verifyPackets()
  File "out-p4testgen/45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.py", line 813, in verifyPackets
    ptfutils.verify_packet(self, exp_pkt, eg_port)
  File "/usr/local/lib/python3.8/site-packages/ptf/testutils.py", line 3199, in verify_packet
    test.fail(
AssertionError: Expected packet was not received on device 0, port 0.
========== EXPECTED ==========
Mask:
0000  00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00  ................
0010  00 00 00 00 00 00 00 06 FF F9 00 00 00 00 00 00  ................
0020  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
0030  00 00 00 00 00 00 00 00 00                       .........
mask = ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0010   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0020   ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
0030   ff ff ff ff ff ff ff ff  ff

========== RECEIVED ==========
0 total packets.
==============================


----------------------------------------------------------------------
Ran 1 test in 2.008s

FAILED (failures=1)
45cb21e4-4fa9-4ce9-aac8-0c0e3aae8092.Test10 ... + echo ''
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