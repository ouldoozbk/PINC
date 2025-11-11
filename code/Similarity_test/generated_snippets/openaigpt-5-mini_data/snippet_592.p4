/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(9): [--Wwarn=unused] warning: 'egress_t' is unused
typedef bit<9> egress_t;
               ^^^^^^^^
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121): [--Wwarn=mismatch] warning: 4w32: value does not fit in 4 bits
        packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
                                                              ^^
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121): [--Werror=type-error] error: 'packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 0)'
        packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<4>' to type 'bit<32>'
  ---- Originating from:
  /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121): Type of argument '(hdr.ipv4.ihl - 5) * 0' (bit<4>) does not match type of parameter 'variableFieldSizeInBits' (bit<32>)
          packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
                                           ^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/core.p4(44)
                      in bit<32> variableFieldSizeInBits);
                                 ^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/core.p4(43): Function type 'extract' does not match invocation type '<Method call>'
      void extract<T>(out T variableSizeHeader,
           ^^^^^^^
  /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121)
          packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(157): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(157): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4info.txtpb /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(9): [--Wwarn=unused] warning: 'egress_t' is unused
typedef bit<9> egress_t;
               ^^^^^^^^
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121): [--Wwarn=mismatch] warning: 4w32: value does not fit in 4 bits
        packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
                                                              ^^
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121): [--Werror=type-error] error: 'packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 0)'
        packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<4>' to type 'bit<32>'
  ---- Originating from:
  /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121): Type of argument '(hdr.ipv4.ihl - 5) * 0' (bit<4>) does not match type of parameter 'variableFieldSizeInBits' (bit<32>)
          packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
                                           ^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/core.p4(44)
                      in bit<32> variableFieldSizeInBits);
                                 ^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/core.p4(43): Function type 'extract' does not match invocation type '<Method call>'
      void extract<T>(out T variableSizeHeader,
           ^^^^^^^
  /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(121)
          packet.extract(hdr.ipv4_options, (hdr.ipv4.ihl - 5) * 32);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(157): [--Werror=type-error] error: 'standard_metadata.egress_spec = (bit<32>)port'
        standard_metadata.egress_spec = (bit<32>)port;
                                      ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<9>'
  ---- Originating from:
  /work_space/8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4(157): Source expression '(bit<32>)port' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<9>'
          standard_metadata.egress_spec = (bit<32>)port;
                                          ^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.p4info.txtpb'\'';config='\''8b565f5f-6ce7-4a6d-9972-a1473e9a6b54.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:32:58.702  root      : CRITICAL: test-spec element standard did not match any tests
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