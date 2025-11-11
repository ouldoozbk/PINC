/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(110): [--Wwarn=unused] warning: 'iface_drop_action' is unused
    action iface_drop_action() {
           ^^^^^^^^^^^^^^^^^
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(114): [--Wwarn=unused] warning: 'iface_forward_action' is unused
    action iface_forward_action() {
           ^^^^^^^^^^^^^^^^^^^^
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(118): [--Wwarn=unused] warning: 'set_direction_internal' is unused
    action set_direction_internal() {
           ^^^^^^^^^^^^^^^^^^^^^^
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(122): [--Wwarn=unused] warning: 'set_direction_external' is unused
    action set_direction_external() {
           ^^^^^^^^^^^^^^^^^^^^^^
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

+ p4c --target bmv2 --arch v1model --p4runtime-files e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4info.txtpb /work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(110): [--Wwarn=unused] warning: 'iface_drop_action' is unused
    action iface_drop_action() {
           ^^^^^^^^^^^^^^^^^
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(114): [--Wwarn=unused] warning: 'iface_forward_action' is unused
    action iface_forward_action() {
           ^^^^^^^^^^^^^^^^^^^^
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(118): [--Wwarn=unused] warning: 'set_direction_internal' is unused
    action set_direction_internal() {
           ^^^^^^^^^^^^^^^^^^^^^^
/work_space/e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4(122): [--Wwarn=unused] warning: 'set_direction_external' is unused
    action set_direction_external() {
           ^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.p4info.txtpb'\'';config='\''e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test7 ... 21:37:53.359  dataplane : ERROR   : send: no port 33 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test8 ... 21:37:53.469  dataplane : ERROR   : send: no port 33 for device 0
ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
e6689f18-18a6-45fa-b1cf-a4e7b64afc2b.Test10 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
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