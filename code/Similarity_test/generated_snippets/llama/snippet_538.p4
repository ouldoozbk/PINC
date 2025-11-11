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

+ p4c --target bmv2 --arch v1model --p4runtime-files 19c49013-8869-4019-8edf-2d051b449aee.p4info.txtpb /work_space/19c49013-8869-4019-8edf-2d051b449aee.p4
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''19c49013-8869-4019-8edf-2d051b449aee.p4info.txtpb'\'';config='\''19c49013-8869-4019-8edf-2d051b449aee.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
19c49013-8869-4019-8edf-2d051b449aee.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.120s

OK
19c49013-8869-4019-8edf-2d051b449aee.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
19c49013-8869-4019-8edf-2d051b449aee.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
19c49013-8869-4019-8edf-2d051b449aee.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
19c49013-8869-4019-8edf-2d051b449aee.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
19c49013-8869-4019-8edf-2d051b449aee.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.108s

OK
19c49013-8869-4019-8edf-2d051b449aee.Test7 ... ok

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