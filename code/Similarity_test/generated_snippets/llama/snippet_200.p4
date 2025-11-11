/work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4(166): [--Werror=type-error] error: 'clone_preserving_field_list(CloneType.I2E, 1, standard_metadata)'
                    clone_preserving_field_list(CloneType.I2E, 1, standard_metadata);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4(166): standard_metadata: argument used for directionless parameter 'index' must be a compile-time constant
                      clone_preserving_field_list(CloneType.I2E, 1, standard_metadata);
                                                                    ^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(640)
  extern void clone_preserving_field_list(in CloneType type, in bit<32> session, bit<8> index);
                                                                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(640): Function type 'clone_preserving_field_list' does not match invocation type '<Method call>'
  extern void clone_preserving_field_list(in CloneType type, in bit<32> session, bit<8> index);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4(166)
                      clone_preserving_field_list(CloneType.I2E, 1, standard_metadata);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files c8aa70cb-5eaf-4d29-a626-52720982fd86.p4info.txtpb /work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4
/work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4(166): [--Werror=type-error] error: 'clone_preserving_field_list(CloneType.I2E, 1, standard_metadata)'
                    clone_preserving_field_list(CloneType.I2E, 1, standard_metadata);
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4(166): standard_metadata: argument used for directionless parameter 'index' must be a compile-time constant
                      clone_preserving_field_list(CloneType.I2E, 1, standard_metadata);
                                                                    ^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(640)
  extern void clone_preserving_field_list(in CloneType type, in bit<32> session, bit<8> index);
                                                                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(640): Function type 'clone_preserving_field_list' does not match invocation type '<Method call>'
  extern void clone_preserving_field_list(in CloneType type, in bit<32> session, bit<8> index);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/c8aa70cb-5eaf-4d29-a626-52720982fd86.p4(166)
                      clone_preserving_field_list(CloneType.I2E, 1, standard_metadata);
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''c8aa70cb-5eaf-4d29-a626-52720982fd86.p4info.txtpb'\'';config='\''c8aa70cb-5eaf-4d29-a626-52720982fd86.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:14:30.621  root      : CRITICAL: test-spec element standard did not match any tests
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