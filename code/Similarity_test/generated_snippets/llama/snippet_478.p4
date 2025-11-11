/work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4(153): [--Wwarn=unused] warning: 'port' is unused
    action mirror(egressSpec_t port) {
                               ^^^^
/work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4(154): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
        clone3(CloneType.I2E, 100, standard_metadata.egress_spec);
        ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
warning: Ingress parser exception handler not fully implemented
In file: /p4c/backends/p4tools/modules/testgen/core/small_step/extern_stepper.cpp:337
Unimplemented P4Testgen support: /work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4(154): Unknown or unimplemented extern method: clone3
        clone3(CloneType.I2E, 100, standard_metadata.egress_spec);
        ^^^^^^

+ p4c --target bmv2 --arch v1model --p4runtime-files 10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4info.txtpb /work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4
/work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4(153): [--Wwarn=unused] warning: 'port' is unused
    action mirror(egressSpec_t port) {
                               ^^^^
/work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4(154): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
        clone3(CloneType.I2E, 100, standard_metadata.egress_spec);
        ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
/work_space/10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4(153): [--Wwarn=unused] warning: Unused action parameter port
    action mirror(egressSpec_t port) {
                               ^^^^
/usr/local/share/p4c/p4include/v1model.p4(604): [--Werror=unknown] error: clone3: unknown extern function
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''10ac7177-c58a-4f59-8a61-e8aab76e1d50.p4info.txtpb'\'';config='\''10ac7177-c58a-4f59-8a61-e8aab76e1d50.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:22:10.380  root      : CRITICAL: test-spec element standard did not match any tests
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