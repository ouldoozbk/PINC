/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(9): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(136): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(193): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.egress_spec of type bit<9>
        if (!standard_metadata.egress_spec) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(194): [--Werror=type-error] error: 'standard_metadata.egress_spec = 32w1'
            standard_metadata.egress_spec = (bit<32>)1;
                                          ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(194): Source expression '32w1' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
              standard_metadata.egress_spec = (bit<32>)1;
                                                       ^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(193): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.egress_spec of type bit<9>
        if (!standard_metadata.egress_spec) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4info.txtpb /work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(9): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(136): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(193): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.egress_spec of type bit<9>
        if (!standard_metadata.egress_spec) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(194): [--Werror=type-error] error: 'standard_metadata.egress_spec = 32w1'
            standard_metadata.egress_spec = (bit<32>)1;
                                          ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4(194): Source expression '32w1' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
              standard_metadata.egress_spec = (bit<32>)1;
                                                       ^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''df67ce27-74da-48a9-bc0f-8d8409edc5f7.p4info.txtpb'\'';config='\''df67ce27-74da-48a9-bc0f-8d8409edc5f7.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:21:04.169  root      : CRITICAL: test-spec element standard did not match any tests
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