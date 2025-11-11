/work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174): [--Werror=type-error] error: 'digest(1, { hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort })'
        digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174): Cannot cast implicitly type 'tuple<bit<32>, bit<32>, bit<16>, bit<16>>' to type 'bit<32>'
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174): Type of argument '{ hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort }' (tuple<bit<32>, bit<32>, bit<16>, bit<16>>) does not match type of parameter 'data' (T)
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174)
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(392)
  extern void digest<T>(in bit<32> receiver, in T data);
                                                  ^^^^
  /usr/local/share/p4c/p4include/v1model.p4(392)
  extern void digest<T>(in bit<32> receiver, in T data);
                     ^
  Where 'T' is bound to 'bit<32>'
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(392): Function type 'digest' does not match invocation type '<Method call>'
  extern void digest<T>(in bit<32> receiver, in T data);
              ^^^^^^
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174)
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 7dfc36a4-07d0-499f-a87f-98d4f649da58.p4info.txtpb /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4
/work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174): [--Werror=type-error] error: 'digest(1, { hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort })'
        digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174): Cannot cast implicitly type 'tuple<bit<32>, bit<32>, bit<16>, bit<16>>' to type 'bit<32>'
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174): Type of argument '{ hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort }' (tuple<bit<32>, bit<32>, bit<16>, bit<16>>) does not match type of parameter 'data' (T)
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174)
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(392)
  extern void digest<T>(in bit<32> receiver, in T data);
                                                  ^^^^
  /usr/local/share/p4c/p4include/v1model.p4(392)
  extern void digest<T>(in bit<32> receiver, in T data);
                     ^
  Where 'T' is bound to 'bit<32>'
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(392): Function type 'digest' does not match invocation type '<Method call>'
  extern void digest<T>(in bit<32> receiver, in T data);
              ^^^^^^
  /work_space/7dfc36a4-07d0-499f-a87f-98d4f649da58.p4(174)
          digest<bit<32>>(1, {hdr.ipv4.srcAddr, hdr.ipv4.dstAddr, hdr.tcp.srcPort, hdr.tcp.dstPort});
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''7dfc36a4-07d0-499f-a87f-98d4f649da58.p4info.txtpb'\'';config='\''7dfc36a4-07d0-499f-a87f-98d4f649da58.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:15:23.722  root      : CRITICAL: test-spec element standard did not match any tests
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