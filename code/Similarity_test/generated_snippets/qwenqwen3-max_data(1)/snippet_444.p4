/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(118): [--Werror=type-error] error: counter<bit<32>>: Type counter has 0 type parameter(s), but it is specialized with 1
    counter<bit<32>>(1024) tcp_counter;
    ^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(127)
extern counter
       ^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(119): [--Werror=type-error] error: counter<bit<32>>: Type counter has 0 type parameter(s), but it is specialized with 1
    counter<bit<32>>(1024) udp_counter;
    ^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(127)
extern counter
       ^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(185): [--Werror=type-error] error: interface_action.apply().action_run: only allowed in switch statements
        if (interface_action.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(194): [--Werror=type-error] error: firewall_tcp.apply().action_run: only allowed in switch statements
                if (firewall_tcp.apply().action_run == drop) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(201): [--Werror=type-error] error: firewall_udp.apply().action_run: only allowed in switch statements
                if (firewall_udp.apply().action_run == drop) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4info.txtpb /work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(118): [--Werror=type-error] error: counter<bit<32>>: Type counter has 0 type parameter(s), but it is specialized with 1
    counter<bit<32>>(1024) tcp_counter;
    ^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(127)
extern counter
       ^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(119): [--Werror=type-error] error: counter<bit<32>>: Type counter has 0 type parameter(s), but it is specialized with 1
    counter<bit<32>>(1024) udp_counter;
    ^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(127)
extern counter
       ^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(185): [--Werror=type-error] error: interface_action.apply().action_run: only allowed in switch statements
        if (interface_action.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(194): [--Werror=type-error] error: firewall_tcp.apply().action_run: only allowed in switch statements
                if (firewall_tcp.apply().action_run == drop) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4(201): [--Werror=type-error] error: firewall_udp.apply().action_run: only allowed in switch statements
                if (firewall_udp.apply().action_run == drop) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''918c0565-d63d-4028-9e4e-b8507fcfa4d5.p4info.txtpb'\'';config='\''918c0565-d63d-4028-9e4e-b8507fcfa4d5.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:35:11.379  root      : CRITICAL: test-spec element standard did not match any tests
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