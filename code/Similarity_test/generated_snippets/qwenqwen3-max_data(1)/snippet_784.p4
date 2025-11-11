/work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(124): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(138): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(157): [--Werror=type-error] error: 'hash(HashAlgorithm.crc32, 32w0, hash_input, 32w0, 32w0)'
        bit<32> hash_result = hash<bit<32>>(HashAlgorithm.crc32, (bit<32>)0, hash_input, (bit<32>...
                              ^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(157): : Read-only value used for out/inout parameter 'result'
  ...  bit<32> hash_result = hash<bit<32>>(HashAlgorithm.crc32, (bit<32>)0, hash_input, (bit<32>)0,...
                                           ^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(444)
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
                                     ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(444): Function type 'hash' does not match invocation type '<Method call>'
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
              ^^^^
  /work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(157)
          bit<32> hash_result = hash<bit<32>>(HashAlgorithm.crc32, (bit<32>)0, hash_input, (bit<32>...
                                ^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 068a87ca-3e65-46aa-8549-d86f84232242.p4info.txtpb /work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4
/work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(124): [--Wwarn=unused] warning: table 'interface_table' is unused
    table interface_table {
          ^^^^^^^^^^^^^^^
/work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(138): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(157): [--Werror=type-error] error: 'hash(HashAlgorithm.crc32, 32w0, hash_input, 32w0, 32w0)'
        bit<32> hash_result = hash<bit<32>>(HashAlgorithm.crc32, (bit<32>)0, hash_input, (bit<32>...
                              ^^^^^^^^^^^^^
  ---- Actual error:
  /work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(157): : Read-only value used for out/inout parameter 'result'
  ...  bit<32> hash_result = hash<bit<32>>(HashAlgorithm.crc32, (bit<32>)0, hash_input, (bit<32>)0,...
                                           ^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(444)
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
                                     ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(444): Function type 'hash' does not match invocation type '<Method call>'
  extern void hash<O, T, D, M>(out O result, in HashAlgorithm algo, in T base, in D data, in M max);
              ^^^^
  /work_space/068a87ca-3e65-46aa-8549-d86f84232242.p4(157)
          bit<32> hash_result = hash<bit<32>>(HashAlgorithm.crc32, (bit<32>)0, hash_input, (bit<32>...
                                ^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''068a87ca-3e65-46aa-8549-d86f84232242.p4info.txtpb'\'';config='\''068a87ca-3e65-46aa-8549-d86f84232242.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:50:10.857  root      : CRITICAL: test-spec element standard did not match any tests
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