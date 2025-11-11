/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(4): [--Wwarn=unused] warning: 'TYPE_IPV4' is unused
const bit<16> TYPE_IPV4 = 0x800;
              ^^^^^^^^^
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(8): [--Wwarn=unused] warning: 'ip4Addr_t' is unused
typedef bit<32> ip4Addr_t;
                ^^^^^^^^^
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(68): [--Wwarn=unused] warning: table 'interface_config' is unused
    table interface_config {
          ^^^^^^^^^^^^^^^^
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(81): [--Werror=type-error] error: 'conditional'
            bit<1> conditional = (bit<32>)standard_metadata.ingress_port & 1;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<1>'
  ---- Originating from:
  /work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(81): Source expression '(bit<32>)standard_metadata.ingress_port & 1' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<1>'
              bit<1> conditional = (bit<32>)standard_metadata.ingress_port & 1;
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4info.txtpb /work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(4): [--Wwarn=unused] warning: 'TYPE_IPV4' is unused
const bit<16> TYPE_IPV4 = 0x800;
              ^^^^^^^^^
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(8): [--Wwarn=unused] warning: 'ip4Addr_t' is unused
typedef bit<32> ip4Addr_t;
                ^^^^^^^^^
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(68): [--Wwarn=unused] warning: table 'interface_config' is unused
    table interface_config {
          ^^^^^^^^^^^^^^^^
/work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(81): [--Werror=type-error] error: 'conditional'
            bit<1> conditional = (bit<32>)standard_metadata.ingress_port & 1;
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<1>'
  ---- Originating from:
  /work_space/aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4(81): Source expression '(bit<32>)standard_metadata.ingress_port & 1' produces a result of type 'bit<32>' which cannot be assigned to a left-value with type 'bit<1>'
              bit<1> conditional = (bit<32>)standard_metadata.ingress_port & 1;
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ /bin/rm -f ss-log.txt
+ echo ''
+ echo 'Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...'
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''aba6ff0f-0a69-48f8-9c6e-422423dbde2a.p4info.txtpb'\'';config='\''aba6ff0f-0a69-48f8-9c6e-422423dbde2a.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:20:54.275  root      : CRITICAL: test-spec element standard did not match any tests
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