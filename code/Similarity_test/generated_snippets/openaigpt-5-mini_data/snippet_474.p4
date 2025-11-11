/work_space/d55367f2-31b4-4aa6-b5e0-24b44ae9a7e5.p4(126): [--Werror=not-found] error: clone_ingress_pkt_to_egress: declaration not found
        clone_ingress_pkt_to_egress(0, (bit<32>)255);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Internal error: In file: /p4c/frontends/p4/typeChecking/readOnlyTypeInference.cpp:19
P4Testgen Bug: /usr/local/share/p4c/p4include/v1model.p4(57): At this point in the compilation typechecking should not infer new types anymore, but it did: node bit<32> __v1model_version = 20180101 changed to bit<32> __v1model_version = (bit<32>)20180101;
const bit<32> __v1model_version = 20180101;
              ^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(57)
const bit<32> __v1model_version = 20180101;
              ^^^^^^^^^^^^^^^^^

Please submit a bug report with your code.
+ p4c --target bmv2 --arch v1model --p4runtime-files d55367f2-31b4-4aa6-b5e0-24b44ae9a7e5.p4info.txtpb /work_space/d55367f2-31b4-4aa6-b5e0-24b44ae9a7e5.p4
/work_space/d55367f2-31b4-4aa6-b5e0-24b44ae9a7e5.p4(126): [--Werror=not-found] error: clone_ingress_pkt_to_egress: declaration not found
        clone_ingress_pkt_to_egress(0, (bit<32>)255);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''d55367f2-31b4-4aa6-b5e0-24b44ae9a7e5.p4info.txtpb'\'';config='\''d55367f2-31b4-4aa6-b5e0-24b44ae9a7e5.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:27:56.190  root      : CRITICAL: test-spec element standard did not match any tests
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