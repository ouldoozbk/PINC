/work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(152): [--Werror=type-error] error: 'standard_metadata.egress_spec = ecmp_base + hash_value'
        standard_metadata.egress_spec = ecmp_base + hash_value;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(152): Source expression 'ecmp_base + hash_value' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = ecmp_base + hash_value;
                                          ^^^^^^^^^^^^^^^^^^^^^^
/work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(176): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
...         meta.is_new_flowlet = (reg_val == 0 || (meta.current_time - reg_val) > 1000000) ? 1 : 0;
                                                                                              ^
/work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(176)
...         meta.is_new_flowlet = (reg_val == 0 || (meta.current_time - reg_val) > 1000000) ? 1 : 0;
                                                                                                  ^
+ p4c --target bmv2 --arch v1model --p4runtime-files b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4info.txtpb /work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4
/work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(152): [--Werror=type-error] error: 'standard_metadata.egress_spec = ecmp_base + hash_value'
        standard_metadata.egress_spec = ecmp_base + hash_value;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(152): Source expression 'ecmp_base + hash_value' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = ecmp_base + hash_value;
                                          ^^^^^^^^^^^^^^^^^^^^^^
/work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(176): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
...         meta.is_new_flowlet = (reg_val == 0 || (meta.current_time - reg_val) > 1000000) ? 1 : 0;
                                                                                              ^
/work_space/b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4(176)
...         meta.is_new_flowlet = (reg_val == 0 || (meta.current_time - reg_val) > 1000000) ? 1 : 0;
                                                                                                  ^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.p4info.txtpb'\'';config='\''b7b1fd64-2596-4c3e-a1c9-6f189aa85c52.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.269  root      : CRITICAL: test-spec element standard did not match any tests
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