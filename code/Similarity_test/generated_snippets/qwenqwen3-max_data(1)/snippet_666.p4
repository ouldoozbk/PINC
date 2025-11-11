/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(110): [--Wwarn=unused] warning: 'set_sfc_path' is unused
    action set_sfc_path(bit<8> path_id, bit<8> index) {
           ^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(124): [--Wwarn=unused] warning: 'original_src' is unused
        macAddr_t original_src = hdr.ethernet.srcAddr;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(164): [--Wwarn=unused] warning: table 'firewall_rules' is unused
    table firewall_rules {
          ^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(180): [--Wwarn=unused] warning: table 'tcp_udp_port_match' is unused
    table tcp_udp_port_match {
          ^^^^^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(230): [--Wwarn=unused] warning: 'dst_port' is unused
                bit<16> dst_port;
                ^^^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(205): [--Werror=type-error] error: drop() not present in action list
        default_action = drop();
                         ^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 96828949-508d-44b2-bb8a-e2c79df38d54.p4info.txtpb /work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(110): [--Wwarn=unused] warning: 'set_sfc_path' is unused
    action set_sfc_path(bit<8> path_id, bit<8> index) {
           ^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(124): [--Wwarn=unused] warning: 'original_src' is unused
        macAddr_t original_src = hdr.ethernet.srcAddr;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(164): [--Wwarn=unused] warning: table 'firewall_rules' is unused
    table firewall_rules {
          ^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(180): [--Wwarn=unused] warning: table 'tcp_udp_port_match' is unused
    table tcp_udp_port_match {
          ^^^^^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(230): [--Wwarn=unused] warning: 'dst_port' is unused
                bit<16> dst_port;
                ^^^^^^^^^^^^^^^^
/work_space/96828949-508d-44b2-bb8a-e2c79df38d54.p4(205): [--Werror=type-error] error: drop() not present in action list
        default_action = drop();
                         ^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''96828949-508d-44b2-bb8a-e2c79df38d54.p4info.txtpb'\'';config='\''96828949-508d-44b2-bb8a-e2c79df38d54.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:44:48.244  root      : CRITICAL: test-spec element standard did not match any tests
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