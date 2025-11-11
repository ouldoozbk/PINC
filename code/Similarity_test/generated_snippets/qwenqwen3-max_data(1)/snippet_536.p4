/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(13): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(169): [--Wwarn=unused] warning: 'current_time' is unused
        bit<32> current_time = (bit<32>) standard_metadata.ingress_global_timestamp;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(185): [--Wwarn=unused] warning: 'codel_dequeue' is unused
    action codel_dequeue() {
           ^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(186): [--Wwarn=unused] warning: 'current_time' is unused
        bit<32> current_time = (bit<32>) standard_metadata.ingress_global_timestamp;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(170): [--Werror=type-error] error: 'port'
        bit<32> port = standard_metadata.egress_spec;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<9>' to type 'bit<32>'
  ---- Originating from:
  /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(170): Source expression 'standard_metadata.egress_spec' produces a result of type 'bit<9>' which cannot be assigned to a left-value with type 'bit<32>'
          bit<32> port = standard_metadata.egress_spec;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(187): [--Werror=type-error] error: 'port'
        bit<32> port = standard_metadata.egress_spec;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<9>' to type 'bit<32>'
  ---- Originating from:
  /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(187): Source expression 'standard_metadata.egress_spec' produces a result of type 'bit<9>' which cannot be assigned to a left-value with type 'bit<32>'
          bit<32> port = standard_metadata.egress_spec;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(201): [--Werror=type-error] error: 'port'
        bit<32> port = standard_metadata.egress_spec;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<9>' to type 'bit<32>'
  ---- Originating from:
  /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(201): Source expression 'standard_metadata.egress_spec' produces a result of type 'bit<9>' which cannot be assigned to a left-value with type 'bit<32>'
          bit<32> port = standard_metadata.egress_spec;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(248): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(257): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(263): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (!standard_metadata.marked_for_drop) {
                               ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(274): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (!standard_metadata.marked_for_drop) {
                               ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4info.txtpb /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(13): [--Wwarn=unused] warning: 'egressSpec_t' is unused
typedef bit<9> egressSpec_t;
               ^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(169): [--Wwarn=unused] warning: 'current_time' is unused
        bit<32> current_time = (bit<32>) standard_metadata.ingress_global_timestamp;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(185): [--Wwarn=unused] warning: 'codel_dequeue' is unused
    action codel_dequeue() {
           ^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(186): [--Wwarn=unused] warning: 'current_time' is unused
        bit<32> current_time = (bit<32>) standard_metadata.ingress_global_timestamp;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(170): [--Werror=type-error] error: 'port'
        bit<32> port = standard_metadata.egress_spec;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<9>' to type 'bit<32>'
  ---- Originating from:
  /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(170): Source expression 'standard_metadata.egress_spec' produces a result of type 'bit<9>' which cannot be assigned to a left-value with type 'bit<32>'
          bit<32> port = standard_metadata.egress_spec;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(187): [--Werror=type-error] error: 'port'
        bit<32> port = standard_metadata.egress_spec;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<9>' to type 'bit<32>'
  ---- Originating from:
  /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(187): Source expression 'standard_metadata.egress_spec' produces a result of type 'bit<9>' which cannot be assigned to a left-value with type 'bit<32>'
          bit<32> port = standard_metadata.egress_spec;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(201): [--Werror=type-error] error: 'port'
        bit<32> port = standard_metadata.egress_spec;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<9>' to type 'bit<32>'
  ---- Originating from:
  /work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(201): Source expression 'standard_metadata.egress_spec' produces a result of type 'bit<9>' which cannot be assigned to a left-value with type 'bit<32>'
          bit<32> port = standard_metadata.egress_spec;
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(248): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(257): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (standard_metadata.marked_for_drop) {
                              ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(263): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (!standard_metadata.marked_for_drop) {
                               ^^^^^^^^^^^^^^^
/usr/local/share/p4c/p4include/v1model.p4(64)
struct standard_metadata_t {
       ^^^^^^^^^^^^^^^^^^^
/work_space/4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4(274): [--Werror=type-error] error: Field marked_for_drop is not a member of structure struct standard_metadata
        if (!standard_metadata.marked_for_drop) {
                               ^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''4a54bba9-6de5-4d0a-be64-e3cf18eb734c.p4info.txtpb'\'';config='\''4a54bba9-6de5-4d0a-be64-e3cf18eb734c.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:39:40.225  root      : CRITICAL: test-spec element standard did not match any tests
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