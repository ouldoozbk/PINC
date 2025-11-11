/work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(164): [--Werror=type-error] error: standard_metadata.ingress_global_timestamp - current_time: Cannot operate on values with different widths 48 and 32
        bit<32> time_diff = standard_metadata.ingress_global_timestamp - current_time;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(170): [--Werror=type-error] error: 'last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp)'
            last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<48>' to type 'bit<32>'
  ---- Originating from:
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(170): Type of argument 'standard_metadata.ingress_global_timestamp' (bit<48>) does not match type of parameter 'value' (bit<32>)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(170)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(174): [--Werror=type-error] error: 'last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp)'
            last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<48>' to type 'bit<32>'
  ---- Originating from:
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(174): Type of argument 'standard_metadata.ingress_global_timestamp' (bit<48>) does not match type of parameter 'value' (bit<32>)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(174)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4info.txtpb /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4
/work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(164): [--Werror=type-error] error: standard_metadata.ingress_global_timestamp - current_time: Cannot operate on values with different widths 48 and 32
        bit<32> time_diff = standard_metadata.ingress_global_timestamp - current_time;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(170): [--Werror=type-error] error: 'last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp)'
            last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<48>' to type 'bit<32>'
  ---- Originating from:
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(170): Type of argument 'standard_metadata.ingress_global_timestamp' (bit<48>) does not match type of parameter 'value' (bit<32>)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(170)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(174): [--Werror=type-error] error: 'last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp)'
            last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<48>' to type 'bit<32>'
  ---- Originating from:
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(174): Type of argument 'standard_metadata.ingress_global_timestamp' (bit<48>) does not match type of parameter 'value' (bit<32>)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
                                                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4(174)
              last_packet_time.write(meta.flowlet_id, standard_metadata.ingress_global_timestamp);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.p4info.txtpb'\'';config='\''e70c396d-b72c-4ed8-b8f1-a1f50f1b7ca3.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.282  root      : CRITICAL: test-spec element standard did not match any tests
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