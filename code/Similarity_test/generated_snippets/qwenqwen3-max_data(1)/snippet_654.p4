/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(174): [--Werror=type-error] error: 'meta.queue_occupancy = standard_metadata.deq_qdepth'
        meta.queue_occupancy = standard_metadata.deq_qdepth;
                             ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(174): Source expression 'standard_metadata.deq_qdepth' produces a result of type 'bit<19>' which cannot be assigned to a left-value with type 'bit<32>'
          meta.queue_occupancy = standard_metadata.deq_qdepth;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(196): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(205): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(216): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files fc59beb1-2c9e-419b-a630-7b3a0b041354.p4info.txtpb /work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(174): [--Werror=type-error] error: 'meta.queue_occupancy = standard_metadata.deq_qdepth'
        meta.queue_occupancy = standard_metadata.deq_qdepth;
                             ^
  ---- Actual error:
  Cannot cast implicitly type 'bit<19>' to type 'bit<32>'
  ---- Originating from:
  /work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(174): Source expression 'standard_metadata.deq_qdepth' produces a result of type 'bit<19>' which cannot be assigned to a left-value with type 'bit<32>'
          meta.queue_occupancy = standard_metadata.deq_qdepth;
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(196): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(205): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/fc59beb1-2c9e-419b-a630-7b3a0b041354.p4(216): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''fc59beb1-2c9e-419b-a630-7b3a0b041354.p4info.txtpb'\'';config='\''fc59beb1-2c9e-419b-a630-7b3a0b041354.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:44:48.212  root      : CRITICAL: test-spec element standard did not match any tests
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