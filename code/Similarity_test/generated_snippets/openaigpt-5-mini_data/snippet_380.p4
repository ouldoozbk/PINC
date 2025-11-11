/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Wwarn=unused] warning: 'client_to_server' is unused
...bool client_to_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.src...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Wwarn=unused] warning: 'server_to_client' is unused
...bool server_to_client = (hdr.udp.srcPort == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.src...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(110): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(110): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(115): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(115): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
            bool client_to_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hd...
                                     ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163)
... bool client_to_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.sr...
                                                ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w67' with type 'bit<68>'
...o_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68...
                                           ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163)
...r.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68 && hdr.udp.ds...
                                                ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
... == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 16w67);
                                              ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163)
... == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 16w67);
                                                                 ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
...o_client = (hdr.udp.srcPort == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67...
                                           ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164)
...r.udp.srcPort == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.ds...
                                                ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w67' with type 'bit<68>'
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                              ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164)
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                                                 ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                                                          ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164)
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                                                                             ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
...6w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68...
                                           ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165)
...w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68)) {
                                                             ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
...w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68)) {
                                                                        ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165)
...w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68)) {
                                                                                           ^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 0261e5f9-6a79-42e7-90e2-83d4d4292905.p4info.txtpb /work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Wwarn=unused] warning: 'client_to_server' is unused
...bool client_to_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.src...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Wwarn=unused] warning: 'server_to_client' is unused
...bool server_to_client = (hdr.udp.srcPort == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.src...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(110): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(110): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(115): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(115): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
            bool client_to_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hd...
                                     ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163)
... bool client_to_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.sr...
                                                ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w67' with type 'bit<68>'
...o_server = (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68...
                                           ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163)
...r.udp.srcPort == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68 && hdr.udp.ds...
                                                ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
... == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 16w67);
                                              ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(163)
... == 68w68 && hdr.udp.dstPort == 68w67) || (hdr.udp.srcPort == 68w68 && hdr.udp.dstPort == 16w67);
                                                                 ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
...o_client = (hdr.udp.srcPort == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67...
                                           ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164)
...r.udp.srcPort == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.ds...
                                                ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w67' with type 'bit<68>'
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                              ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164)
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                                                 ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                                                          ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(164)
... == 16w67 && hdr.udp.dstPort == 68w68) || (hdr.udp.srcPort == 68w67 && hdr.udp.dstPort == 68w68);
                                                                                             ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165): [--Werror=type-error] error: 'hdr.udp.srcPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
...6w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68...
                                           ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165)
...w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68)) {
                                                             ^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165): [--Werror=type-error] error: 'hdr.udp.dstPort' with type 'bit<16>' cannot be compared to '68w68' with type 'bit<68>'
...w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68)) {
                                                                        ^^^^^^^^^^^^^^^
/work_space/0261e5f9-6a79-42e7-90e2-83d4d4292905.p4(165)
...w67) || (hdr.udp.dstPort == 16w67) || (hdr.udp.srcPort == 68w68) || (hdr.udp.dstPort == 68w68)) {
                                                                                           ^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''0261e5f9-6a79-42e7-90e2-83d4d4292905.p4info.txtpb'\'';config='\''0261e5f9-6a79-42e7-90e2-83d4d4292905.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:22:20.945  root      : CRITICAL: test-spec element standard did not match any tests
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