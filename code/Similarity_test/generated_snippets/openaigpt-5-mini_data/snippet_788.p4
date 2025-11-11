/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(111): [--Wwarn=unused] warning: 'ptr_reg' is unused
register<bit<16>>(PTR_ENTRIES) ptr_reg;
                               ^^^^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(134): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(138): [--Wwarn=unused] warning: 'forward_to' is unused
    action forward_to(bit<9> port) {
           ^^^^^^^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(151): [--Werror=type-error] error: 'data_reg.read(meta.action_data, idx)'
            data_reg.read(meta.action_data, idx);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(151): Type of argument 'idx' (bit<16>) does not match type of parameter 'index' (bit<32>)
              data_reg.read(meta.action_data, idx);
                                              ^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(151)
              data_reg.read(meta.action_data, idx);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4info.txtpb /work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(111): [--Wwarn=unused] warning: 'ptr_reg' is unused
register<bit<16>>(PTR_ENTRIES) ptr_reg;
                               ^^^^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(134): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(138): [--Wwarn=unused] warning: 'forward_to' is unused
    action forward_to(bit<9> port) {
           ^^^^^^^^^^
/work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(151): [--Werror=type-error] error: 'data_reg.read(meta.action_data, idx)'
            data_reg.read(meta.action_data, idx);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(151): Type of argument 'idx' (bit<16>) does not match type of parameter 'index' (bit<32>)
              data_reg.read(meta.action_data, idx);
                                              ^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4(151)
              data_reg.read(meta.action_data, idx);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''b5604acc-9c0b-468d-9aca-f1fe433b9c72.p4info.txtpb'\'';config='\''b5604acc-9c0b-468d-9aca-f1fe433b9c72.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:42:06.726  root      : CRITICAL: test-spec element standard did not match any tests
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