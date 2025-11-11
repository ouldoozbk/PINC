/work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(205): [--Werror=type-error] error: 'header_count_reg.write(idx, (bit<32>)meta.hdr_count)'
        header_count_reg.write(idx, (bit<32>) meta.hdr_count);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(205): Type of argument 'idx' (bit<8>) does not match type of parameter 'index' (bit<32>)
          header_count_reg.write(idx, (bit<32>) meta.hdr_count);
                                 ^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(205)
          header_count_reg.write(idx, (bit<32>) meta.hdr_count);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(208): [--Werror=type-error] error: 'pkt_counter_reg.read(tmp, idx)'
        pkt_counter_reg.read(tmp, idx);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(208): Type of argument 'idx' (bit<8>) does not match type of parameter 'index' (bit<32>)
          pkt_counter_reg.read(tmp, idx);
                                    ^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(208)
          pkt_counter_reg.read(tmp, idx);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(209): [--Werror=type-error] error: 'pkt_counter_reg.write(idx, tmp + 1)'
        pkt_counter_reg.write(idx, tmp + 1);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(209): Type of argument 'idx' (bit<8>) does not match type of parameter 'index' (bit<32>)
          pkt_counter_reg.write(idx, tmp + 1);
                                ^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(209)
          pkt_counter_reg.write(idx, tmp + 1);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 009b8ad8-7de3-42db-a80d-0fe391821f98.p4info.txtpb /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4
/work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(205): [--Werror=type-error] error: 'header_count_reg.write(idx, (bit<32>)meta.hdr_count)'
        header_count_reg.write(idx, (bit<32>) meta.hdr_count);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(205): Type of argument 'idx' (bit<8>) does not match type of parameter 'index' (bit<32>)
          header_count_reg.write(idx, (bit<32>) meta.hdr_count);
                                 ^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(205)
          header_count_reg.write(idx, (bit<32>) meta.hdr_count);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(208): [--Werror=type-error] error: 'pkt_counter_reg.read(tmp, idx)'
        pkt_counter_reg.read(tmp, idx);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(208): Type of argument 'idx' (bit<8>) does not match type of parameter 'index' (bit<32>)
          pkt_counter_reg.read(tmp, idx);
                                    ^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                                         ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(208)
          pkt_counter_reg.read(tmp, idx);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(209): [--Werror=type-error] error: 'pkt_counter_reg.write(idx, tmp + 1)'
        pkt_counter_reg.write(idx, tmp + 1);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<8>' to type 'bit<32>'
  ---- Originating from:
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(209): Type of argument 'idx' (bit<8>) does not match type of parameter 'index' (bit<32>)
          pkt_counter_reg.write(idx, tmp + 1);
                                ^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                            ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/009b8ad8-7de3-42db-a80d-0fe391821f98.p4(209)
          pkt_counter_reg.write(idx, tmp + 1);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''009b8ad8-7de3-42db-a80d-0fe391821f98.p4info.txtpb'\'';config='\''009b8ad8-7de3-42db-a80d-0fe391821f98.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:40:41.250  root      : CRITICAL: test-spec element standard did not match any tests
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