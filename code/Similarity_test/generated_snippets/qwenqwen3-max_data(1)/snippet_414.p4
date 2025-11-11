/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(11): [--Wwarn=unused] warning: 'port_t' is unused
typedef bit<16> port_t;
                ^^^^^^
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(149): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(166): [--Werror=type-error] error: Cannot extract field isValid from standard_metadata.mcast_grp which has type bit<16>
        if (!standard_metadata.mcast_grp.isValid()) {
                                         ^^^^^^^
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(166)
        if (!standard_metadata.mcast_grp.isValid()) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4info.txtpb /work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(11): [--Wwarn=unused] warning: 'port_t' is unused
typedef bit<16> port_t;
                ^^^^^^
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(149): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(166): [--Werror=type-error] error: Cannot extract field isValid from standard_metadata.mcast_grp which has type bit<16>
        if (!standard_metadata.mcast_grp.isValid()) {
                                         ^^^^^^^
/work_space/48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4(166)
        if (!standard_metadata.mcast_grp.isValid()) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''48f3f130-4693-46c8-aa6f-f0d21bbf53eb.p4info.txtpb'\'';config='\''48f3f130-4693-46c8-aa6f-f0d21bbf53eb.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:34:09.236  root      : CRITICAL: test-spec element standard did not match any tests
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