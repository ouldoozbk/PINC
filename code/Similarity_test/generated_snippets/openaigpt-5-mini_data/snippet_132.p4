/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(8): [--Wwarn=unused] warning: 'PAXOS_PROMISE' is unused
const bit<8> PAXOS_PROMISE = 2;
             ^^^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(10): [--Wwarn=unused] warning: 'PAXOS_ACCEPTED' is unused
const bit<8> PAXOS_ACCEPTED = 4;
             ^^^^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(11): [--Wwarn=unused] warning: 'PAXOS_LEARN' is unused
const bit<8> PAXOS_LEARN = 5;
             ^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(13): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(139): [--Werror=type-error] error: 0: could not infer a width
            hash(meta.paxos_idx, HashAlgorithm.crc16, 0, { hdr.paxos.instance }, (bit<32>)1024);
                                                      ^
+ p4c --target bmv2 --arch v1model --p4runtime-files 716f29f1-8c79-4df2-b2c5-df983b43a592.p4info.txtpb /work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(8): [--Wwarn=unused] warning: 'PAXOS_PROMISE' is unused
const bit<8> PAXOS_PROMISE = 2;
             ^^^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(10): [--Wwarn=unused] warning: 'PAXOS_ACCEPTED' is unused
const bit<8> PAXOS_ACCEPTED = 4;
             ^^^^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(11): [--Wwarn=unused] warning: 'PAXOS_LEARN' is unused
const bit<8> PAXOS_LEARN = 5;
             ^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(13): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/716f29f1-8c79-4df2-b2c5-df983b43a592.p4(139): [--Werror=type-error] error: 0: could not infer a width
            hash(meta.paxos_idx, HashAlgorithm.crc16, 0, { hdr.paxos.instance }, (bit<32>)1024);
                                                      ^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''716f29f1-8c79-4df2-b2c5-df983b43a592.p4info.txtpb'\'';config='\''716f29f1-8c79-4df2-b2c5-df983b43a592.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:12:34.252  root      : CRITICAL: test-spec element standard did not match any tests
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