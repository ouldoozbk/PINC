/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(133): [--Wwarn=unused] warning: table 'interface_action' is unused
    table interface_action {
          ^^^^^^^^^^^^^^^^
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(147): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(111): [--Werror=type-error] error: 'meta.is_ndp = hdr.icmpv6.type == (bit<8>)135 || hdr.icmpv6.type == (bit<8>)136'
        meta.is_ndp = (hdr.icmpv6.type == 135) || (hdr.icmpv6.type == 136); // NS or NA
                    ^
  ---- Actual error:
  Cannot cast implicitly type 'bool' to type 'bit<1>'
  ---- Originating from:
  /work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(111): Source expression 'hdr.icmpv6.type == (bit<8>)135 || hdr.icmpv6.type == (bit<8>)136' produces a result of type 'bool' which cannot be assigned to a left-value with type 'bit<1>'
          meta.is_ndp = (hdr.icmpv6.type == 135) || (hdr.icmpv6.type == 136); // NS or NA
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(194): [--Werror=type-error] error: hdr.ethernet.etherType == 34525 && meta.is_ndp: not defined on bool and bit<1>
        if (hdr.ethernet.etherType == ETH_P_NDP && meta.is_ndp) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files 57627cee-cad3-4919-94fa-2c6fb03dc30b.p4info.txtpb /work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(133): [--Wwarn=unused] warning: table 'interface_action' is unused
    table interface_action {
          ^^^^^^^^^^^^^^^^
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(147): [--Wwarn=unused] warning: table 'firewall_table' is unused
    table firewall_table {
          ^^^^^^^^^^^^^^
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(111): [--Werror=type-error] error: 'meta.is_ndp = hdr.icmpv6.type == (bit<8>)135 || hdr.icmpv6.type == (bit<8>)136'
        meta.is_ndp = (hdr.icmpv6.type == 135) || (hdr.icmpv6.type == 136); // NS or NA
                    ^
  ---- Actual error:
  Cannot cast implicitly type 'bool' to type 'bit<1>'
  ---- Originating from:
  /work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(111): Source expression 'hdr.icmpv6.type == (bit<8>)135 || hdr.icmpv6.type == (bit<8>)136' produces a result of type 'bool' which cannot be assigned to a left-value with type 'bit<1>'
          meta.is_ndp = (hdr.icmpv6.type == 135) || (hdr.icmpv6.type == 136); // NS or NA
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
/work_space/57627cee-cad3-4919-94fa-2c6fb03dc30b.p4(194): [--Werror=type-error] error: hdr.ethernet.etherType == 34525 && meta.is_ndp: not defined on bool and bit<1>
        if (hdr.ethernet.etherType == ETH_P_NDP && meta.is_ndp) {
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''57627cee-cad3-4919-94fa-2c6fb03dc30b.p4info.txtpb'\'';config='\''57627cee-cad3-4919-94fa-2c6fb03dc30b.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
07:41:07.380  root      : CRITICAL: test-spec element standard did not match any tests
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