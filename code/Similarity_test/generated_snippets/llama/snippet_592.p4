/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(146): [--Wwarn=shadow] warning: 'selector' shadows 'selector'
    action set_ecmp_selector(bit<16> selector) {
                                     ^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(54)
    selector
    ^^^^^^^^
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(130): [--Wwarn=unused] warning: 'ecmp_group_id' is unused
    action ecmp_group(bit<32> ecmp_group_id) {
                              ^^^^^^^^^^^^^
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(131): [--Werror=type-error] error: '(bit<16>)hash(meta.ecmp_hash_output, HashAlgorithm.crc16, 32w0, { hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.ipv4.protocol, hdr.tcp.srcPort, hdr.tcp.dstPort }, 32w1024)'
...(bit<16>)hash(meta.ecmp_hash_output, HashAlgorithm.crc16, (bit<32>)0, {hdr.ipv4.srcAddr, hdr.i...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /usr/local/share/p4c/p4include/v1model.p4(444): Cannot unify type 'void' with type 'bit<16>'
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
         ^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(444): Cannot cast from 'void' to 'bit<16>'
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
         ^^^^
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(147): [--Werror=type-error] error: 'standard_metadata.egress_spec = selector'
        standard_metadata.egress_spec = selector;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<9>'
  ---- Originating from:
  /work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(147): Source expression 'selector' produces a result of type 'bit<16>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = selector;
                                          ^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 33728897-57e7-431f-b879-2166f1c35b1b.p4info.txtpb /work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(146): [--Wwarn=shadow] warning: 'selector' shadows 'selector'
    action set_ecmp_selector(bit<16> selector) {
                                     ^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(54)
    selector
    ^^^^^^^^
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(130): [--Wwarn=unused] warning: 'ecmp_group_id' is unused
    action ecmp_group(bit<32> ecmp_group_id) {
                              ^^^^^^^^^^^^^
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(131): [--Werror=type-error] error: '(bit<16>)hash(meta.ecmp_hash_output, HashAlgorithm.crc16, 32w0, { hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.ipv4.protocol, hdr.tcp.srcPort, hdr.tcp.dstPort }, 32w1024)'
...(bit<16>)hash(meta.ecmp_hash_output, HashAlgorithm.crc16, (bit<32>)0, {hdr.ipv4.srcAddr, hdr.i...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /usr/local/share/p4c/p4include/v1model.p4(444): Cannot unify type 'void' with type 'bit<16>'
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
         ^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(444): Cannot cast from 'void' to 'bit<16>'
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
         ^^^^
/work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(147): [--Werror=type-error] error: 'standard_metadata.egress_spec = selector'
        standard_metadata.egress_spec = selector;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<9>'
  ---- Originating from:
  /work_space/33728897-57e7-431f-b879-2166f1c35b1b.p4(147): Source expression 'selector' produces a result of type 'bit<16>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = selector;
                                          ^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''33728897-57e7-431f-b879-2166f1c35b1b.p4info.txtpb'\'';config='\''33728897-57e7-431f-b879-2166f1c35b1b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.249  root      : CRITICAL: test-spec element standard did not match any tests
+ echo ''
+ echo 'PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ...'
+ pkill --signal 9 --list-name simple_switch
+ echo ''
+ echo 'Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ...'
+ for i in {1..20}
+ pgrep -f simple_switch_grpc
+ echo 'simple_switch_grpc terminated'
+ break
+ grep simple_switch
+ ps axguwww