/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(114): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(179): [--Wwarn=unused] warning: 'set_group' is unused
    action set_group(bit<32> gid) {
           ^^^^^^^^^
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(247): [--Wwarn=unused] warning: 'ipv4_forward_no_ecmp' is unused
    action ipv4_forward_no_ecmp(bit<9> port, macAddr_t dmac) {
           ^^^^^^^^^^^^^^^^^^^^
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(207): [--Werror=type-error] error: 0: could not infer a width
        hash(hash_val, HashAlgorithm.crc32, 0, { hdr.ipv4.dstAddr, hdr.ipv4.srcAddr, hdr.ipv4.pro...
                                            ^
+ p4c --target bmv2 --arch v1model --p4runtime-files e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4info.txtpb /work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(114): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(179): [--Wwarn=unused] warning: 'set_group' is unused
    action set_group(bit<32> gid) {
           ^^^^^^^^^
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(247): [--Wwarn=unused] warning: 'ipv4_forward_no_ecmp' is unused
    action ipv4_forward_no_ecmp(bit<9> port, macAddr_t dmac) {
           ^^^^^^^^^^^^^^^^^^^^
/work_space/e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4(207): [--Werror=type-error] error: 0: could not infer a width
        hash(hash_val, HashAlgorithm.crc32, 0, { hdr.ipv4.dstAddr, hdr.ipv4.srcAddr, hdr.ipv4.pro...
                                            ^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''e115e07f-97d6-4773-8d40-5b9dfb88fb07.p4info.txtpb'\'';config='\''e115e07f-97d6-4773-8d40-5b9dfb88fb07.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:30:33.523  root      : CRITICAL: test-spec element standard did not match any tests
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