/work_space/4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
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

+ p4c --target bmv2 --arch v1model --p4runtime-files 4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.p4info.txtpb /work_space/4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.p4
/work_space/4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.p4info.txtpb'\'';config='\''4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.115s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.114s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
4eb6bac6-d56a-4a6c-bf9e-99bf1616063b.Test10 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.109s

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