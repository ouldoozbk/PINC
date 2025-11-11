/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(89): [--Wwarn=deprecated] warning: mark_to_drop: Using deprecated feature mark_to_drop. Please use mark_to_drop(standard_metadata) instead.
                mark_to_drop();
                ^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(406)
extern void mark_to_drop();
            ^^^^^^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(109): [--Wwarn=deprecated] warning: mark_to_drop: Using deprecated feature mark_to_drop. Please use mark_to_drop(standard_metadata) instead.
                mark_to_drop();
                ^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(406)
extern void mark_to_drop();
            ^^^^^^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(88): [--Werror=type-error] error: Cannot extract field isValid from hdr.ipv4_outer.hdrChecksum which has type bit<16>
            if (!hdr.ipv4_outer.hdrChecksum.isValid()) {
                                            ^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(88)
            if (!hdr.ipv4_outer.hdrChecksum.isValid()) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(108): [--Werror=type-error] error: Cannot extract field isValid from hdr.ipv4_inner.hdrChecksum which has type bit<16>
            if (!hdr.ipv4_inner.hdrChecksum.isValid()) {
                                            ^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(108)
            if (!hdr.ipv4_inner.hdrChecksum.isValid()) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 7f72ddce-233f-42a7-ae16-5ade775f364e.p4info.txtpb /work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(89): [--Wwarn=deprecated] warning: mark_to_drop: Using deprecated feature mark_to_drop. Please use mark_to_drop(standard_metadata) instead.
                mark_to_drop();
                ^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(406)
extern void mark_to_drop();
            ^^^^^^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(109): [--Wwarn=deprecated] warning: mark_to_drop: Using deprecated feature mark_to_drop. Please use mark_to_drop(standard_metadata) instead.
                mark_to_drop();
                ^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(406)
extern void mark_to_drop();
            ^^^^^^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(88): [--Werror=type-error] error: Cannot extract field isValid from hdr.ipv4_outer.hdrChecksum which has type bit<16>
            if (!hdr.ipv4_outer.hdrChecksum.isValid()) {
                                            ^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(88)
            if (!hdr.ipv4_outer.hdrChecksum.isValid()) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(108): [--Werror=type-error] error: Cannot extract field isValid from hdr.ipv4_inner.hdrChecksum which has type bit<16>
            if (!hdr.ipv4_inner.hdrChecksum.isValid()) {
                                            ^^^^^^^
/work_space/7f72ddce-233f-42a7-ae16-5ade775f364e.p4(108)
            if (!hdr.ipv4_inner.hdrChecksum.isValid()) {
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''7f72ddce-233f-42a7-ae16-5ade775f364e.p4info.txtpb'\'';config='\''7f72ddce-233f-42a7-ae16-5ade775f364e.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:06:56.953  root      : CRITICAL: test-spec element standard did not match any tests
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