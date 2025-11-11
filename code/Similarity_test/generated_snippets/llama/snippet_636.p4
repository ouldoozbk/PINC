/work_space/7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4(183): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
            clone3(CloneType.I2E, 100, meta);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
/work_space/7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4(182): [--Werror=type-error] error: meta.flow_count % 100: Cannot operate on values with different widths 32 and 16
        if (meta.flow_count % SAMPLE_RATE == 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4info.txtpb /work_space/7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4
/work_space/7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4(183): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
            clone3(CloneType.I2E, 100, meta);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
/work_space/7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4(182): [--Werror=type-error] error: meta.flow_count % 100: Cannot operate on values with different widths 32 and 16
        if (meta.flow_count % SAMPLE_RATE == 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.p4info.txtpb'\'';config='\''7ce3fbe1-c1ed-4021-8bc6-bb03ccff667f.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:09.416  root      : CRITICAL: test-spec element standard did not match any tests
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