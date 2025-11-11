/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(9): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(171): [--Werror=type-error] error: 'feature_accum.read(reg_val, hdr.dinc.feature_id)'
            feature_accum.read(reg_val, hdr.dinc.feature_id);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(171): Type of argument 'hdr.dinc.feature_id' (bit<8>) does not match type of parameter 'index' (bit<32>)
              feature_accum.read(reg_val, hdr.dinc.feature_id);
                                          ^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(171)
              feature_accum.read(reg_val, hdr.dinc.feature_id);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(173): [--Werror=type-error] error: 'feature_accum.write(hdr.dinc.feature_id, new_val)'
            feature_accum.write(hdr.dinc.feature_id, new_val);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(173): Type of argument 'hdr.dinc.feature_id' (bit<8>) does not match type of parameter 'index' (bit<32>)
              feature_accum.write(hdr.dinc.feature_id, new_val);
                                  ^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(173)
              feature_accum.write(hdr.dinc.feature_id, new_val);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(179): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.egress_spec of type bit<9>
        if (!standard_metadata.egress_spec) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(179): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.egress_spec of type bit<9>
        if (!standard_metadata.egress_spec) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4info.txtpb /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(9): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(171): [--Werror=type-error] error: 'feature_accum.read(reg_val, hdr.dinc.feature_id)'
            feature_accum.read(reg_val, hdr.dinc.feature_id);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(171): Type of argument 'hdr.dinc.feature_id' (bit<8>) does not match type of parameter 'index' (bit<32>)
              feature_accum.read(reg_val, hdr.dinc.feature_id);
                                          ^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(171)
              feature_accum.read(reg_val, hdr.dinc.feature_id);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(173): [--Werror=type-error] error: 'feature_accum.write(hdr.dinc.feature_id, new_val)'
            feature_accum.write(hdr.dinc.feature_id, new_val);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(173): Type of argument 'hdr.dinc.feature_id' (bit<8>) does not match type of parameter 'index' (bit<32>)
              feature_accum.write(hdr.dinc.feature_id, new_val);
                                  ^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(173)
              feature_accum.write(hdr.dinc.feature_id, new_val);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4(179): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.egress_spec of type bit<9>
        if (!standard_metadata.egress_spec) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''f25ed83d-3515-4263-8bbc-0bc397fb9b37.p4info.txtpb'\'';config='\''f25ed83d-3515-4263-8bbc-0bc397fb9b37.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:21:04.276  root      : CRITICAL: test-spec element standard did not match any tests
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