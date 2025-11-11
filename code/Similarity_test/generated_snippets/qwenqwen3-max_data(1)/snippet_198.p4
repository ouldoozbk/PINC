/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(99): [--Wwarn=unused] warning: table 'firewall_rules' is unused
    table firewall_rules {
          ^^^^^^^^^^^^^^
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(101): [--Werror=expected] error: ?:: Complex key expression requires a @name annotation
            hdr.ipv4.isValid() ? hdr.ipv4.protocol : 0: exact;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(102): [--Werror=expected] error: ?:: Complex key expression requires a @name annotation
            hdr.ipv4.isValid() ? hdr.ipv4.dstAddr : 0: ternary;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 9d6978b0-5f20-42eb-804a-dc13d45061b2.p4info.txtpb /work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(99): [--Wwarn=unused] warning: table 'firewall_rules' is unused
    table firewall_rules {
          ^^^^^^^^^^^^^^
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(101): [--Werror=expected] error: ?:: Complex key expression requires a @name annotation
            hdr.ipv4.isValid() ? hdr.ipv4.protocol : 0: exact;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/9d6978b0-5f20-42eb-804a-dc13d45061b2.p4(102): [--Werror=expected] error: ?:: Complex key expression requires a @name annotation
            hdr.ipv4.isValid() ? hdr.ipv4.dstAddr : 0: ternary;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''9d6978b0-5f20-42eb-804a-dc13d45061b2.p4info.txtpb'\'';config='\''9d6978b0-5f20-42eb-804a-dc13d45061b2.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:25:36.042  root      : CRITICAL: test-spec element standard did not match any tests
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