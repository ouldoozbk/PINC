Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/ee128941-a464-40af-a7ee-ea684df2662e.p4 ...
Test cases generated in: out-p4testgen

Started simple_switch_grpc.  Waiting 2 seconds before starting PTF test ...
Calling target program-options parser
Adding interface veth0 as port 0
Adding interface veth2 as port 1
Adding interface veth4 as port 2
Adding interface veth6 as port 3
Adding interface veth8 as port 4
Adding interface veth10 as port 5
Adding interface veth12 as port 6
Adding interface veth14 as port 7
simple_switch_grpc is ready

******************************************
ATTENTION: SOME TESTS DID NOT PASS!!!

The following tests errored:
Test2, Test4

******************************************

PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ...

Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ...
simple_switch_grpc terminated
root         214  0.0  0.0      0     0 ?        Z    04:46   0:00 [simple_switch_g] <defunct>
root         336  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         436  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         603  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         699  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         795  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         893  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         991  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1089  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1185  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1283  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1379  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1477  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1575  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1742  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1838  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1934  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2032  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2197  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2293  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2391  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2489  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2587  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2683  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2779  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        2875  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        2973  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3071  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3169  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3267  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3434  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3530  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3643  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3741  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        3908  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        4006  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4175  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4342  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4438  0.1  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4580  3.5  0.0      0     0 ?        Zl   05:21   0:00 [simple_switch_g] <defunct>
root        4675  0.0  0.0   3540  1992 ?        S    05:21   0:00 grep simple_switch