/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(124): [--Wwarn=unused] warning: 'send_to_controller' is unused
    action send_to_controller() {
           ^^^^^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(128): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(140): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(128): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(140): [--Winfo=removed] info: removing table 'firewall_table'
    table firewall_table {
          ^^^^^^^^^^^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4info.txtpb /work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(124): [--Wwarn=unused] warning: 'send_to_controller' is unused
    action send_to_controller() {
           ^^^^^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(128): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(140): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(128): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(140): [--Winfo=removed] info: removing table 'firewall_table'
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(31): [--Werror=target-error] error: header tcp_t: Found header with fields totaling 161 bits.  BMv2 target only supports headers with fields totaling a multiple of 8 bits.
header tcp_t {
       ^^^^^
/work_space/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4(208): [--Werror=unsupported] error: IfStatement: not supported within a deparser on this target
        if (hdr.tcp.isValid()) {
        ^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.p4info.txtpb'\'';config='\''1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test1 ... ERROR

======================================================================
ERROR: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test1
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 20, in setUp
    success = bt.P4RuntimeTest.updateConfig(self)
  File "/root/p4c/tools/ptf/base_test.py", line 263, in updateConfig
    with open(config_path, "rb") as config_f:
FileNotFoundError: [Errno 2] No such file or directory: '1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.json'

----------------------------------------------------------------------
Ran 1 test in 0.007s

FAILED (errors=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test2 ... Exception in thread Thread-7:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514611.375601907","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test3 ... Exception in thread Thread-10:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514613.378228360","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test3
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test4 ... Exception in thread Thread-13:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514615.381119741","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test4
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test5 ... Exception in thread Thread-16:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514617.383811969","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test6 ... Exception in thread Thread-19:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514619.386433766","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test6
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.007s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test7 ... Exception in thread Thread-22:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514621.393548517","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test8 ... Exception in thread Thread-25:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514623.396382994","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test8
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test9 ... Exception in thread Thread-28:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514625.399060299","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test9
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.003s

FAILED (failures=1)
1d2a9376-dbfe-4e4c-bd0b-f58ee09aec75.Test10 ... Exception in thread Thread-31:
Traceback (most recent call last):
  File "/usr/lib/python3.8/threading.py", line 932, in _bootstrap_inner
    self.run()
  File "/usr/lib/python3.8/threading.py", line 870, in run
    self._target(*self._args, **self._kwargs)
  File "/root/p4c/tools/ptf/base_test.py", line 329, in stream_recv
    for p in stream:
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 426, in __next__
    return self._next()
  File "/usr/local/lib/python3.8/site-packages/grpc/_channel.py", line 826, in _next
    raise self
grpc._channel._MultiThreadedRendezvous: <_MultiThreadedRendezvous of RPC that terminated with:
	status = StatusCode.INVALID_ARGUMENT
	details = "Election id already exists"
	debug_error_string = "{"created":"@1760514627.401850447","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
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