/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(241): [--Wwarn=shadow] warning: 'range' shadows 'range'
            bit<32> range = MAX_THRESH - MIN_THRESH;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(50)
    range,
    ^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(158): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(192): [--Werror=type-error] error: interface_action.apply().action_run: only allowed in switch statements
        if (interface_action.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(199): [--Werror=type-error] error: firewall_rules.apply().action_run: only allowed in switch statements
                if (firewall_rules.apply().action_run == drop) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(245): [--Werror=type-error] error: 'random(0, 1000)'
            bit<32> rand = (bit<32>)random<bit<32>>(0, 1000);
                                    ^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(245): : Read-only value used for out/inout parameter 'result'
              bit<32> rand = (bit<32>)random<bit<32>>(0, 1000);
                                                      ^
  /usr/local/share/p4c/p4include/v1model.p4(367)
  extern void random<T>(out T result, in T lo, in T hi);
                              ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(367): Function type 'random' does not match invocation type '<Method call>'
  extern void random<T>(out T result, in T lo, in T hi);
              ^^^^^^
  /work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(245)
              bit<32> rand = (bit<32>)random<bit<32>>(0, 1000);
                                      ^^^^^^^^^^^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(246): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            meta.should_drop = (rand < prob_scaled) ? 1 : 0;
                                                      ^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(246)
            meta.should_drop = (rand < prob_scaled) ? 1 : 0;
                                                          ^
+ p4c --target bmv2 --arch v1model --p4runtime-files 21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4info.txtpb /work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(241): [--Wwarn=shadow] warning: 'range' shadows 'range'
            bit<32> range = MAX_THRESH - MIN_THRESH;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(50)
    range,
    ^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(158): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(192): [--Werror=type-error] error: interface_action.apply().action_run: only allowed in switch statements
        if (interface_action.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(199): [--Werror=type-error] error: firewall_rules.apply().action_run: only allowed in switch statements
                if (firewall_rules.apply().action_run == drop) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(245): [--Werror=type-error] error: 'random(0, 1000)'
            bit<32> rand = (bit<32>)random<bit<32>>(0, 1000);
                                    ^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(245): : Read-only value used for out/inout parameter 'result'
              bit<32> rand = (bit<32>)random<bit<32>>(0, 1000);
                                                      ^
  /usr/local/share/p4c/p4include/v1model.p4(367)
  extern void random<T>(out T result, in T lo, in T hi);
                              ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(367): Function type 'random' does not match invocation type '<Method call>'
  extern void random<T>(out T result, in T lo, in T hi);
              ^^^^^^
  /work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(245)
              bit<32> rand = (bit<32>)random<bit<32>>(0, 1000);
                                      ^^^^^^^^^^^^^^^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(246): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            meta.should_drop = (rand < prob_scaled) ? 1 : 0;
                                                      ^
/work_space/21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4(246)
            meta.should_drop = (rand < prob_scaled) ? 1 : 0;
                                                          ^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.p4info.txtpb'\'';config='\''21ec1745-ec1f-41fa-8cf2-de7eb82d7f1f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:44:48.278  root      : CRITICAL: test-spec element standard did not match any tests
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