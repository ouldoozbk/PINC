/work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4(5): [--Wwarn=unused] warning: 'IP_PROTO_ICMP' is unused
const bit<8> IP_PROTO_ICMP = 1;
             ^^^^^^^^^^^^^
/work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4(172): [--Werror=type-error] error: interface_table.apply().action_run: only allowed in switch statements
        if (interface_table.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4(184): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
            if (standard_metadata.marked_for_drop) {
                                  ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 195bf2a0-095e-4d5b-a4de-bed496e3babe.p4info.txtpb /work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4
/work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4(5): [--Wwarn=unused] warning: 'IP_PROTO_ICMP' is unused
const bit<8> IP_PROTO_ICMP = 1;
             ^^^^^^^^^^^^^
/work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4(172): [--Werror=type-error] error: interface_table.apply().action_run: only allowed in switch statements
        if (interface_table.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/195bf2a0-095e-4d5b-a4de-bed496e3babe.p4(184): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
            if (standard_metadata.marked_for_drop) {
                                  ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''195bf2a0-095e-4d5b-a4de-bed496e3babe.p4info.txtpb'\'';config='\''195bf2a0-095e-4d5b-a4de-bed496e3babe.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:28:50.546  root      : CRITICAL: test-spec element standard did not match any tests
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