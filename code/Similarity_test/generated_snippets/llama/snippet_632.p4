/work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(181): [--Werror=type-error] error: standard_metadata.packet_length % 10: Cannot operate on values with different widths 32 and 16
        if (standard_metadata.packet_length % SAMPLING_RATE == 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(189): [--Werror=type-error] error: 'random(0, 100)'
            if (random<bit<16>>(0, 100) < 10) {
                ^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(189): : Read-only value used for out/inout parameter 'result'
              if (random<bit<16>>(0, 100) < 10) {
                                  ^
  /usr/local/share/p4c/p4include/v1model.p4(367)
  extern void random<T>(out T result, in T lo, in T hi);
                              ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(367): Function type 'random' does not match invocation type '<Method call>'
  extern void random<T>(out T result, in T lo, in T hi);
              ^^^^^^
  /work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(189)
              if (random<bit<16>>(0, 100) < 10) {
                  ^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4info.txtpb /work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4
/work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(181): [--Werror=type-error] error: standard_metadata.packet_length % 10: Cannot operate on values with different widths 32 and 16
        if (standard_metadata.packet_length % SAMPLING_RATE == 0) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(189): [--Werror=type-error] error: 'random(0, 100)'
            if (random<bit<16>>(0, 100) < 10) {
                ^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(189): : Read-only value used for out/inout parameter 'result'
              if (random<bit<16>>(0, 100) < 10) {
                                  ^
  /usr/local/share/p4c/p4include/v1model.p4(367)
  extern void random<T>(out T result, in T lo, in T hi);
                              ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(367): Function type 'random' does not match invocation type '<Method call>'
  extern void random<T>(out T result, in T lo, in T hi);
              ^^^^^^
  /work_space/df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4(189)
              if (random<bit<16>>(0, 100) < 10) {
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''df4056b0-9b77-44ed-96f6-9ca2a57d584a.p4info.txtpb'\'';config='\''df4056b0-9b77-44ed-96f6-9ca2a57d584a.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:24:09.338  root      : CRITICAL: test-spec element standard did not match any tests
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