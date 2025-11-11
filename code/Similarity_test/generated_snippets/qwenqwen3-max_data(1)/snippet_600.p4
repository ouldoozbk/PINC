/work_space/93e850df-a399-4bd5-b741-e3a3f660c49d.p4(62): [--Wwarn=uninitialized-use] warning: uninitialized_mac may be uninitialized
        hdr.ethernet.srcAddr = uninitialized_mac;
                               ^^^^^^^^^^^^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

+ p4c --target bmv2 --arch v1model --p4runtime-files 93e850df-a399-4bd5-b741-e3a3f660c49d.p4info.txtpb /work_space/93e850df-a399-4bd5-b741-e3a3f660c49d.p4
/work_space/93e850df-a399-4bd5-b741-e3a3f660c49d.p4(62): [--Wwarn=uninitialized-use] warning: uninitialized_mac may be uninitialized
        hdr.ethernet.srcAddr = uninitialized_mac;
                               ^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''93e850df-a399-4bd5-b741-e3a3f660c49d.p4info.txtpb'\'';config='\''93e850df-a399-4bd5-b741-e3a3f660c49d.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
93e850df-a399-4bd5-b741-e3a3f660c49d.Test1 ... ok

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