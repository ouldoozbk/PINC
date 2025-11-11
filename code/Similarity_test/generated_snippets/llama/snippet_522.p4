/work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): [--Wwarn=mismatch] warning: 2w1024: value does not fit in 2 bits
    meter(2w1024
          ^^^^^^
/work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(106): [--Wwarn=unused] warning: 'my_counter' is unused
    direct_counter(CounterType.packets) my_counter;
                                        ^^^^^^^^^^
/work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): [--Werror=type-error] error: 'my_meter'
    meter(2w1024, MeterType.packets) my_meter;
                                     ^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<2>' to type 'bit<32>'
  ---- Originating from:
  /work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): Type of argument '2w0' (bit<2>) does not match type of parameter 'size' (bit<32>)
      meter(2w1024, MeterType.packets) my_meter;
            ^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(224)
      meter(bit<32> size, MeterType type);
                    ^^^^
  ---- Originating from:
  /work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): Constructor invocation <Method call> does not match constructor declaration meter
      meter(2w1024, MeterType.packets) my_meter;
                                       ^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(224)
      meter(bit<32> size, MeterType type);
      ^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4info.txtpb /work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4
/work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): [--Wwarn=mismatch] warning: 2w1024: value does not fit in 2 bits
    meter(2w1024
          ^^^^^^
/work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(106): [--Wwarn=unused] warning: 'my_counter' is unused
    direct_counter(CounterType.packets) my_counter;
                                        ^^^^^^^^^^
/work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): [--Werror=type-error] error: 'my_meter'
    meter(2w1024, MeterType.packets) my_meter;
                                     ^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<2>' to type 'bit<32>'
  ---- Originating from:
  /work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): Type of argument '2w0' (bit<2>) does not match type of parameter 'size' (bit<32>)
      meter(2w1024, MeterType.packets) my_meter;
            ^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(224)
      meter(bit<32> size, MeterType type);
                    ^^^^
  ---- Originating from:
  /work_space/24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4(105): Constructor invocation <Method call> does not match constructor declaration meter
      meter(2w1024, MeterType.packets) my_meter;
                                       ^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(224)
      meter(bit<32> size, MeterType type);
      ^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.p4info.txtpb'\'';config='\''24da7fd4-7c4e-4351-9a8c-ecdb9eef9366.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:23:17.318  root      : CRITICAL: test-spec element standard did not match any tests
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