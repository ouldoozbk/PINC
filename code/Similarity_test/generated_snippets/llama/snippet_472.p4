/work_space/5e95d29d-a83c-413c-b63b-83efc21d1940.p4(172): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
            clone3(CloneType.I2E, 100, standard_metadata);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

============ Test 2 ============
============ End Test 2 ============

In file: /p4c/backends/p4tools/modules/testgen/core/small_step/extern_stepper.cpp:337
Unimplemented P4Testgen support: /work_space/5e95d29d-a83c-413c-b63b-83efc21d1940.p4(172): Unknown or unimplemented extern method: clone3
            clone3(CloneType.I2E, 100, standard_metadata);
            ^^^^^^

+ p4c --target bmv2 --arch v1model --p4runtime-files 5e95d29d-a83c-413c-b63b-83efc21d1940.p4info.txtpb /work_space/5e95d29d-a83c-413c-b63b-83efc21d1940.p4
/work_space/5e95d29d-a83c-413c-b63b-83efc21d1940.p4(172): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
            clone3(CloneType.I2E, 100, standard_metadata);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604): [--Werror=unknown] error: clone3: unknown extern function
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
+ /bin/rm -f ss-log.txt
+ echo ''
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''5e95d29d-a83c-413c-b63b-83efc21d1940.p4info.txtpb'\'';config='\''5e95d29d-a83c-413c-b63b-83efc21d1940.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
5e95d29d-a83c-413c-b63b-83efc21d1940.Test1 ... ERROR

======================================================================
ERROR: 5e95d29d-a83c-413c-b63b-83efc21d1940.Test1
----------------------------------------------------------------------
Traceback (most recent call last):
  File "out-p4testgen/5e95d29d-a83c-413c-b63b-83efc21d1940.py", line 20, in setUp
    success = bt.P4RuntimeTest.updateConfig(self)
  File "/root/p4c/tools/ptf/base_test.py", line 263, in updateConfig
    with open(config_path, "rb") as config_f:
FileNotFoundError: [Errno 2] No such file or directory: '5e95d29d-a83c-413c-b63b-83efc21d1940.json'

----------------------------------------------------------------------
Ran 1 test in 0.012s

FAILED (errors=1)
5e95d29d-a83c-413c-b63b-83efc21d1940.Test2 ... Exception in thread Thread-7:
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
	debug_error_string = "{"created":"@1760505730.292997460","description":"Error received from peer ipv6:[::1]:9559","file":"src/core/lib/surface/call.cc","file_line":1074,"grpc_message":"Election id already exists","grpc_status":3}"
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