/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(128): [--Werror=type-error] error: 'flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index)'
        flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<16>' with type 'bit<32>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(128): Type of argument 'meta.flowlet_id' (bit<16>) does not match type of parameter 'result' (bit<32>)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
                           ^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(128)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(132): [--Werror=type-error] error: 'flow_id.read(flowlet_id_tmp, meta.flowlet_map_index)'
            flow_id.read(flowlet_id_tmp, meta.flowlet_map_index);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<32>' with type 'bit<16>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(132): Type of argument 'flowlet_id_tmp' (bit<32>) does not match type of parameter 'result' (bit<16>)
              flow_id.read(flowlet_id_tmp, meta.flowlet_map_index);
                           ^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(132)
              flow_id.read(flowlet_id_tmp, meta.flowlet_map_index);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(133): [--Werror=type-error] error: 'meta.flowlet_id = flowlet_id_tmp + 1'
            meta.flowlet_id = flowlet_id_tmp + 1;
                            ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<16>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(133): Source expression 'flowlet_id_tmp + 1' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<16>'
              meta.flowlet_id = flowlet_id_tmp + 1;
                                ^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(134): [--Werror=type-error] error: 'flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id)'
            flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(134): Type of argument 'meta.flowlet_id' (bit<16>) does not match type of parameter 'value' (bit<32>)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
                                                        ^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(134)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(190): [--Werror=type-error] error: 'standard_metadata.egress_spec = meta.ecmp_hash % 4'
                    standard_metadata.egress_spec = meta.ecmp_hash % 4;
                                                  ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(190): Source expression 'meta.ecmp_hash % 4' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
                      standard_metadata.egress_spec = meta.ecmp_hash % 4;
                                                      ^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4info.txtpb /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(128): [--Werror=type-error] error: 'flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index)'
        flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<16>' with type 'bit<32>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(128): Type of argument 'meta.flowlet_id' (bit<16>) does not match type of parameter 'result' (bit<32>)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
                           ^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(128)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(132): [--Werror=type-error] error: 'flow_id.read(flowlet_id_tmp, meta.flowlet_map_index)'
            flow_id.read(flowlet_id_tmp, meta.flowlet_map_index);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<32>' with type 'bit<16>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(132): Type of argument 'flowlet_id_tmp' (bit<32>) does not match type of parameter 'result' (bit<16>)
              flow_id.read(flowlet_id_tmp, meta.flowlet_map_index);
                           ^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(132)
              flow_id.read(flowlet_id_tmp, meta.flowlet_map_index);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(133): [--Werror=type-error] error: 'meta.flowlet_id = flowlet_id_tmp + 1'
            meta.flowlet_id = flowlet_id_tmp + 1;
                            ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<16>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(133): Source expression 'flowlet_id_tmp + 1' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<16>'
              meta.flowlet_id = flowlet_id_tmp + 1;
                                ^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(134): [--Werror=type-error] error: 'flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id)'
            flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(134): Type of argument 'meta.flowlet_id' (bit<16>) does not match type of parameter 'value' (bit<32>)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
                                                        ^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(134)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(190): [--Werror=type-error] error: 'standard_metadata.egress_spec = meta.ecmp_hash % 4'
                    standard_metadata.egress_spec = meta.ecmp_hash % 4;
                                                  ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4(190): Source expression 'meta.ecmp_hash % 4' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
                      standard_metadata.egress_spec = meta.ecmp_hash % 4;
                                                      ^^^^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.p4info.txtpb'\'';config='\''371ae0cf-beb9-4e28-a8c2-7e2149f92ef2.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.660  root      : CRITICAL: test-spec element standard did not match any tests
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