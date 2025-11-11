/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(150): [--Wwarn=unused] warning: table 'firewall_ports' is unused
    table firewall_ports {
          ^^^^^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(119): [--Werror=type-error] error: 0xa5a5a5a5: could not infer a width
        hash(idx0, HashAlgorithm.crc32, 0xA5A5A5A5, { hdr.ipv4.dstAddr }, (bit<32>)2048);
                                        ^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(120): [--Werror=type-error] error: 0x5a5a5a5a: could not infer a width
        hash(idx1, HashAlgorithm.crc32, 0x5A5A5A5A, { hdr.ipv4.dstAddr }, (bit<32>)1024);
                                        ^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(121): [--Werror=type-error] error: 0x3c3c3c3c: could not infer a width
        hash(idx2, HashAlgorithm.crc16, 0x3C3C3C3C, { hdr.ipv4.dstAddr }, (bit<32>)512);
                                        ^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(122): [--Werror=type-error] error: 0xc3c3c3c3: could not infer a width
        hash(idx3, HashAlgorithm.crc16, 0xC3C3C3C3, { hdr.ipv4.dstAddr }, (bit<32>)256);
                                        ^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 8781958b-742c-46f1-abe0-d20c85567e3d.p4info.txtpb /work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(150): [--Wwarn=unused] warning: table 'firewall_ports' is unused
    table firewall_ports {
          ^^^^^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(119): [--Werror=type-error] error: 0xa5a5a5a5: could not infer a width
        hash(idx0, HashAlgorithm.crc32, 0xA5A5A5A5, { hdr.ipv4.dstAddr }, (bit<32>)2048);
                                        ^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(120): [--Werror=type-error] error: 0x5a5a5a5a: could not infer a width
        hash(idx1, HashAlgorithm.crc32, 0x5A5A5A5A, { hdr.ipv4.dstAddr }, (bit<32>)1024);
                                        ^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(121): [--Werror=type-error] error: 0x3c3c3c3c: could not infer a width
        hash(idx2, HashAlgorithm.crc16, 0x3C3C3C3C, { hdr.ipv4.dstAddr }, (bit<32>)512);
                                        ^^^^^^^^^^
/work_space/8781958b-742c-46f1-abe0-d20c85567e3d.p4(122): [--Werror=type-error] error: 0xc3c3c3c3: could not infer a width
        hash(idx3, HashAlgorithm.crc16, 0xC3C3C3C3, { hdr.ipv4.dstAddr }, (bit<32>)256);
                                        ^^^^^^^^^^
+ /bin/rm -f ss-log.txt
+ echo ''
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
+ for i in {1..20}
+ simple_switch_grpc --log-file ss-log --log-flush --dump-packet-data 10000 -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 -i 5@veth10 -i 6@veth12 -i 7@veth14 --no-p4
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''8781958b-742c-46f1-abe0-d20c85567e3d.p4info.txtpb'\'';config='\''8781958b-742c-46f1-abe0-d20c85567e3d.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:06:56.988  root      : CRITICAL: test-spec element standard did not match any tests
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