/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(104): [--Wwarn=unused] warning: 'forward_port2' is unused
    action forward_port2() {
           ^^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(134): [--Wwarn=unused] warning: table 'interface_action' is unused
    table interface_action {
          ^^^^^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(146): [--Wwarn=unused] warning: table 'firewall_filter' is unused
    table firewall_filter {
          ^^^^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(151): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.isValid(): exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(152): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.dstPort: exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(153): [--Werror=type-error] error: Field udp is not a member of structure struct headers
            hdr.udp.isValid(): exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(154): [--Werror=type-error] error: Field udp is not a member of structure struct headers
            hdr.udp.dstPort: exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(188): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            if (hdr.tcp.isValid()) {
                    ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(189): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
                if (hdr.tcp.dstPort == 22) {
                        ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(193): [--Werror=type-error] error: Field udp is not a member of structure struct headers
            if (hdr.udp.isValid()) {
                    ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(194): [--Werror=type-error] error: Field udp is not a member of structure struct headers
                if (hdr.udp.dstPort == 22) {
                        ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4info.txtpb /work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(8): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(104): [--Wwarn=unused] warning: 'forward_port2' is unused
    action forward_port2() {
           ^^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(134): [--Wwarn=unused] warning: table 'interface_action' is unused
    table interface_action {
          ^^^^^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(146): [--Wwarn=unused] warning: table 'firewall_filter' is unused
    table firewall_filter {
          ^^^^^^^^^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(151): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.isValid(): exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(152): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            hdr.tcp.dstPort: exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(153): [--Werror=type-error] error: Field udp is not a member of structure struct headers
            hdr.udp.isValid(): exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(154): [--Werror=type-error] error: Field udp is not a member of structure struct headers
            hdr.udp.dstPort: exact;
                ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(188): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
            if (hdr.tcp.isValid()) {
                    ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(189): [--Werror=type-error] error: Field tcp is not a member of structure struct headers
                if (hdr.tcp.dstPort == 22) {
                        ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(193): [--Werror=type-error] error: Field udp is not a member of structure struct headers
            if (hdr.udp.isValid()) {
                    ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(194): [--Werror=type-error] error: Field udp is not a member of structure struct headers
                if (hdr.udp.dstPort == 22) {
                        ^^^
/work_space/8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4(56)
struct headers {
       ^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.p4info.txtpb'\'';config='\''8d48bd4e-f8e9-47e1-ab37-ab76bb5be0dc.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:41:07.631  root      : CRITICAL: test-spec element standard did not match any tests
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