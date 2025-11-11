/work_space/573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4(180): [--Werror=type-error] error: 'standard_metadata.egress_spec = next_port'
        standard_metadata.egress_spec = next_port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<9>'
  ---- Originating from:
  /work_space/573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4(180): Source expression 'next_port' produces a result of type 'bit<16>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = next_port;
                                          ^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4info.txtpb /work_space/573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4
/work_space/573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4(180): [--Werror=type-error] error: 'standard_metadata.egress_spec = next_port'
        standard_metadata.egress_spec = next_port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<9>'
  ---- Originating from:
  /work_space/573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4(180): Source expression 'next_port' produces a result of type 'bit<16>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = next_port;
                                          ^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''573d347b-1dc6-4646-a3a9-2ae1d3d8af11.p4info.txtpb'\'';config='\''573d347b-1dc6-4646-a3a9-2ae1d3d8af11.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:12:41.625  root      : CRITICAL: test-spec element standard did not match any tests
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