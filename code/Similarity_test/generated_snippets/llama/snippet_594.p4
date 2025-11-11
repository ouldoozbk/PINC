/work_space/def24620-e609-4890-9138-72c18951b3f7.p4(158): [--Werror=type-error] error: 'standard_metadata.egress_spec = ecmp_base + hash_value % ecmp_count'
        standard_metadata.egress_spec = ecmp_base + (hash_value % ecmp_count);
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/def24620-e609-4890-9138-72c18951b3f7.p4(158): Source expression 'ecmp_base + hash_value % ecmp_count' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = ecmp_base + (hash_value % ecmp_count);
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/def24620-e609-4890-9138-72c18951b3f7.p4(179): [--Werror=type-error] error: standard_metadata.ingress_global_timestamp - meta.last_ts: Cannot operate on values with different widths 48 and 32
                if (standard_metadata.ingress_global_timestamp - meta.last_ts > 10000) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/def24620-e609-4890-9138-72c18951b3f7.p4(180): [--Werror=type-error] error: 'last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp)'
                    last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<48>' to type 'bit<32>'
  ---- Originating from:
  /work_space/def24620-e609-4890-9138-72c18951b3f7.p4(180): Type of argument 'standard_metadata.ingress_global_timestamp' (bit<48>) does not match type of parameter 'value' (bit<32>)
                      last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp);
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/def24620-e609-4890-9138-72c18951b3f7.p4(180)
                      last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files def24620-e609-4890-9138-72c18951b3f7.p4info.txtpb /work_space/def24620-e609-4890-9138-72c18951b3f7.p4
/work_space/def24620-e609-4890-9138-72c18951b3f7.p4(158): [--Werror=type-error] error: 'standard_metadata.egress_spec = ecmp_base + hash_value % ecmp_count'
        standard_metadata.egress_spec = ecmp_base + (hash_value % ecmp_count);
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/def24620-e609-4890-9138-72c18951b3f7.p4(158): Source expression 'ecmp_base + hash_value % ecmp_count' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = ecmp_base + (hash_value % ecmp_count);
                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/def24620-e609-4890-9138-72c18951b3f7.p4(179): [--Werror=type-error] error: standard_metadata.ingress_global_timestamp - meta.last_ts: Cannot operate on values with different widths 48 and 32
                if (standard_metadata.ingress_global_timestamp - meta.last_ts > 10000) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/def24620-e609-4890-9138-72c18951b3f7.p4(180): [--Werror=type-error] error: 'last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp)'
                    last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<48>' to type 'bit<32>'
  ---- Originating from:
  /work_space/def24620-e609-4890-9138-72c18951b3f7.p4(180): Type of argument 'standard_metadata.ingress_global_timestamp' (bit<48>) does not match type of parameter 'value' (bit<32>)
                      last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp);
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/def24620-e609-4890-9138-72c18951b3f7.p4(180)
                      last_ts_reg.write(hash_index, standard_metadata.ingress_global_timestamp);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''def24620-e609-4890-9138-72c18951b3f7.p4info.txtpb'\'';config='\''def24620-e609-4890-9138-72c18951b3f7.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.472  root      : CRITICAL: test-spec element standard did not match any tests
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