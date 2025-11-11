/work_space/d0e6ab73-526a-45b4-a262-f2b3fea11cad.p4(148): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.egress_spec == 0 && !standard_metadata.drop) {
                                                                     ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files d0e6ab73-526a-45b4-a262-f2b3fea11cad.p4info.txtpb /work_space/d0e6ab73-526a-45b4-a262-f2b3fea11cad.p4
/work_space/d0e6ab73-526a-45b4-a262-f2b3fea11cad.p4(148): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.egress_spec == 0 && !standard_metadata.drop) {
                                                                     ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''d0e6ab73-526a-45b4-a262-f2b3fea11cad.p4info.txtpb'\'';config='\''d0e6ab73-526a-45b4-a262-f2b3fea11cad.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:18:30.732  root      : CRITICAL: test-spec element standard did not match any tests
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