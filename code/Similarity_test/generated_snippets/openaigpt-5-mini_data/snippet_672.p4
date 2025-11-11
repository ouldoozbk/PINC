/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(5): [--Wwarn=unused] warning: 'ERROR_BITS_WIDTH' is unused
const bit<8> ERROR_BITS_WIDTH = 8;
             ^^^^^^^^^^^^^^^^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(123): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> dst_zero = (dst == (bit<48>)0) ? 1 : 0;
                                                    ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(123)
            bit<1> dst_zero = (dst == (bit<48>)0) ? 1 : 0;
                                                        ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(124): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> src_zero = (src == (bit<48>)0) ? 1 : 0;
                                                    ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(124)
            bit<1> src_zero = (src == (bit<48>)0) ? 1 : 0;
                                                        ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(125): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> dst_broadcast = (dst == (bit<48>)0xffffffffffff) ? 1 : 0;
                                                                      ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(125)
            bit<1> dst_broadcast = (dst == (bit<48>)0xffffffffffff) ? 1 : 0;
                                                                          ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(126): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> ether_not_ipv4 = (hdr.ethernet.etherType != TYPE_IPV4) ? 1 : 0;
                                                                            ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(126)
            bit<1> ether_not_ipv4 = (hdr.ethernet.etherType != TYPE_IPV4) ? 1 : 0;
                                                                                ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(128): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> ingress_port_drop = (standard_metadata.ingress_port == 2) ? 1 : 0;
                                                                               ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(128)
            bit<1> ingress_port_drop = (standard_metadata.ingress_port == 2) ? 1 : 0;
                                                                                   ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149): [--Werror=type-error] error: 'hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] }'
            hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                 ^
  ---- Actual error:
  /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149): Cannot cast implicitly type 'tuple<bit<8>, bit<40>>' to type 'bit<48>'
              hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149): Source expression '{ meta.error_bits, hdr.ethernet.dstAddr[39:0] }' produces a result of type 'tuple<bit<8>, bit<40>>' which cannot be assigned to a left-value with type 'bit<48>'
              hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149)
              hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 194785c6-46dd-43d3-b401-2cfad5e1f85b.p4info.txtpb /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(5): [--Wwarn=unused] warning: 'ERROR_BITS_WIDTH' is unused
const bit<8> ERROR_BITS_WIDTH = 8;
             ^^^^^^^^^^^^^^^^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(7): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(123): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> dst_zero = (dst == (bit<48>)0) ? 1 : 0;
                                                    ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(123)
            bit<1> dst_zero = (dst == (bit<48>)0) ? 1 : 0;
                                                        ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(124): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> src_zero = (src == (bit<48>)0) ? 1 : 0;
                                                    ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(124)
            bit<1> src_zero = (src == (bit<48>)0) ? 1 : 0;
                                                        ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(125): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> dst_broadcast = (dst == (bit<48>)0xffffffffffff) ? 1 : 0;
                                                                      ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(125)
            bit<1> dst_broadcast = (dst == (bit<48>)0xffffffffffff) ? 1 : 0;
                                                                          ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(126): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> ether_not_ipv4 = (hdr.ethernet.etherType != TYPE_IPV4) ? 1 : 0;
                                                                            ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(126)
            bit<1> ether_not_ipv4 = (hdr.ethernet.etherType != TYPE_IPV4) ? 1 : 0;
                                                                                ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(128): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
            bit<1> ingress_port_drop = (standard_metadata.ingress_port == 2) ? 1 : 0;
                                                                               ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(128)
            bit<1> ingress_port_drop = (standard_metadata.ingress_port == 2) ? 1 : 0;
                                                                                   ^
/work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149): [--Werror=type-error] error: 'hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] }'
            hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                 ^
  ---- Actual error:
  /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149): Cannot cast implicitly type 'tuple<bit<8>, bit<40>>' to type 'bit<48>'
              hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Originating from:
  /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149): Source expression '{ meta.error_bits, hdr.ethernet.dstAddr[39:0] }' produces a result of type 'tuple<bit<8>, bit<40>>' which cannot be assigned to a left-value with type 'bit<48>'
              hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /work_space/194785c6-46dd-43d3-b401-2cfad5e1f85b.p4(149)
              hdr.ethernet.dstAddr = { meta.error_bits, hdr.ethernet.dstAddr[39:0] };
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''194785c6-46dd-43d3-b401-2cfad5e1f85b.p4info.txtpb'\'';config='\''194785c6-46dd-43d3-b401-2cfad5e1f85b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
21:37:51.871  root      : CRITICAL: test-spec element standard did not match any tests
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