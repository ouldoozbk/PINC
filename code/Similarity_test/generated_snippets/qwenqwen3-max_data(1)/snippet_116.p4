/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(79): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(122): [--Wwarn=unused] warning: table 'hash_to_mac' is unused
    table hash_to_mac {
          ^^^^^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(101): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.isValid() ? hdr.tcp.dstPort : 16w0 : exact;
                ^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(35)
struct headers {
       ^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(101): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.isValid() ? hdr.tcp.dstPort : 16w0 : exact;
                                    ^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(35)
struct headers {
       ^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(146): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            if (hdr.ipv4.protocol == 6 && hdr.tcp.isValid()) {
                                              ^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(35)
struct headers {
       ^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(155): [--Werror=type-error] error: Width must be specified for at least one of 1 or 2
            egressSpec_t egress_port = (hash_val % 2 == 0) ? 1 : 2;
                                                             ^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(155)
            egressSpec_t egress_port = (hash_val % 2 == 0) ? 1 : 2;
                                                                 ^
+ p4c --target bmv2 --arch v1model --p4runtime-files 81b9a3d7-6ce9-433d-b9a1-32975841657b.p4info.txtpb /work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(79): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(122): [--Wwarn=unused] warning: table 'hash_to_mac' is unused
    table hash_to_mac {
          ^^^^^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(101): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.isValid() ? hdr.tcp.dstPort : 16w0 : exact;
                ^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(35)
struct headers {
       ^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(101): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.isValid() ? hdr.tcp.dstPort : 16w0 : exact;
                                    ^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(35)
struct headers {
       ^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(146): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            if (hdr.ipv4.protocol == 6 && hdr.tcp.isValid()) {
                                              ^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(35)
struct headers {
       ^^^^^^^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(155): [--Werror=type-error] error: Width must be specified for at least one of 1 or 2
            egressSpec_t egress_port = (hash_val % 2 == 0) ? 1 : 2;
                                                             ^
/work_space/81b9a3d7-6ce9-433d-b9a1-32975841657b.p4(155)
            egressSpec_t egress_port = (hash_val % 2 == 0) ? 1 : 2;
                                                                 ^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''81b9a3d7-6ce9-433d-b9a1-32975841657b.p4info.txtpb'\'';config='\''81b9a3d7-6ce9-433d-b9a1-32975841657b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:20:07.405  root      : CRITICAL: test-spec element standard did not match any tests
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