Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/e8a8c84f-3693-4f2e-a5d6-f347496fb5d2.p4 ...
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

The following tests failed:
Test2, Test3, Test4, Test5, Test6, Test7, Test8, Test9, Test10

The following tests errored:
Test1

******************************************

PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ...

Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ...
simple_switch_grpc terminated
root         150  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         279  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         379  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         526  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         624  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         751  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         918  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1016  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1158  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1256  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1354  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1454  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1552  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1652  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1750  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1848  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1946  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2044  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2142  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2240  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2338  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2436  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2534  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2630  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2885  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        2983  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3083  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3181  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3281  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3379  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3515  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3680  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        3780  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        3949  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4116  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4281  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4377  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4544  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4686  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        4784  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        4880  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5016  0.0  0.0      0     0 ?        Z    05:25   0:00 [simple_switch_g] <defunct>
root        5112  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5277  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5429  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5553  0.0  0.0      0     0 ?        Z    05:30   0:00 [simple_switch_g] <defunct>
root        5687  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5783  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5881  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6017  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6115  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6213  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6313  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6449  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6585  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6725  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6861  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        6959  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7059  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7228  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7364  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7502  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7662  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7829  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7964  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8099  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8237  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8375  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8511  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8682  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8818  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8916  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9083  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9219  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9353  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9451  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9618  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9716  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9854  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9974  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10072  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10168  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10264  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10431  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10527  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10625  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10792  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10892  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10988  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11124  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11260  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11429  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11563  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11701  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11870  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12004  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12138  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12274  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       12443  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       12575  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       12705  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       12841  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       12941  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13039  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13204  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13369  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13503  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13639  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13791  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13913  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14080  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14216  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14352  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14450  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14584  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       14680  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       14778  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       14912  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15077  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15213  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15349  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15447  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       15545  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       15643  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       15741  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       15877  0.0  0.0      0     0 ?        Z    06:04   0:00 [simple_switch_g] <defunct>
root       16013  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16111  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16270  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       16366  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       16464  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       16601  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       16699  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       16835  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       16937  0.0  0.0      0     0 ?        Z    06:12   0:00 [simple_switch_g] <defunct>
root       17073  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       17171  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17269  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17367  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       17465  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       17561  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       17659  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       17755  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       17891  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       17991  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18127  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       18263  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       18363  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       18461  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       18559  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       18726  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       18826  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       18962  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19060  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       19196  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19294  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19394  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       19492  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       19590  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       19726  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       19824  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       19920  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       20018  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       20154  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       20294  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       20390  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       20555  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       20702  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       20800  0.0  0.0      0     0 ?        Z    06:38   0:00 [simple_switch_g] <defunct>
root       20935  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21073  0.0  0.0      0     0 ?        Z    06:40   0:00 [simple_switch_g] <defunct>
root       21207  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       21343  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       21439  0.0  0.0      0     0 ?        Z    06:43   0:00 [simple_switch_g] <defunct>
root       21575  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       21709  0.0  0.0      0     0 ?        Z    06:48   0:00 [simple_switch_g] <defunct>
root       21843  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       21941  0.0  0.0      0     0 ?        Z    06:52   0:00 [simple_switch_g] <defunct>
root       22077  0.0  0.0      0     0 ?        Z    06:54   0:00 [simple_switch_g] <defunct>
root       22173  0.0  0.0      0     0 ?        Z    06:56   0:00 [simple_switch_g] <defunct>
root       22340  0.0  0.0      0     0 ?        Z    06:59   0:00 [simple_switch_g] <defunct>
root       22474  0.0  0.0      0     0 ?        Z    07:05   0:00 [simple_switch_g] <defunct>
root       22572  0.0  0.0      0     0 ?        Z    07:17   0:00 [simple_switch_g] <defunct>
root       22706  0.0  0.0      0     0 ?        Z    07:19   0:00 [simple_switch_g] <defunct>
root       22841  0.0  0.0      0     0 ?        Z    07:24   0:00 [simple_switch_g] <defunct>
root       22939  0.0  0.0      0     0 ?        Z    07:28   0:00 [simple_switch_g] <defunct>
root       23037  0.2  0.0      0     0 ?        Zl   07:30   0:00 [simple_switch_g] <defunct>
root       23097  0.0  0.0   3540  2236 ?        S    07:31   0:00 grep simple_switch