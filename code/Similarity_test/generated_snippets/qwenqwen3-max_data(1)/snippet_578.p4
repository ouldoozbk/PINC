/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(6): [--Wwarn=unused] warning: 'TYPE_GTP' is unused
const bit<16> TYPE_GTP = 0x0800; // GTP uses IPv4 as outer, but inner can be anything
              ^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(9): [--Wwarn=unused] warning: 'GTP_FLAGS' is unused
const bit<32> GTP_FLAGS = 0x30000000; // Version=1, PT=1, reserved=0, E/S/PN=0
              ^^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(297): [--Wwarn=unused] warning: table 'encap_table' is unused
    table encap_table {
          ^^^^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(126): [--Werror=type-error] error: 'SelectExpression'
        transition select(hdr.udp.dstPort) {
                   ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<16>'
  ---- Originating from:
  /work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(8): 'match' case label '32w2152' has type 'bit<32>' which does not match the expected type 'bit<16>'
  const bit<32> GTP_UDP_PORT = 2152;
                               ^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(263): [--Werror=type-error] error: Width must be specified for at least one of 40 or 0
...16>) (20 + 8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)) + 14);
                                                                                     ^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(263)
...16>) (20 + 8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)) + 14);
                                                                                          ^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(276): [--Werror=type-error] error: Width must be specified for at least one of 40 or 0
...th = (bit<16>) (8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                          ^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(276)
...th = (bit<16>) (8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                               ^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(282): [--Werror=type-error] error: Width must be specified for at least one of 40 or 0
...essage_len = (bit<16>) ((hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                          ^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(282)
...essage_len = (bit<16>) ((hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                               ^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(314): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(324): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
terminate called after throwing an instance of 'P4::Util::CompilerBug'
  what():  In file: /p4c/lib/crash.cpp:299
Compiler Bug: Exiting with SIGSEGV

+ p4c --target bmv2 --arch v1model --p4runtime-files 4fdd826b-c510-48c9-8e00-6f32d5a29341.p4info.txtpb /work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(6): [--Wwarn=unused] warning: 'TYPE_GTP' is unused
const bit<16> TYPE_GTP = 0x0800; // GTP uses IPv4 as outer, but inner can be anything
              ^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(9): [--Wwarn=unused] warning: 'GTP_FLAGS' is unused
const bit<32> GTP_FLAGS = 0x30000000; // Version=1, PT=1, reserved=0, E/S/PN=0
              ^^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(297): [--Wwarn=unused] warning: table 'encap_table' is unused
    table encap_table {
          ^^^^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(126): [--Werror=type-error] error: 'SelectExpression'
        transition select(hdr.udp.dstPort) {
                   ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<16>'
  ---- Originating from:
  /work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(8): 'match' case label '32w2152' has type 'bit<32>' which does not match the expected type 'bit<16>'
  const bit<32> GTP_UDP_PORT = 2152;
                               ^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(263): [--Werror=type-error] error: Width must be specified for at least one of 40 or 0
...16>) (20 + 8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)) + 14);
                                                                                     ^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(263)
...16>) (20 + 8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)) + 14);
                                                                                          ^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(276): [--Werror=type-error] error: Width must be specified for at least one of 40 or 0
...th = (bit<16>) (8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                          ^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(276)
...th = (bit<16>) (8 + 8 + (hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                               ^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(282): [--Werror=type-error] error: Width must be specified for at least one of 40 or 0
...essage_len = (bit<16>) ((hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                          ^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(282)
...essage_len = (bit<16>) ((hdr.ipv4.isValid() ? tmp_ipv4.ihl * 4 : (hdr.ipv6.isValid() ? 40 : 0)));
                                                                                               ^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(314): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4fdd826b-c510-48c9-8e00-6f32d5a29341.p4(324): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''4fdd826b-c510-48c9-8e00-6f32d5a29341.p4info.txtpb'\'';config='\''4fdd826b-c510-48c9-8e00-6f32d5a29341.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:42:23.153  root      : CRITICAL: test-spec element standard did not match any tests
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