/work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170): [--Werror=type-error] error: 'new_dst'
        macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170): Cannot cast implicitly type 'tuple<bit<16>, bit<8>, bit<8>, bit<16>>' to type 'bit<48>'
          macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170): Source expression '{ meta.error_code, meta.flags, meta.ingress_port8, 16w0x0 }' produces a result of type 'tuple<bit<16>, bit<8>, bit<8>, bit<16>>' which cannot be assigned to a left-value with type 'bit<48>'
          macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170)
          macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 69084f82-e8ef-4d0b-b185-638857c5152c.p4info.txtpb /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4
/work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170): [--Werror=type-error] error: 'new_dst'
        macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170): Cannot cast implicitly type 'tuple<bit<16>, bit<8>, bit<8>, bit<16>>' to type 'bit<48>'
          macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170): Source expression '{ meta.error_code, meta.flags, meta.ingress_port8, 16w0x0 }' produces a result of type 'tuple<bit<16>, bit<8>, bit<8>, bit<16>>' which cannot be assigned to a left-value with type 'bit<48>'
          macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/69084f82-e8ef-4d0b-b185-638857c5152c.p4(170)
          macAddr_t new_dst = { meta.error_code, meta.flags, meta.ingress_port8, (bit<16>)0x0000 };
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''69084f82-e8ef-4d0b-b185-638857c5152c.p4info.txtpb'\'';config='\''69084f82-e8ef-4d0b-b185-638857c5152c.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:36:10.052  root      : CRITICAL: test-spec element standard did not match any tests
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