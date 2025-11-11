/work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4(168): [--Werror=type-error] error: Cannot extract field isValid from standard_metadata.egress_spec which has type bit<9>
        if (!standard_metadata.egress_spec.isValid()) {
                                           ^^^^^^^
/work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4(168)
        if (!standard_metadata.egress_spec.isValid()) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 843975e0-514c-498e-85cc-19a9c7da0eab.p4info.txtpb /work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4
/work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4(168): [--Werror=type-error] error: Cannot extract field isValid from standard_metadata.egress_spec which has type bit<9>
        if (!standard_metadata.egress_spec.isValid()) {
                                           ^^^^^^^
/work_space/843975e0-514c-498e-85cc-19a9c7da0eab.p4(168)
        if (!standard_metadata.egress_spec.isValid()) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''843975e0-514c-498e-85cc-19a9c7da0eab.p4info.txtpb'\'';config='\''843975e0-514c-498e-85cc-19a9c7da0eab.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:29:11.759  root      : CRITICAL: test-spec element standard did not match any tests
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