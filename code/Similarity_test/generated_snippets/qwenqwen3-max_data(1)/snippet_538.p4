/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(120): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(133): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(135): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(195): [--Werror=type-error] error: 'now = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp'
        now = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
            ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<64>'
  ---- Originating from:
  /work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(195): Source expression 'standard_metadata.deq_timedelta + standard_metadata.enq_timestamp' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<64>'
          now = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(216): [--Werror=type-error] error: Cannot apply ! to value first_above_time of type bit<1>
            } else if (!first_above_time) {
                        ^^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(227): [--Werror=type-error] error: first_above_time && min_delay > (bit<32>)5000000: not defined on bit<1> and bool
        if (first_above_time &&
            ^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(229): [--Werror=type-error] error: 1 << drop_count: shift result type is arbitrary-precision int, but right operand is not constant; width of left operand of shift needs to be specified or both operands need to be constant
            packets_since_drop >= (1 << drop_count)) {
                                   ^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(216): [--Werror=type-error] error: Cannot apply ! to value first_above_time of type bit<1>
            } else if (!first_above_time) {
                        ^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4info.txtpb /work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(120): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(133): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(135): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(195): [--Werror=type-error] error: 'now = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp'
        now = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
            ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<64>'
  ---- Originating from:
  /work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(195): Source expression 'standard_metadata.deq_timedelta + standard_metadata.enq_timestamp' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<64>'
          now = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(216): [--Werror=type-error] error: Cannot apply ! to value first_above_time of type bit<1>
            } else if (!first_above_time) {
                        ^^^^^^^^^^^^^^^^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(227): [--Werror=type-error] error: first_above_time && min_delay > (bit<32>)5000000: not defined on bit<1> and bool
        if (first_above_time &&
            ^
/work_space/cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4(229): [--Werror=type-error] error: 1 << drop_count: shift result type is arbitrary-precision int, but right operand is not constant; width of left operand of shift needs to be specified or both operands need to be constant
            packets_since_drop >= (1 << drop_count)) {
                                   ^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.p4info.txtpb'\'';config='\''cbe4a2e9-450b-401c-aa6b-31d0a4aac3b8.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:39:40.299  root      : CRITICAL: test-spec element standard did not match any tests
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