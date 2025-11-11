/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(145): [--Werror=type-error] error: 'path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id)'
        path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<32>' with type 'bit<1>'
  ---- Originating from:
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(145): Type of argument 'stored_path_hash' (bit<32>) does not match type of parameter 'result' (bit<1>)
          path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id);
                                        ^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(145)
          path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(146): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
        meta.is_valid_path = (stored_path_hash == hdr.path_validation.path_hash) ? 1 : 0;
                                                                                   ^
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(146)
        meta.is_valid_path = (stored_path_hash == hdr.path_validation.path_hash) ? 1 : 0;
                                                                                       ^
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(150): [--Werror=type-error] error: 'path_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_hash)'
...path_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<1>'
  ---- Originating from:
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(150): Type of argument 'hdr.path_validation.path_hash' (bit<32>) does not match type of parameter 'value' (bit<1>)
  ...h_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_hash);
                                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(150)
  ...path_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_...
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files a806235a-7192-423d-937a-fdefdec77ac9.p4info.txtpb /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(145): [--Werror=type-error] error: 'path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id)'
        path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot unify type 'bit<32>' with type 'bit<1>'
  ---- Originating from:
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(145): Type of argument 'stored_path_hash' (bit<32>) does not match type of parameter 'result' (bit<1>)
          path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id);
                                        ^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(324)
      void read(out T result, in bit<32> index);
                      ^^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(324): Function type 'read' does not match invocation type '<Method call>'
      void read(out T result, in bit<32> index);
           ^^^^
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(145)
          path_validation_register.read(stored_path_hash, (bit<32>)hdr.path_validation.path_id);
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(146): [--Werror=type-error] error: Width must be specified for at least one of 1 or 0
        meta.is_valid_path = (stored_path_hash == hdr.path_validation.path_hash) ? 1 : 0;
                                                                                   ^
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(146)
        meta.is_valid_path = (stored_path_hash == hdr.path_validation.path_hash) ? 1 : 0;
                                                                                       ^
/work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(150): [--Werror=type-error] error: 'path_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_hash)'
...path_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_...
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  ---- Actual error:
  Cannot cast implicitly type 'bit<32>' to type 'bit<1>'
  ---- Originating from:
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(150): Type of argument 'hdr.path_validation.path_hash' (bit<32>) does not match type of parameter 'value' (bit<1>)
  ...h_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_hash);
                                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  /usr/local/share/p4c/p4include/v1model.p4(351)
      void write(in bit<32> index, in T value);
                                        ^^^^^
  ---- Originating from:
  /usr/local/share/p4c/p4include/v1model.p4(351): Function type 'write' does not match invocation type '<Method call>'
      void write(in bit<32> index, in T value);
           ^^^^^
  /work_space/a806235a-7192-423d-937a-fdefdec77ac9.p4(150)
  ...path_validation_register.write((bit<32>)hdr.path_validation.path_id, hdr.path_validation.path_...
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''a806235a-7192-423d-937a-fdefdec77ac9.p4info.txtpb'\'';config='\''a806235a-7192-423d-937a-fdefdec77ac9.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:12:42.359  root      : CRITICAL: test-spec element standard did not match any tests
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