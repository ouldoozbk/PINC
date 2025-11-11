/work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4(10): [--Wwarn=unused] warning: 'ip4Addr_t' is unused
typedef bit<32> ip4Addr_t;
                ^^^^^^^^^
/work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4(59): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

============ Test 2 ============
============ End Test 2 ============

+ p4c --target bmv2 --arch v1model --p4runtime-files 1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4info.txtpb /work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4
/work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4(10): [--Wwarn=unused] warning: 'ip4Addr_t' is unused
typedef bit<32> ip4Addr_t;
                ^^^^^^^^^
/work_space/1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4(59): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''1e7910bf-7a79-46f5-b8a3-4f12be7376ce.p4info.txtpb'\'';config='\''1e7910bf-7a79-46f5-b8a3-4f12be7376ce.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
1e7910bf-7a79-46f5-b8a3-4f12be7376ce.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
1e7910bf-7a79-46f5-b8a3-4f12be7376ce.Test2 ... 07:19:17.412  dataplane : ERROR   : send: no port 256 for device 0
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