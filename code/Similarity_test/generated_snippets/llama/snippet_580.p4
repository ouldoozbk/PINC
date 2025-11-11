/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(141): [--Wwarn=unused] warning: 'flowlet_id' is unused
    bit<32> flowlet_id;
    ^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(148): [--Werror=type-error] error: 'flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index)'
        flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(148): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
                                            ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(148)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(149): [--Werror=type-error] error: 'last_timestamp.read(last_ts, meta.flowlet_map_index)'
        last_timestamp.read(last_ts, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(149): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
          last_timestamp.read(last_ts, meta.flowlet_map_index);
                                       ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(149)
          last_timestamp.read(last_ts, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(154): [--Werror=type-error] error: 'flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id)'
            flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(154): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
                                ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(154)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(159): [--Werror=type-error] error: 'last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp)'
        last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(159): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
          last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp);
                               ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(159)
          last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4info.txtpb /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(141): [--Wwarn=unused] warning: 'flowlet_id' is unused
    bit<32> flowlet_id;
    ^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(148): [--Werror=type-error] error: 'flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index)'
        flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(148): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
                                            ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(148)
          flowlet_map.read(meta.flowlet_id, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(149): [--Werror=type-error] error: 'last_timestamp.read(last_ts, meta.flowlet_map_index)'
        last_timestamp.read(last_ts, meta.flowlet_map_index);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(149): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
          last_timestamp.read(last_ts, meta.flowlet_map_index);
                                       ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(149)
          last_timestamp.read(last_ts, meta.flowlet_map_index);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(154): [--Werror=type-error] error: 'flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id)'
            flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(154): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
                                ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(154)
              flowlet_map.write(meta.flowlet_map_index, meta.flowlet_id);
              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(159): [--Werror=type-error] error: 'last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp)'
        last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(159): Type of argument 'meta.flowlet_map_index' (bit<16>) does not match type of parameter 'index' (bit<32>)
          last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp);
                               ^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4(159)
          last_timestamp.write(meta.flowlet_map_index, (bit<16>)current_timestamp);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''06e77a6c-aef6-46a5-8d7e-4bc96e622517.p4info.txtpb'\'';config='\''06e77a6c-aef6-46a5-8d7e-4bc96e622517.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:08.387  root      : CRITICAL: test-spec element standard did not match any tests
+ echo ''
+ echo 'PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ...'
+ pkill --signal 9 --list-name simple_switch
+ echo ''
+ echo 'Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ...'
+ for i in {1..20}
+ pgrep -f simple_switch_grpc
+ echo 'simple_switch_grpc terminated'
+ break
+ grep simple_switch
+ ps axguwww