/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(11): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(176): [--Werror=type-error] error: 'queue_time_register.write(standard_metadata.deq_qdepth, current_time)'
        queue_time_register.write(standard_metadata.deq_qdepth, current_time);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(176): Type of argument 'standard_metadata.deq_qdepth' (bit<19>) does not match type of parameter 'index' (bit<32>)
          queue_time_register.write(standard_metadata.deq_qdepth, current_time);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(176)
          queue_time_register.write(standard_metadata.deq_qdepth, current_time);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(181): [--Werror=type-error] error: 'queue_time_register.read(reg_val, standard_metadata.deq_qdepth)'
        queue_time_register.read(reg_val, standard_metadata.deq_qdepth);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(181): Type of argument 'standard_metadata.deq_qdepth' (bit<19>) does not match type of parameter 'index' (bit<32>)
          queue_time_register.read(reg_val, standard_metadata.deq_qdepth);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(181)
          queue_time_register.read(reg_val, standard_metadata.deq_qdepth);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(220): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(229): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(235): [--Werror=type-error] error: standard_metadata.deq_qdepth < 1000: not defined on bit<19> and bit<32>
            if (standard_metadata.deq_qdepth < MAX_PACKETS) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files cf7cefc7-2183-4dec-8b83-37850f56db65.p4info.txtpb /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(11): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(176): [--Werror=type-error] error: 'queue_time_register.write(standard_metadata.deq_qdepth, current_time)'
        queue_time_register.write(standard_metadata.deq_qdepth, current_time);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(176): Type of argument 'standard_metadata.deq_qdepth' (bit<19>) does not match type of parameter 'index' (bit<32>)
          queue_time_register.write(standard_metadata.deq_qdepth, current_time);
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(176)
          queue_time_register.write(standard_metadata.deq_qdepth, current_time);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(181): [--Werror=type-error] error: 'queue_time_register.read(reg_val, standard_metadata.deq_qdepth)'
        queue_time_register.read(reg_val, standard_metadata.deq_qdepth);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(181): Type of argument 'standard_metadata.deq_qdepth' (bit<19>) does not match type of parameter 'index' (bit<32>)
          queue_time_register.read(reg_val, standard_metadata.deq_qdepth);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(181)
          queue_time_register.read(reg_val, standard_metadata.deq_qdepth);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(220): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(229): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/cf7cefc7-2183-4dec-8b83-37850f56db65.p4(235): [--Werror=type-error] error: standard_metadata.deq_qdepth < 1000: not defined on bit<19> and bit<32>
            if (standard_metadata.deq_qdepth < MAX_PACKETS) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''cf7cefc7-2183-4dec-8b83-37850f56db65.p4info.txtpb'\'';config='\''cf7cefc7-2183-4dec-8b83-37850f56db65.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:39:40.166  root      : CRITICAL: test-spec element standard did not match any tests
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