/work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4(124): [--Wwarn=unused] warning: 'egress_meter' is unused
    meter<bit<32>, bit<32>>(65536) egress_meter;
                                   ^^^^^^^^^^^^
/work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4(124): [--Werror=type-error] error: meter<bit<32>, bit<32>>: Type meter has 0 type parameter(s), but it is specialized with 2
    meter<bit<32>, bit<32>>(65536) egress_meter;
    ^^^^^^^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(205)
extern meter
       ^^^^^
/work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4(154): [--Werror=type-error] error: meter<bit<32>, bit<32>>: Type meter has 0 type parameter(s), but it is specialized with 2
    meter<bit<32>, bit<32>>(65536) egress_meter;
    ^^^^^^^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(205)
extern meter
       ^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4info.txtpb /work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4
/work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4(124): [--Wwarn=unused] warning: 'egress_meter' is unused
    meter<bit<32>, bit<32>>(65536) egress_meter;
                                   ^^^^^^^^^^^^
/work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4(124): [--Werror=type-error] error: meter<bit<32>, bit<32>>: Type meter has 0 type parameter(s), but it is specialized with 2
    meter<bit<32>, bit<32>>(65536) egress_meter;
    ^^^^^^^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(205)
extern meter
       ^^^^^
/work_space/f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4(154): [--Werror=type-error] error: meter<bit<32>, bit<32>>: Type meter has 0 type parameter(s), but it is specialized with 2
    meter<bit<32>, bit<32>>(65536) egress_meter;
    ^^^^^^^^^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(205)
extern meter
       ^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''f141f2fc-2c43-4e48-8630-7ce231c1e78b.p4info.txtpb'\'';config='\''f141f2fc-2c43-4e48-8630-7ce231c1e78b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:21:28.190  root      : CRITICAL: test-spec element standard did not match any tests
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