/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(118): [--Wwarn=unused] warning: 'set_forward' is unused
    action set_forward() {
           ^^^^^^^^^^^
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(198): [--Werror=type-error] error: 0: could not infer a width
            hash(idx0, HashAlgorithm.crc16, 0, { hdr.ipv4.dstAddr }, LAYER0_SIZE);
                                            ^
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(199): [--Werror=type-error] error: 0: could not infer a width
            hash(idx1, HashAlgorithm.crc32, 0, { hdr.ipv4.dstAddr }, LAYER1_SIZE);
                                            ^
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(200): [--Werror=type-error] error: 0: could not infer a width
            hash(idx2, HashAlgorithm.identity, 0, { hdr.ipv4.dstAddr }, LAYER2_SIZE);
                                               ^
+ p4c --target bmv2 --arch v1model --p4runtime-files c2769988-654b-47d6-baec-af34d95b8602.p4info.txtpb /work_space/c2769988-654b-47d6-baec-af34d95b8602.p4
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(118): [--Wwarn=unused] warning: 'set_forward' is unused
    action set_forward() {
           ^^^^^^^^^^^
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(198): [--Werror=type-error] error: 0: could not infer a width
            hash(idx0, HashAlgorithm.crc16, 0, { hdr.ipv4.dstAddr }, LAYER0_SIZE);
                                            ^
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(199): [--Werror=type-error] error: 0: could not infer a width
            hash(idx1, HashAlgorithm.crc32, 0, { hdr.ipv4.dstAddr }, LAYER1_SIZE);
                                            ^
/work_space/c2769988-654b-47d6-baec-af34d95b8602.p4(200): [--Werror=type-error] error: 0: could not infer a width
            hash(idx2, HashAlgorithm.identity, 0, { hdr.ipv4.dstAddr }, LAYER2_SIZE);
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''c2769988-654b-47d6-baec-af34d95b8602.p4info.txtpb'\'';config='\''c2769988-654b-47d6-baec-af34d95b8602.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:06:56.971  root      : CRITICAL: test-spec element standard did not match any tests
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