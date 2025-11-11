/work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4(153): [--Werror=type-error] error: 0: could not infer a width
        hash(pos0, HashAlgorithm.crc16, 0, { hdr.ipv4.dstAddr }, (bit<32>)LAYER0_SIZE);
                                        ^
/work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4(154): [--Werror=type-error] error: 0x1: could not infer a width
        hash(pos1, HashAlgorithm.crc32, 0x1, { hdr.ipv4.dstAddr }, (bit<32>)LAYER1_SIZE);
                                        ^^^
/work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4(155): [--Werror=type-error] error: 0x2: could not infer a width
        hash(pos2, HashAlgorithm.csum16, 0x2, { hdr.ipv4.dstAddr }, (bit<32>)LAYER2_SIZE);
                                         ^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4info.txtpb /work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4
/work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4(153): [--Werror=type-error] error: 0: could not infer a width
        hash(pos0, HashAlgorithm.crc16, 0, { hdr.ipv4.dstAddr }, (bit<32>)LAYER0_SIZE);
                                        ^
/work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4(154): [--Werror=type-error] error: 0x1: could not infer a width
        hash(pos1, HashAlgorithm.crc32, 0x1, { hdr.ipv4.dstAddr }, (bit<32>)LAYER1_SIZE);
                                        ^^^
/work_space/bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4(155): [--Werror=type-error] error: 0x2: could not infer a width
        hash(pos2, HashAlgorithm.csum16, 0x2, { hdr.ipv4.dstAddr }, (bit<32>)LAYER2_SIZE);
                                         ^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''bc3f58d6-810a-4cd7-b7d7-3109f237431f.p4info.txtpb'\'';config='\''bc3f58d6-810a-4cd7-b7d7-3109f237431f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:08:47.772  root      : CRITICAL: test-spec element standard did not match any tests
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