/work_space/f4023771-47e4-40f1-a9fc-e1b8775e50a7.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
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

+ p4c --target bmv2 --arch v1model --p4runtime-files f4023771-47e4-40f1-a9fc-e1b8775e50a7.p4info.txtpb /work_space/f4023771-47e4-40f1-a9fc-e1b8775e50a7.p4
/work_space/f4023771-47e4-40f1-a9fc-e1b8775e50a7.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''f4023771-47e4-40f1-a9fc-e1b8775e50a7.p4info.txtpb'\'';config='\''f4023771-47e4-40f1-a9fc-e1b8775e50a7.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.109s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
f4023771-47e4-40f1-a9fc-e1b8775e50a7.Test10 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

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