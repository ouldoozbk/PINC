/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(183): [--Wwarn=shadow] warning: 'qsize' shadows 'qsize'
        bit<32> qsize;
        ^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(135)
    bit<32> qsize;
    ^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(139): [--Werror=type-error] error: 'current_time = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp'
        current_time = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
                     ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<64>'
  ---- Originating from:
  /work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(139): Source expression 'standard_metadata.deq_timedelta + standard_metadata.enq_timestamp' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<64>'
          current_time = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(157): [--Werror=type-error] error: standard_metadata.deq_timedelta > 5000000: not defined on bit<32> and bit<64>
            if (qsize > 1 && (standard_metadata.deq_timedelta > TARGET)) {
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(160): [--Werror=type-error] error: 100000000 / count: Cannot operate on values with different widths 64 and 32
                time_next = current_time + (INTERVAL / count);
                                            ^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(193): [--Werror=type-error] error: Condition of IfStatement does not evaluate to a bool but bit<1>
        if (meta.drop) {
        ^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(204): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.parser_error of type error
        if (!standard_metadata.parser_error) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(206): [--Werror=type-error] error: Condition of IfStatement does not evaluate to a bool but bit<1>
            if (overloaded) {
            ^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(204): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.parser_error of type error
        if (!standard_metadata.parser_error) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4info.txtpb /work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(183): [--Wwarn=shadow] warning: 'qsize' shadows 'qsize'
        bit<32> qsize;
        ^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(135)
    bit<32> qsize;
    ^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(139): [--Werror=type-error] error: 'current_time = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp'
        current_time = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
                     ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<64>'
  ---- Originating from:
  /work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(139): Source expression 'standard_metadata.deq_timedelta + standard_metadata.enq_timestamp' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<64>'
          current_time = standard_metadata.deq_timedelta + standard_metadata.enq_timestamp;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(157): [--Werror=type-error] error: standard_metadata.deq_timedelta > 5000000: not defined on bit<32> and bit<64>
            if (qsize > 1 && (standard_metadata.deq_timedelta > TARGET)) {
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(160): [--Werror=type-error] error: 100000000 / count: Cannot operate on values with different widths 64 and 32
                time_next = current_time + (INTERVAL / count);
                                            ^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(193): [--Werror=type-error] error: Condition of IfStatement does not evaluate to a bool but bit<1>
        if (meta.drop) {
        ^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(204): [--Werror=type-error] error: Cannot apply ! to value standard_metadata.parser_error of type error
        if (!standard_metadata.parser_error) {
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4(206): [--Werror=type-error] error: Condition of IfStatement does not evaluate to a bool but bit<1>
            if (overloaded) {
            ^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''1bed8233-5695-42b3-bc7a-2a22dd73a29a.p4info.txtpb'\'';config='\''1bed8233-5695-42b3-bc7a-2a22dd73a29a.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:39:40.121  root      : CRITICAL: test-spec element standard did not match any tests
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