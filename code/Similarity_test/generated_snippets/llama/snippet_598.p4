/work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(151): [--Werror=type-error] error: 'last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index)'
        last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<16>' with type 'bit<32>'
  ---- Originating from:
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(151): Type of argument 'meta.last_packet_time' (bit<16>) does not match type of parameter 'result' (bit<32>)
          last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index);
                                     ^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(151)
          last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(152): [--Werror=type-error] error: current_timestamp - meta.last_packet_time: Cannot operate on values with different widths 32 and 16
        bit<32> time_diff = current_timestamp - meta.last_packet_time;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(166): [--Werror=type-error] error: 'flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index)'
        flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<9>' with type 'bit<16>'
  ---- Originating from:
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(166): Type of argument 'standard_metadata.egress_spec' (bit<9>) does not match type of parameter 'result' (bit<16>)
          flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index);
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(166)
          flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files f63584fd-330d-4009-a3a7-605803783d7f.p4info.txtpb /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4
/work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(151): [--Werror=type-error] error: 'last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index)'
        last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<16>' with type 'bit<32>'
  ---- Originating from:
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(151): Type of argument 'meta.last_packet_time' (bit<16>) does not match type of parameter 'result' (bit<32>)
          last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index);
                                     ^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(151)
          last_packet_timestamp.read(meta.last_packet_time, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(152): [--Werror=type-error] error: current_timestamp - meta.last_packet_time: Cannot operate on values with different widths 32 and 16
        bit<32> time_diff = current_timestamp - meta.last_packet_time;
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(166): [--Werror=type-error] error: 'flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index)'
        flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<9>' with type 'bit<16>'
  ---- Originating from:
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(166): Type of argument 'standard_metadata.egress_spec' (bit<9>) does not match type of parameter 'result' (bit<16>)
          flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index);
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/f63584fd-330d-4009-a3a7-605803783d7f.p4(166)
          flowlet_map.read(standard_metadata.egress_spec, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''f63584fd-330d-4009-a3a7-605803783d7f.p4info.txtpb'\'';config='\''f63584fd-330d-4009-a3a7-605803783d7f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.604  root      : CRITICAL: test-spec element standard did not match any tests
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