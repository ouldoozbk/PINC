/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(103): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(115): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(129): [--Wwarn=unused] warning: table 'port_firewall' is unused
    table port_firewall {
          ^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(142): [--Wwarn=unused] warning: 'dst_port' is unused
    action allow_tcp_udp(bit<16> dst_port) {
                                 ^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(146): [--Wwarn=unused] warning: table 'tcp_udp_filter' is unused
    table tcp_udp_filter {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(164): [--Wwarn=unused] warning: table 'arp_table' is unused
    table arp_table {
          ^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(103): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(115): [--Winfo=removed] info: removing table 'firewall_table'
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(129): [--Winfo=removed] info: removing table 'port_firewall'
    table port_firewall {
          ^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(146): [--Winfo=removed] info: removing table 'tcp_udp_filter'
    table tcp_udp_filter {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(164): [--Winfo=removed] info: removing table 'arp_table'
    table arp_table {
          ^^^^^^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4info.txtpb /work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(103): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(115): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(129): [--Wwarn=unused] warning: table 'port_firewall' is unused
    table port_firewall {
          ^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(142): [--Wwarn=unused] warning: 'dst_port' is unused
    action allow_tcp_udp(bit<16> dst_port) {
                                 ^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(146): [--Wwarn=unused] warning: table 'tcp_udp_filter' is unused
    table tcp_udp_filter {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(164): [--Wwarn=unused] warning: table 'arp_table' is unused
    table arp_table {
          ^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(103): [--Winfo=removed] info: removing table 'interface_table'
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(115): [--Winfo=removed] info: removing table 'firewall_table'
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(129): [--Winfo=removed] info: removing table 'port_firewall'
    table port_firewall {
          ^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(146): [--Winfo=removed] info: removing table 'tcp_udp_filter'
    table tcp_udp_filter {
          ^^^^^^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(164): [--Winfo=removed] info: removing table 'arp_table'
    table arp_table {
          ^^^^^^^^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(242): [--Werror=unsupported] error: IfStatement: not supported within a deparser on this target
        if (hdr.arp.isValid()) {
        ^^
/work_space/6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4(245): [--Werror=unsupported] error: IfStatement: not supported within a deparser on this target
        if (hdr.ipv4.isValid()) {
        ^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''6b8fe072-ccaf-4904-96ab-797a2eedadd5.p4info.txtpb'\'';config='\''6b8fe072-ccaf-4904-96ab-797a2eedadd5.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test1 ... ERROR

======================================================================
ERROR: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test1
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 20, in setUp
    success = bt.P4RuntimeTest.updateConfig(self)
  File "/root/p4c/tools/ptf/base_test.py", line 263, in updateConfig
    with open(config_path, "rb") as config_f:
FileNotFoundError: [Errno 2] No such file or directory: '6b8fe072-ccaf-4904-96ab-797a2eedadd5.json'

----------------------------------------------------------------------
Ran 1 test in 0.006s

FAILED (errors=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test2 ... Exception in thread Thread-7:
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
	debug_error_string = "{"created":"@1760513980.868400556","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test2
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test3 ... Exception in thread Thread-10:
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
	debug_error_string = "{"created":"@1760513982.870793432","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test3
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test4 ... Exception in thread Thread-13:
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
	debug_error_string = "{"created":"@1760513984.873138409","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test4
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test5 ... Exception in thread Thread-16:
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
	debug_error_string = "{"created":"@1760513986.875594243","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test5
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test6 ... Exception in thread Thread-19:
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
	debug_error_string = "{"created":"@1760513988.877867618","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test6
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test7 ... Exception in thread Thread-22:
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
	debug_error_string = "{"created":"@1760513990.880238297","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test7
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test8 ... Exception in thread Thread-25:
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
	debug_error_string = "{"created":"@1760513992.882570724","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test8
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test9 ... Exception in thread Thread-28:
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
	debug_error_string = "{"created":"@1760513994.884926472","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
>
FAIL

======================================================================
FAIL: 6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test9
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/6b8fe072-ccaf-4904-96ab-797a2eedadd5.py", line 19, in setUp
    bt.P4RuntimeTest.setUp(self)
  File "/root/p4c/tools/ptf/base_test.py", line 237, in setUp
    self.set_up_stream()
  File "/root/p4c/tools/ptf/base_test.py", line 340, in set_up_stream
    self.handshake()
  File "/root/p4c/tools/ptf/base_test.py", line 355, in handshake
    self.fail("Failed to establish handshake")
AssertionError: Failed to establish handshake

----------------------------------------------------------------------
Ran 1 test in 2.002s

FAILED (failures=1)
6b8fe072-ccaf-4904-96ab-797a2eedadd5.Test10 ... Exception in thread Thread-31:
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
	debug_error_string = "{"created":"@1760513996.887239268","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
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