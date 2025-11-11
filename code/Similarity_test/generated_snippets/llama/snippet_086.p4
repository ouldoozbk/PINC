/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(6): [--Wwarn=unused] warning: 'TCP_SYN' is unused
const bit<16> TCP_SYN = 2;
              ^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(7): [--Wwarn=unused] warning: 'TCP_FIN' is unused
const bit<16> TCP_FIN = 1;
              ^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(8): [--Wwarn=unused] warning: 'TCP_RST' is unused
const bit<16> TCP_RST = 4;
              ^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(106): [--Wwarn=unused] warning: 'mac_table_value' is unused
    bit<1> mac_table_value;
    ^^^^^^^^^^^^^^^^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(193): [--Wwarn=uninitialized-use] warning: nat_table_index may be uninitialized
                            nat_table.write(nat_table_index, 0);
                                            ^^^^^^^^^^^^^^^
warning: Ingress parser exception handler not fully implemented
============ Test 1 ============
============ End Test 1 ============

============ Test 2 ============
============ End Test 2 ============

============ Test 3 ============
============ End Test 3 ============

============ Test 4 ============
============ End Test 4 ============

============ Test 5 ============
============ End Test 5 ============

============ Test 6 ============
============ End Test 6 ============

============ Test 7 ============
============ End Test 7 ============

============ Test 8 ============
============ End Test 8 ============

============ Test 9 ============
============ End Test 9 ============

============ Test 10 ============
============ End Test 10 ============

+ p4c --target bmv2 --arch v1model --p4runtime-files 6b3d22c7-01c0-451b-9352-99d00d936365.p4info.txtpb /work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(6): [--Wwarn=unused] warning: 'TCP_SYN' is unused
const bit<16> TCP_SYN = 2;
              ^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(7): [--Wwarn=unused] warning: 'TCP_FIN' is unused
const bit<16> TCP_FIN = 1;
              ^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(8): [--Wwarn=unused] warning: 'TCP_RST' is unused
const bit<16> TCP_RST = 4;
              ^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(106): [--Wwarn=unused] warning: 'mac_table_value' is unused
    bit<1> mac_table_value;
    ^^^^^^^^^^^^^^^^^^^^^^
/work_space/6b3d22c7-01c0-451b-9352-99d00d936365.p4(193): [--Wwarn=uninitialized-use] warning: nat_table_index may be uninitialized
                            nat_table.write(nat_table_index, 0);
                                            ^^^^^^^^^^^^^^^
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
+ sleep 0.1
+ for i in {1..20}
+ nc -z localhost 9559
+ echo 'simple_switch_grpc is ready'
+ break
++ which ptf
+ /usr/local/bin/ptf --pypath /root/p4c/tools/ptf -i 0@veth1 -i 1@veth3 -i 2@veth5 -i 3@veth7 -i 4@veth9 -i 5@veth11 -i 6@veth13 -i 7@veth15 '--test-params=grpcaddr='\''localhost:9559'\'';p4info='\''6b3d22c7-01c0-451b-9352-99d00d936365.p4info.txtpb'\'';config='\''6b3d22c7-01c0-451b-9352-99d00d936365.json'\''' --test-dir out-p4testgen
/usr/local/bin/ptf:19: DeprecationWarning: the imp module is deprecated in favour of importlib; see the module's documentation for alternative uses
  import imp
6b3d22c7-01c0-451b-9352-99d00d936365.Test1 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.119s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test2 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test3 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test4 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test5 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test6 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test7 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test8 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.113s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test9 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.111s

OK
6b3d22c7-01c0-451b-9352-99d00d936365.Test10 ... ok

----------------------------------------------------------------------
Ran 1 test in 0.112s

OK
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