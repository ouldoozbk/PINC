/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(113): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(113): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(189): [--Werror=type-error] error: Cannot extract field hit from multicast_lpm which has type Type_Table
                if (multicast_lpm.hit == false) {
                                  ^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(189)
                if (multicast_lpm.hit == false) {
                    ^^^^^^^^^^^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(199): [--Werror=type-error] error: Cannot extract field hit from ipv4_lpm which has type Type_Table
                if (ipv4_lpm.hit == false) {
                             ^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(199)
                if (ipv4_lpm.hit == false) {
                    ^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4info.txtpb /work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(113): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(113): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(189): [--Werror=type-error] error: Cannot extract field hit from multicast_lpm which has type Type_Table
                if (multicast_lpm.hit == false) {
                                  ^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(189)
                if (multicast_lpm.hit == false) {
                    ^^^^^^^^^^^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(199): [--Werror=type-error] error: Cannot extract field hit from ipv4_lpm which has type Type_Table
                if (ipv4_lpm.hit == false) {
                             ^^^
/work_space/1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4(199)
                if (ipv4_lpm.hit == false) {
                    ^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''1be7f7e0-bdb0-47a8-a731-a1598759f8ac.p4info.txtpb'\'';config='\''1be7f7e0-bdb0-47a8-a731-a1598759f8ac.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:34:14.047  root      : CRITICAL: test-spec element standard did not match any tests
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