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

+ p4c --target bmv2 --arch v1model --p4runtime-files ef751e25-461c-4c8a-91b2-fd176f78acdc.p4info.txtpb /work_space/ef751e25-461c-4c8a-91b2-fd176f78acdc.p4
/work_space/ef751e25-461c-4c8a-91b2-fd176f78acdc.p4(188): [--Werror=unsupported] error: IfStatement: not supported within a deparser on this target
        if (hdr.ipv4.isValid()) {
        ^^
/work_space/ef751e25-461c-4c8a-91b2-fd176f78acdc.p4(191): [--Werror=unsupported] error: IfStatement: not supported within a deparser on this target
        if (hdr.tcp.isValid()) {
        ^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''ef751e25-461c-4c8a-91b2-fd176f78acdc.p4info.txtpb'\'';config='\''ef751e25-461c-4c8a-91b2-fd176f78acdc.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test1 ... ERROR

======================================================================
ERROR: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test1
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 20, in setUp
    success = bt.P4RuntimeTest.updateConfig(self)
  File "/root/p4c/tools/ptf/base_test.py", line 263, in updateConfig
    with open(config_path, "rb") as config_f:
FileNotFoundError: [Errno 2] No such file or directory: 'ef751e25-461c-4c8a-91b2-fd176f78acdc.json'

----------------------------------------------------------------------
Ran 1 test in 0.007s

FAILED (errors=1)
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test2 ... Exception in thread Thread-7:
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
	debug_error_string = "{"created":"@1760649080.796113787","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test3 ... Exception in thread Thread-10:
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
	debug_error_string = "{"created":"@1760649082.799142489","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test3
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test4 ... Exception in thread Thread-13:
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
	debug_error_string = "{"created":"@1760649084.802227054","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test4
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test5 ... Exception in thread Thread-16:
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
	debug_error_string = "{"created":"@1760649086.805260553","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test6 ... Exception in thread Thread-19:
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
	debug_error_string = "{"created":"@1760649088.808554232","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test6
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test7 ... Exception in thread Thread-22:
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
	debug_error_string = "{"created":"@1760649090.811730455","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test8 ... Exception in thread Thread-25:
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
	debug_error_string = "{"created":"@1760649092.815038317","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test8
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test9 ... Exception in thread Thread-28:
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
	debug_error_string = "{"created":"@1760649094.817935869","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: ef751e25-461c-4c8a-91b2-fd176f78acdc.Test9
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/ef751e25-461c-4c8a-91b2-fd176f78acdc.py", line 19, in setUp
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
ef751e25-461c-4c8a-91b2-fd176f78acdc.Test10 ... Exception in thread Thread-31:
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
	debug_error_string = "{"created":"@1760649096.820952857","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
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