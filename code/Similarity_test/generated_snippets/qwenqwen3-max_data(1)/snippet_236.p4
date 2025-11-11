/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(123): [--Wwarn=unused] warning: table 'interface_action' is unused
    table interface_action {
          ^^^^^^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(115): [--Werror=type-error] error: Field reg_pos_one is not a member of structure struct metadata
        meta.reg_pos_one = reg_pos_one;
             ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(116): [--Werror=type-error] error: Field reg_pos_two is not a member of structure struct metadata
        meta.reg_pos_two = reg_pos_two;
             ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(204): [--Werror=type-error] error: Field reg_pos_one is not a member of structure struct metadata
                bloom_filter_1.write(meta.reg_pos_one, 1);
                                          ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(205): [--Werror=type-error] error: Field reg_pos_two is not a member of structure struct metadata
                bloom_filter_2.write(meta.reg_pos_two, 1);
                                          ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(211): [--Werror=type-error] error: Field reg_pos_one is not a member of structure struct metadata
            bloom_filter_1.read(val1, meta.reg_pos_one);
                                           ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(212): [--Werror=type-error] error: Field reg_pos_two is not a member of structure struct metadata
            bloom_filter_2.read(val2, meta.reg_pos_two);
                                           ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 83059a73-ec33-4122-be99-5556894f908a.p4info.txtpb /work_space/83059a73-ec33-4122-be99-5556894f908a.p4
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(123): [--Wwarn=unused] warning: table 'interface_action' is unused
    table interface_action {
          ^^^^^^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(115): [--Werror=type-error] error: Field reg_pos_one is not a member of structure struct metadata
        meta.reg_pos_one = reg_pos_one;
             ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(116): [--Werror=type-error] error: Field reg_pos_two is not a member of structure struct metadata
        meta.reg_pos_two = reg_pos_two;
             ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(204): [--Werror=type-error] error: Field reg_pos_one is not a member of structure struct metadata
                bloom_filter_1.write(meta.reg_pos_one, 1);
                                          ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(205): [--Werror=type-error] error: Field reg_pos_two is not a member of structure struct metadata
                bloom_filter_2.write(meta.reg_pos_two, 1);
                                          ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(211): [--Werror=type-error] error: Field reg_pos_one is not a member of structure struct metadata
            bloom_filter_1.read(val1, meta.reg_pos_one);
                                           ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(212): [--Werror=type-error] error: Field reg_pos_two is not a member of structure struct metadata
            bloom_filter_2.read(val2, meta.reg_pos_two);
                                           ^^^^^^^^^^^
/work_space/83059a73-ec33-4122-be99-5556894f908a.p4(54)
struct metadata {
       ^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''83059a73-ec33-4122-be99-5556894f908a.p4info.txtpb'\'';config='\''83059a73-ec33-4122-be99-5556894f908a.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:28:50.554  root      : CRITICAL: test-spec element standard did not match any tests
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