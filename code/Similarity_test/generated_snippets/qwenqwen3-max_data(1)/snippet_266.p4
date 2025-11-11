/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(5): [--Wwarn=unused] warning: 'IP_PROTO_TCP' is unused
const bit<8> IP_PROTO_TCP = 6;
             ^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(6): [--Wwarn=unused] warning: 'IP_PROTO_UDP' is unused
const bit<8> IP_PROTO_UDP = 17;
             ^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(16): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(118): [--Wwarn=unused] warning: 'allow' is unused
    action allow() {
           ^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(122): [--Wwarn=unused] warning: 'deny' is unused
    action deny() {
           ^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(133): [--Wwarn=unused] warning: 'check_heavy_hitter' is unused
    action check_heavy_hitter(ip4Addr_t srcAddr, ip4Addr_t dstAddr) {
           ^^^^^^^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(140): [--Wwarn=unused] warning: 'current_count' is unused
        bit<32> current_count;
        ^^^^^^^^^^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(131): [--Werror=type-error] error: counter<bit<32>>: Type counter has 0 type parameter(s), but it is specialized with 1
    counter<bit<32>>(1024) packet_counter;
    ^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(127)
extern counter
       ^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(162): [--Werror=type-error] error: Field mirror_spec is not a member of structure struct standard_metadata
        standard_metadata.mirror_spec = 100;
                          ^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(167): [--Werror=type-error] error: interface_table.apply().action_run: only allowed in switch statements
        if (interface_table.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 81f9b781-6a22-42a1-907f-b20d66736606.p4info.txtpb /work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(5): [--Wwarn=unused] warning: 'IP_PROTO_TCP' is unused
const bit<8> IP_PROTO_TCP = 6;
             ^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(6): [--Wwarn=unused] warning: 'IP_PROTO_UDP' is unused
const bit<8> IP_PROTO_UDP = 17;
             ^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(16): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(118): [--Wwarn=unused] warning: 'allow' is unused
    action allow() {
           ^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(122): [--Wwarn=unused] warning: 'deny' is unused
    action deny() {
           ^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(133): [--Wwarn=unused] warning: 'check_heavy_hitter' is unused
    action check_heavy_hitter(ip4Addr_t srcAddr, ip4Addr_t dstAddr) {
           ^^^^^^^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(140): [--Wwarn=unused] warning: 'current_count' is unused
        bit<32> current_count;
        ^^^^^^^^^^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(131): [--Werror=type-error] error: counter<bit<32>>: Type counter has 0 type parameter(s), but it is specialized with 1
    counter<bit<32>>(1024) packet_counter;
    ^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(127)
extern counter
       ^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(162): [--Werror=type-error] error: Field mirror_spec is not a member of structure struct standard_metadata
        standard_metadata.mirror_spec = 100;
                          ^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/81f9b781-6a22-42a1-907f-b20d66736606.p4(167): [--Werror=type-error] error: interface_table.apply().action_run: only allowed in switch statements
        if (interface_table.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''81f9b781-6a22-42a1-907f-b20d66736606.p4info.txtpb'\'';config='\''81f9b781-6a22-42a1-907f-b20d66736606.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:30:09.475  root      : CRITICAL: test-spec element standard did not match any tests
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