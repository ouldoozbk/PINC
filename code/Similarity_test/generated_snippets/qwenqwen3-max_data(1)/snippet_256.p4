/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(5): [--Wwarn=unused] warning: 'IP_PROTO_ICMP' is unused
const bit<8> IP_PROTO_ICMP = 1;
             ^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(90): [--Wwarn=unused] warning: 'forward' is unused
    action forward() {
           ^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(144): [--Werror=type-error] error: 'Entry'
            (IP_PROTO_UDP, 546w16 &&& 0xFFFF): mark_ndp();
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<546>' to type 'bit<16>'
  ---- Originating from:
  /work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(144): Table entry has type 'tuple<bit<8>, bit<16>>' which is not the expected type 'tuple<bit<8>, bit<546>>'
              (IP_PROTO_UDP, 546w16 &&& 0xFFFF): mark_ndp();
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(145): [--Werror=type-error] error: 'Entry'
            (IP_PROTO_UDP, 547w16 &&& 0xFFFF): mark_ndp();
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<547>' to type 'bit<16>'
  ---- Originating from:
  /work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(145): Table entry has type 'tuple<bit<8>, bit<16>>' which is not the expected type 'tuple<bit<8>, bit<547>>'
              (IP_PROTO_UDP, 547w16 &&& 0xFFFF): mark_ndp();
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(195): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
            if (!standard_metadata.drop) {
                                   ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(200): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
            if (!standard_metadata.drop) {
                                   ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4info.txtpb /work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(5): [--Wwarn=unused] warning: 'IP_PROTO_ICMP' is unused
const bit<8> IP_PROTO_ICMP = 1;
             ^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(90): [--Wwarn=unused] warning: 'forward' is unused
    action forward() {
           ^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(144): [--Werror=type-error] error: 'Entry'
            (IP_PROTO_UDP, 546w16 &&& 0xFFFF): mark_ndp();
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<546>' to type 'bit<16>'
  ---- Originating from:
  /work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(144): Table entry has type 'tuple<bit<8>, bit<16>>' which is not the expected type 'tuple<bit<8>, bit<546>>'
              (IP_PROTO_UDP, 546w16 &&& 0xFFFF): mark_ndp();
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(145): [--Werror=type-error] error: 'Entry'
            (IP_PROTO_UDP, 547w16 &&& 0xFFFF): mark_ndp();
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<547>' to type 'bit<16>'
  ---- Originating from:
  /work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(145): Table entry has type 'tuple<bit<8>, bit<16>>' which is not the expected type 'tuple<bit<8>, bit<547>>'
              (IP_PROTO_UDP, 547w16 &&& 0xFFFF): mark_ndp();
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(195): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
            if (!standard_metadata.drop) {
                                   ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4(200): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
            if (!standard_metadata.drop) {
                                   ^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''9ee325cc-2d87-4575-be3e-b4fdfe576dd3.p4info.txtpb'\'';config='\''9ee325cc-2d87-4575-be3e-b4fdfe576dd3.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:30:09.456  root      : CRITICAL: test-spec element standard did not match any tests
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