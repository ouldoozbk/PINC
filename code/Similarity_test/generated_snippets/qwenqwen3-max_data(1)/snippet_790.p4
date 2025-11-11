/work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4(137): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4(178): [--Werror=type-error] error: interface_table.apply().action_run: only allowed in switch statements
        if (interface_table.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4(188): [--Werror=type-error] error: firewall_table.apply().action_run: only allowed in switch statements
            if (firewall_table.apply().action_run == drop) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 4b02b2fd-e15c-4160-9309-fab49e6af79b.p4info.txtpb /work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4
/work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4(137): [--Werror=type-error] error: '?:'
            hdr.tcp.isValid() ? hdr.tcp.dstPort :
            ^
  ---- Actual error:
  Cannot unify type 'bool' with type 'bit<16>'
  ---- Originating from:
  The expressions in a ?: conditional have different types 'bit<16>' and 'bool'
/work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4(178): [--Werror=type-error] error: interface_table.apply().action_run: only allowed in switch statements
        if (interface_table.apply().action_run == drop) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/4b02b2fd-e15c-4160-9309-fab49e6af79b.p4(188): [--Werror=type-error] error: firewall_table.apply().action_run: only allowed in switch statements
            if (firewall_table.apply().action_run == drop) {
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''4b02b2fd-e15c-4160-9309-fab49e6af79b.p4info.txtpb'\'';config='\''4b02b2fd-e15c-4160-9309-fab49e6af79b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:50:10.867  root      : CRITICAL: test-spec element standard did not match any tests
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