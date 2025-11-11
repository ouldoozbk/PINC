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

+ p4c --target bmv2 --arch v1model --p4runtime-files 0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.p4info.txtpb /work_space/0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.p4
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.p4info.txtpb'\'';config='\''0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.124s

OK
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.116s

OK
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.119s

OK
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

OK
0436ec5a-a53d-4f6f-9bb6-4b91b90b8365.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.110s

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