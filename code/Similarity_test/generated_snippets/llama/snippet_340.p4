/work_space/276837ab-d825-4430-81bb-43f1a74191ec.p4(174): [--Wwarn=overflow] warning: timestamp_dst - timestamp_src << 32: shifting value with 32 bits by 32
...                hdr.icmp6.data = (timestamp_dst - timestamp_src) << 32 | (count_dst - count_src);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

============ Test 2 ============
============ End Test 2 ============

warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
warning: Concolic constraints for this path are unsatisfiable.
+ p4c --target bmv2 --arch v1model --p4runtime-files 276837ab-d825-4430-81bb-43f1a74191ec.p4info.txtpb /work_space/276837ab-d825-4430-81bb-43f1a74191ec.p4
/work_space/276837ab-d825-4430-81bb-43f1a74191ec.p4(174): [--Wwarn=overflow] warning: timestamp_dst - timestamp_src << 32: shifting value with 32 bits by 32
...                hdr.icmp6.data = (timestamp_dst - timestamp_src) << 32 | (count_dst - count_src);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/276837ab-d825-4430-81bb-43f1a74191ec.p4(174): [--Wwarn=overflow] warning: timestamp_dst_0/timestamp_dst - timestamp_src_0/timestamp_src << 32: shifting value with 32 bits by 32
...                hdr.icmp6.data = (timestamp_dst - timestamp_src) << 32 | (count_dst - count_src);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''276837ab-d825-4430-81bb-43f1a74191ec.p4info.txtpb'\'';config='\''276837ab-d825-4430-81bb-43f1a74191ec.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
276837ab-d825-4430-81bb-43f1a74191ec.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.120s

OK
276837ab-d825-4430-81bb-43f1a74191ec.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.116s

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