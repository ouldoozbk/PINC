/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(10): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(119): [--Wwarn=unused] warning: 'CPU_PORT' is unused
    const bit<32> CPU_PORT = 255;
                  ^^^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(182): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
            clone3(CloneType.I2E, MIRROR_SESSION_ID, standard_metadata);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(193): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(205): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4info.txtpb /work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(10): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(119): [--Wwarn=unused] warning: 'CPU_PORT' is unused
    const bit<32> CPU_PORT = 255;
                  ^^^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(182): [--Wwarn=deprecated] warning: clone3: Using deprecated feature clone3. Please use 'clone_preserving_field_list' instead
            clone3(CloneType.I2E, MIRROR_SESSION_ID, standard_metadata);
            ^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(604)
extern void clone3<T>(in CloneType type, in bit<32> session, in T data);
            ^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(193): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4(205): [--Werror=type-error] error: Field drop is not a member of structure struct standard_metadata
        if (standard_metadata.drop) {
                              ^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
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
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.p4info.txtpb'\'';config='\''ccc68f6d-bbe2-461c-9c5f-1fbdcbaa6134.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:30:09.590  root      : CRITICAL: test-spec element standard did not match any tests
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