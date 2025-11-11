/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(97): [--Wwarn=unused] warning: 'set_drop' is unused
    action set_drop() {
           ^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(136): [--Werror=type-error] error: Cannot apply ! to value meta.drop_packet of type bit<1>
        if (!meta.drop_packet && hdr.ipv4.isValid() && hdr.tcp.isValid()) {
             ^^^^^^^^^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(141): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (meta.drop_packet || standard_metadata.marked_for_drop) {
                                                  ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(136): [--Werror=type-error] error: Cannot apply ! to value meta.drop_packet of type bit<1>
        if (!meta.drop_packet && hdr.ipv4.isValid() && hdr.tcp.isValid()) {
             ^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4info.txtpb /work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(97): [--Wwarn=unused] warning: 'set_drop' is unused
    action set_drop() {
           ^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(136): [--Werror=type-error] error: Cannot apply ! to value meta.drop_packet of type bit<1>
        if (!meta.drop_packet && hdr.ipv4.isValid() && hdr.tcp.isValid()) {
             ^^^^^^^^^^^^^^^^
/work_space/ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4(141): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (meta.drop_packet || standard_metadata.marked_for_drop) {
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.p4info.txtpb'\'';config='\''ccbbd07c-2fe1-4ef5-86c3-1133257dc91b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:48:00.560  root      : CRITICAL: test-spec element standard did not match any tests
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