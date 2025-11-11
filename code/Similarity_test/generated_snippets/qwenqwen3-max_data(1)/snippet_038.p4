/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(136): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(152): [--Werror=type-error] error: Field meter_color is not a member of structure struct standard_metadata
        if (!standard_metadata.meter_color.equals(0) || !standard_metadata.egress_spec.equals(511...
                               ^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(152): [--Werror=type-error] error: Cannot extract field equals from standard_metadata.egress_spec which has type bit<9>
...    if (!standard_metadata.meter_color.equals(0) || !standard_metadata.egress_spec.equals(511)) {
                                                                                      ^^^^^^
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(152)
...    if (!standard_metadata.meter_color.equals(0) || !standard_metadata.egress_spec.equals(511)) {
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 85c57d80-b670-4f25-ae6e-63c254b7843f.p4info.txtpb /work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(136): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(152): [--Werror=type-error] error: Field meter_color is not a member of structure struct standard_metadata
        if (!standard_metadata.meter_color.equals(0) || !standard_metadata.egress_spec.equals(511...
                               ^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(152): [--Werror=type-error] error: Cannot extract field equals from standard_metadata.egress_spec which has type bit<9>
...    if (!standard_metadata.meter_color.equals(0) || !standard_metadata.egress_spec.equals(511)) {
                                                                                      ^^^^^^
/work_space/85c57d80-b670-4f25-ae6e-63c254b7843f.p4(152)
...    if (!standard_metadata.meter_color.equals(0) || !standard_metadata.egress_spec.equals(511)) {
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''85c57d80-b670-4f25-ae6e-63c254b7843f.p4info.txtpb'\'';config='\''85c57d80-b670-4f25-ae6e-63c254b7843f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:18:23.825  root      : CRITICAL: test-spec element standard did not match any tests
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