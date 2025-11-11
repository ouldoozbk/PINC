/work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(8): [--Wwarn=unused] warning: 'ip4Addr_t' is unused
typedef bit<32> ip4Addr_t;
                ^^^^^^^^^
/work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(87): [--Werror=type-error] error: 'p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, standard_metadata.ingress_port)'
...p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, standard...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(87): hdr.ethernet.srcAddr: argument used for directionless parameter 'src' must be a compile-time constant
          p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, sta...
                           ^^^^^^^^^^^^^^^^^^^^
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(12)
      void send(bit<32> id, bit<48> src, bit<48> dst, bit<16> svc_port, bit<9> ingress_port);
                                    ^^^
  ---- Originating from:
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(12): Function type 'send' does not match invocation type '<Method call>'
      void send(bit<32> id, bit<48> src, bit<48> dst, bit<16> svc_port, bit<9> ingress_port);
           ^^^^
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(87)
  ...p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, standard...
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files be0392c2-dc46-47cd-8166-4267109e543e.p4info.txtpb /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4
/work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(6): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(8): [--Wwarn=unused] warning: 'ip4Addr_t' is unused
typedef bit<32> ip4Addr_t;
                ^^^^^^^^^
/work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(87): [--Werror=type-error] error: 'p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, standard_metadata.ingress_port)'
...p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, standard...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(87): hdr.ethernet.srcAddr: argument used for directionless parameter 'src' must be a compile-time constant
          p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, sta...
                           ^^^^^^^^^^^^^^^^^^^^
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(12)
      void send(bit<32> id, bit<48> src, bit<48> dst, bit<16> svc_port, bit<9> ingress_port);
                                    ^^^
  ---- Originating from:
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(12): Function type 'send' does not match invocation type '<Method call>'
      void send(bit<32> id, bit<48> src, bit<48> dst, bit<16> svc_port, bit<9> ingress_port);
           ^^^^
  /work_space/be0392c2-dc46-47cd-8166-4267109e543e.p4(87)
  ...p4digest.send(1, hdr.ethernet.srcAddr, hdr.ethernet.dstAddr, hdr.custom.service_port, standard...
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''be0392c2-dc46-47cd-8166-4267109e543e.p4info.txtpb'\'';config='\''be0392c2-dc46-47cd-8166-4267109e543e.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:10:04.458  root      : CRITICAL: test-spec element standard did not match any tests
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