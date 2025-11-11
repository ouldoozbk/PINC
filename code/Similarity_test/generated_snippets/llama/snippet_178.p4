/work_space/01589b4f-8dd3-464e-88cd-5c021d99501f.p4(82): [--Werror=not-found] error: TYPE_IPV4: declaration not found
            TYPE_IPV4: parse_ipv4;
            ^^^^^^^^^
Internal error: In file: /p4c/frontends/p4/typeChecking/readOnlyTypeInference.cpp:19
P4Testgen Bug: /usr/local/share/p4c/p4include/v1model.p4(57): At this point in the compilation typechecking should not infer new types anymore, but it did: node bit<32> __v1model_version = 20180101 changed to bit<32> __v1model_version = (bit<32>)20180101;
const bit<32> __v1model_version = 20180101;
              ^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(57)
const bit<32> __v1model_version = 20180101;
              ^^^^^^^^^^^^^^^^^

Please submit a bug report with your code.
+ p4c --target bmv2 --arch v1model --p4runtime-files 01589b4f-8dd3-464e-88cd-5c021d99501f.p4info.txtpb /work_space/01589b4f-8dd3-464e-88cd-5c021d99501f.p4
/work_space/01589b4f-8dd3-464e-88cd-5c021d99501f.p4(82): [--Werror=not-found] error: TYPE_IPV4: declaration not found
            TYPE_IPV4: parse_ipv4;
            ^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''01589b4f-8dd3-464e-88cd-5c021d99501f.p4info.txtpb'\'';config='\''01589b4f-8dd3-464e-88cd-5c021d99501f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:13:34.696  root      : CRITICAL: test-spec element standard did not match any tests
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