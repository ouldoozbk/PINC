/work_space/3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4(200): [--Werror=type-error] error: 'meta.queue_occupancy = standard_metadata.deq_qdepth / 500'
        meta.queue_occupancy = standard_metadata.deq_qdepth / 500;
                             ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4(200): Source expression 'standard_metadata.deq_qdepth / 500' produces a result of type 'bit<19>' which cannot be assigned to a left-value with type 'bit<32>'
          meta.queue_occupancy = standard_metadata.deq_qdepth / 500;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4info.txtpb /work_space/3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4
/work_space/3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4(200): [--Werror=type-error] error: 'meta.queue_occupancy = standard_metadata.deq_qdepth / 500'
        meta.queue_occupancy = standard_metadata.deq_qdepth / 500;
                             ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4(200): Source expression 'standard_metadata.deq_qdepth / 500' produces a result of type 'bit<19>' which cannot be assigned to a left-value with type 'bit<32>'
          meta.queue_occupancy = standard_metadata.deq_qdepth / 500;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''3c3264fe-cb55-4903-a73b-cc8adc3d49d8.p4info.txtpb'\'';config='\''3c3264fe-cb55-4903-a73b-cc8adc3d49d8.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:44:48.204  root      : CRITICAL: test-spec element standard did not match any tests
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