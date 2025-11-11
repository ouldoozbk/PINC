/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(148): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(153): [--Werror=type-error] error: Field tcp_udp is not a member of structure struct headers
...r.outer_ipv4.protocol == 6 || hdr.outer_ipv4.protocol == 17)) ? hdr.tcp_udp.dstPort : 0: ternary;
                                                                       ^^^^^^^
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(50)
struct headers {
       ^^^^^^^
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(168): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (!standard_metadata.drop) {
                               ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4info.txtpb /work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(148): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(153): [--Werror=type-error] error: Field tcp_udp is not a member of structure struct headers
...r.outer_ipv4.protocol == 6 || hdr.outer_ipv4.protocol == 17)) ? hdr.tcp_udp.dstPort : 0: ternary;
                                                                       ^^^^^^^
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(50)
struct headers {
       ^^^^^^^
/work_space/936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4(168): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''936c2fcf-07c5-48d1-ad32-eda46d81dbb8.p4info.txtpb'\'';config='\''936c2fcf-07c5-48d1-ad32-eda46d81dbb8.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:32:04.232  root      : CRITICAL: test-spec element standard did not match any tests
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