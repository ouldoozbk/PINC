/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(4): [--Wwarn=unused] warning: 'TYPE_HDR1' is unused
const bit<16> TYPE_HDR1 = 0x1234;
              ^^^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(8): [--Wwarn=unused] warning: 'macAddr_t' is unused
typedef bit<48> macAddr_t;
                ^^^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(70): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(22): [--Werror=type-error] error: Field 'hdr1' of 'header union_t' cannot have type 'header hdr1_t'
    hdr1_t hdr1;
           ^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(10)
header hdr1_t {
       ^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(23): [--Werror=type-error] error: Field 'hdr2' of 'header union_t' cannot have type 'header hdr2_t'
    hdr2_t hdr2;
           ^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(15)
header hdr2_t {
       ^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(20): [--Werror=type-error] error: Error while analyzing header union_t
header union_t {
       ^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(117): [--Werror=type-error] error: MyParser: cannot evaluate to a compile-time constant
MyParser(),
^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files c6814237-96db-4bdd-9ce8-84b331e4dd37.p4info.txtpb /work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(4): [--Wwarn=unused] warning: 'TYPE_HDR1' is unused
const bit<16> TYPE_HDR1 = 0x1234;
              ^^^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(8): [--Wwarn=unused] warning: 'macAddr_t' is unused
typedef bit<48> macAddr_t;
                ^^^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(70): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(22): [--Werror=type-error] error: Field 'hdr1' of 'header union_t' cannot have type 'header hdr1_t'
    hdr1_t hdr1;
           ^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(10)
header hdr1_t {
       ^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(23): [--Werror=type-error] error: Field 'hdr2' of 'header union_t' cannot have type 'header hdr2_t'
    hdr2_t hdr2;
           ^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(15)
header hdr2_t {
       ^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(20): [--Werror=type-error] error: Error while analyzing header union_t
header union_t {
       ^^^^^^^
/work_space/c6814237-96db-4bdd-9ce8-84b331e4dd37.p4(117): [--Werror=type-error] error: MyParser: cannot evaluate to a compile-time constant
MyParser(),
^^^^^^^^^^
+ /bin/rm -f ss-log.txt
+ simple_switch_grpc --log-file ss-log --log-flush --dump-packet-data 10000 -i 0@veth0 -i 1@veth2 -i 2@veth4 -i 3@veth6 -i 4@veth8 -i 5@veth10 -i 6@veth12 -i 7@veth14 --no-p4
+ echo ''
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''c6814237-96db-4bdd-9ce8-84b331e4dd37.p4info.txtpb'\'';config='\''c6814237-96db-4bdd-9ce8-84b331e4dd37.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:15:23.181  root      : CRITICAL: test-spec element standard did not match any tests
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