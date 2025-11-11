/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(82): [--Werror=type-error] error: 'queue_depth.read(standard_metadata.mcast_grp, 0)'
        queue_depth.read(standard_metadata.mcast_grp, 0);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<16>' with type 'bit<32>'
  ---- Originating from:
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(82): Type of argument 'standard_metadata.mcast_grp' (bit<16>) does not match type of parameter 'result' (bit<32>)
          queue_depth.read(standard_metadata.mcast_grp, 0);
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(82)
          queue_depth.read(standard_metadata.mcast_grp, 0);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(83): [--Werror=type-error] error: 'queue_depth.write(0, standard_metadata.mcast_grp + 1)'
        queue_depth.write(0, standard_metadata.mcast_grp + 1);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(83): Type of argument 'standard_metadata.mcast_grp + 1' (bit<16>) does not match type of parameter 'value' (bit<32>)
          queue_depth.write(0, standard_metadata.mcast_grp + 1);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(83)
          queue_depth.write(0, standard_metadata.mcast_grp + 1);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(112): [--Werror=type-error] error: Field mcast_grp is not a member of structure struct metadata
        queue_depth.read(meta.mcast_grp, 0);
                              ^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(31)
struct metadata {
       ^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(113): [--Werror=type-error] error: Field mcast_grp is not a member of structure struct metadata
        queue_depth.write(0, meta.mcast_grp - 1);
                                  ^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(31)
struct metadata {
       ^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 222454a2-3963-4b8e-83e1-510aae74a852.p4info.txtpb /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(82): [--Werror=type-error] error: 'queue_depth.read(standard_metadata.mcast_grp, 0)'
        queue_depth.read(standard_metadata.mcast_grp, 0);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<16>' with type 'bit<32>'
  ---- Originating from:
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(82): Type of argument 'standard_metadata.mcast_grp' (bit<16>) does not match type of parameter 'result' (bit<32>)
          queue_depth.read(standard_metadata.mcast_grp, 0);
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(82)
          queue_depth.read(standard_metadata.mcast_grp, 0);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(83): [--Werror=type-error] error: 'queue_depth.write(0, standard_metadata.mcast_grp + 1)'
        queue_depth.write(0, standard_metadata.mcast_grp + 1);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<16>' to type 'bit<32>'
  ---- Originating from:
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(83): Type of argument 'standard_metadata.mcast_grp + 1' (bit<16>) does not match type of parameter 'value' (bit<32>)
          queue_depth.write(0, standard_metadata.mcast_grp + 1);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(83)
          queue_depth.write(0, standard_metadata.mcast_grp + 1);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(112): [--Werror=type-error] error: Field mcast_grp is not a member of structure struct metadata
        queue_depth.read(meta.mcast_grp, 0);
                              ^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(31)
struct metadata {
       ^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(113): [--Werror=type-error] error: Field mcast_grp is not a member of structure struct metadata
        queue_depth.write(0, meta.mcast_grp - 1);
                                  ^^^^^^^^^
/work_space/222454a2-3963-4b8e-83e1-510aae74a852.p4(31)
struct metadata {
       ^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''222454a2-3963-4b8e-83e1-510aae74a852.p4info.txtpb'\'';config='\''222454a2-3963-4b8e-83e1-510aae74a852.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:23:18.631  root      : CRITICAL: test-spec element standard did not match any tests
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