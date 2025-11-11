/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(96): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(118): [--Werror=type-error] error: 'hdr.tcp.dstPort' with type 'bit<16>' cannot be compared to '22w16' with type 'bit<22>'
            if (hdr.tcp.dstPort == 22w16) {
                ^^^^^^^^^^^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(118)
            if (hdr.tcp.dstPort == 22w16) {
                                   ^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(121): [--Werror=type-error] error: 'hdr.tcp.dstPort' with type 'bit<16>' cannot be compared to '80w16' with type 'bit<80>'
            } else if (hdr.tcp.dstPort == 80w16) {
                       ^^^^^^^^^^^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(121)
            } else if (hdr.tcp.dstPort == 80w16) {
                                          ^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4info.txtpb /work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(96): [--Wwarn=unused] warning: 'drop' is unused
    action drop() {
           ^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(118): [--Werror=type-error] error: 'hdr.tcp.dstPort' with type 'bit<16>' cannot be compared to '22w16' with type 'bit<22>'
            if (hdr.tcp.dstPort == 22w16) {
                ^^^^^^^^^^^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(118)
            if (hdr.tcp.dstPort == 22w16) {
                                   ^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(121): [--Werror=type-error] error: 'hdr.tcp.dstPort' with type 'bit<16>' cannot be compared to '80w16' with type 'bit<80>'
            } else if (hdr.tcp.dstPort == 80w16) {
                       ^^^^^^^^^^^^^^^
/work_space/3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4(121)
            } else if (hdr.tcp.dstPort == 80w16) {
                                          ^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''3f7c424b-9bd8-4853-8ba8-c63b31035de8.p4info.txtpb'\'';config='\''3f7c424b-9bd8-4853-8ba8-c63b31035de8.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:11:20.142  root      : CRITICAL: test-spec element standard did not match any tests
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