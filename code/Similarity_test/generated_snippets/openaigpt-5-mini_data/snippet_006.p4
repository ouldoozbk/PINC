/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(114): [--Werror=type-error] error: 'meta.outer_csum_ok = verify_checksum(hdr.ipv4.isValid(), { hdr.ipv4.version, hdr.ipv4.ihl, hdr.ipv4.diffserv, hdr.ipv4.totalLen, hdr.ipv4.identification, hdr.ipv4.flags, hdr.ipv4.fragOffset, hdr.ipv4.ttl, hdr.ipv4.protocol, hdr.ipv4.srcAddr, hdr.ipv4.dstAddr }, hdr.ipv4.hdrChecksum, HashAlgorithm.csum16)'
            meta.outer_csum_ok = verify_checksum(
                               ^
  ---- Actual error:
  /usr/local/share/p4c/p4include/v1model.p4(483): Cannot cast implicitly type 'void' to type 'bool'
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(54)
      bool outer_csum_ok;
      ^^^^
  ---- Originating from:
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(114): Source expression 'verify_checksum(hdr.ipv4.isValid(), { hdr.ipv4.version, hdr.ipv4.ihl, hdr.ipv4.diffserv, hdr.ipv4.totalLen, hdr.ipv4.identification, hdr.ipv4.flags, hdr.ipv4.fragOffset, hdr.ipv4.ttl, hdr.ipv4.protocol, hdr.ipv4.srcAddr, hdr.ipv4.dstAddr }, hdr.ipv4.hdrChecksum, HashAlgorithm.csum16)' produces a result of type 'void' which cannot be assigned to a left-value with type 'bool'
              meta.outer_csum_ok = verify_checksum(
                                   ^
  /usr/local/share/p4c/p4include/v1model.p4(483)
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(54)
      bool outer_csum_ok;
      ^^^^
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(133): [--Werror=type-error] error: 'meta.inner_csum_ok = verify_checksum(hdr.inner_ipv4.isValid(), { hdr.inner_ipv4.version, hdr.inner_ipv4.ihl, hdr.inner_ipv4.diffserv, hdr.inner_ipv4.totalLen, hdr.inner_ipv4.identification, hdr.inner_ipv4.flags, hdr.inner_ipv4.fragOffset, hdr.inner_ipv4.ttl, hdr.inner_ipv4.protocol, hdr.inner_ipv4.srcAddr, hdr.inner_ipv4.dstAddr }, hdr.inner_ipv4.hdrChecksum, HashAlgorithm.csum16)'
            meta.inner_csum_ok = verify_checksum(
                               ^
  ---- Actual error:
  /usr/local/share/p4c/p4include/v1model.p4(483): Cannot cast implicitly type 'void' to type 'bool'
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(55)
      bool inner_csum_ok;
      ^^^^
  ---- Originating from:
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(133): Source expression 'verify_checksum(hdr.inner_ipv4.isValid(), { hdr.inner_ipv4.version, hdr.inner_ipv4.ihl, hdr.inner_ipv4.diffserv, hdr.inner_ipv4.totalLen, hdr.inner_ipv4.identification, hdr.inner_ipv4.flags, hdr.inner_ipv4.fragOffset, hdr.inner_ipv4.ttl, hdr.inner_ipv4.protocol, hdr.inner_ipv4.srcAddr, hdr.inner_ipv4.dstAddr }, hdr.inner_ipv4.hdrChecksum, HashAlgorithm.csum16)' produces a result of type 'void' which cannot be assigned to a left-value with type 'bool'
              meta.inner_csum_ok = verify_checksum(
                                   ^
  /usr/local/share/p4c/p4include/v1model.p4(483)
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(55)
      bool inner_csum_ok;
      ^^^^
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(231): [--Werror=type-error] error: firewall_outer_tcp.apply().action_run: only allowed in switch statements
                if (firewall_outer_tcp.apply().action_run == 0) {}
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(236): [--Werror=type-error] error: firewall_inner_tcp.apply().action_run: only allowed in switch statements
                if (firewall_inner_tcp.apply().action_run == 0) {}
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4info.txtpb /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(114): [--Werror=type-error] error: 'meta.outer_csum_ok = verify_checksum(hdr.ipv4.isValid(), { hdr.ipv4.version, hdr.ipv4.ihl, hdr.ipv4.diffserv, hdr.ipv4.totalLen, hdr.ipv4.identification, hdr.ipv4.flags, hdr.ipv4.fragOffset, hdr.ipv4.ttl, hdr.ipv4.protocol, hdr.ipv4.srcAddr, hdr.ipv4.dstAddr }, hdr.ipv4.hdrChecksum, HashAlgorithm.csum16)'
            meta.outer_csum_ok = verify_checksum(
                               ^
  ---- Actual error:
  /usr/local/share/p4c/p4include/v1model.p4(483): Cannot cast implicitly type 'void' to type 'bool'
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(54)
      bool outer_csum_ok;
      ^^^^
  ---- Originating from:
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(114): Source expression 'verify_checksum(hdr.ipv4.isValid(), { hdr.ipv4.version, hdr.ipv4.ihl, hdr.ipv4.diffserv, hdr.ipv4.totalLen, hdr.ipv4.identification, hdr.ipv4.flags, hdr.ipv4.fragOffset, hdr.ipv4.ttl, hdr.ipv4.protocol, hdr.ipv4.srcAddr, hdr.ipv4.dstAddr }, hdr.ipv4.hdrChecksum, HashAlgorithm.csum16)' produces a result of type 'void' which cannot be assigned to a left-value with type 'bool'
              meta.outer_csum_ok = verify_checksum(
                                   ^
  /usr/local/share/p4c/p4include/v1model.p4(483)
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(54)
      bool outer_csum_ok;
      ^^^^
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(133): [--Werror=type-error] error: 'meta.inner_csum_ok = verify_checksum(hdr.inner_ipv4.isValid(), { hdr.inner_ipv4.version, hdr.inner_ipv4.ihl, hdr.inner_ipv4.diffserv, hdr.inner_ipv4.totalLen, hdr.inner_ipv4.identification, hdr.inner_ipv4.flags, hdr.inner_ipv4.fragOffset, hdr.inner_ipv4.ttl, hdr.inner_ipv4.protocol, hdr.inner_ipv4.srcAddr, hdr.inner_ipv4.dstAddr }, hdr.inner_ipv4.hdrChecksum, HashAlgorithm.csum16)'
            meta.inner_csum_ok = verify_checksum(
                               ^
  ---- Actual error:
  /usr/local/share/p4c/p4include/v1model.p4(483): Cannot cast implicitly type 'void' to type 'bool'
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(55)
      bool inner_csum_ok;
      ^^^^
  ---- Originating from:
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(133): Source expression 'verify_checksum(hdr.inner_ipv4.isValid(), { hdr.inner_ipv4.version, hdr.inner_ipv4.ihl, hdr.inner_ipv4.diffserv, hdr.inner_ipv4.totalLen, hdr.inner_ipv4.identification, hdr.inner_ipv4.flags, hdr.inner_ipv4.fragOffset, hdr.inner_ipv4.ttl, hdr.inner_ipv4.protocol, hdr.inner_ipv4.srcAddr, hdr.inner_ipv4.dstAddr }, hdr.inner_ipv4.hdrChecksum, HashAlgorithm.csum16)' produces a result of type 'void' which cannot be assigned to a left-value with type 'bool'
              meta.inner_csum_ok = verify_checksum(
                                   ^
  /usr/local/share/p4c/p4include/v1model.p4(483)
  extern void verify_checksum<T, O>(in bool condition, in T data, in O checksum, HashAlgorithm algo);
         ^^^^
  /work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(55)
      bool inner_csum_ok;
      ^^^^
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(231): [--Werror=type-error] error: firewall_outer_tcp.apply().action_run: only allowed in switch statements
                if (firewall_outer_tcp.apply().action_run == 0) {}
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4(236): [--Werror=type-error] error: firewall_inner_tcp.apply().action_run: only allowed in switch statements
                if (firewall_inner_tcp.apply().action_run == 0) {}
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''c4bd3d71-ad42-401b-8dc4-3fee595f0609.p4info.txtpb'\'';config='\''c4bd3d71-ad42-401b-8dc4-3fee595f0609.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:06:56.934  root      : CRITICAL: test-spec element standard did not match any tests
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