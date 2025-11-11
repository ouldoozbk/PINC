/work_space/a0b039d0-19ba-4003-a8d0-5addbcf2af41.p4(83): [--Werror=type-error] error: hdr.tcpOptions: argument should contain a varbit field
        packet.extract(hdr.tcpOptions, meta.tcpOptionsLen);
                       ^^^^^^^^^^^^^^
+ p4c --target bmv2 --arch v1model --p4runtime-files a0b039d0-19ba-4003-a8d0-5addbcf2af41.p4info.txtpb /work_space/a0b039d0-19ba-4003-a8d0-5addbcf2af41.p4
/work_space/a0b039d0-19ba-4003-a8d0-5addbcf2af41.p4(83): [--Werror=type-error] error: hdr.tcpOptions: argument should contain a varbit field
        packet.extract(hdr.tcpOptions, meta.tcpOptionsLen);
                       ^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''a0b039d0-19ba-4003-a8d0-5addbcf2af41.p4info.txtpb'\'';config='\''a0b039d0-19ba-4003-a8d0-5addbcf2af41.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
05:27:35.978  root      : CRITICAL: test-spec element standard did not match any tests
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