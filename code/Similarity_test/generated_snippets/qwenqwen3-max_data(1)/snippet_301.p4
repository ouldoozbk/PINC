Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/26c09032-e2ce-4237-a7f4-fc0b1e22fa1a.p4 ...
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
root          86  0.0  0.0      0     0 ?        Z    04:43   0:00 [simple_switch_g] <defunct>
root         222  0.0  0.0      0     0 ?        Z    04:44   0:00 [simple_switch_g] <defunct>
root         358  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         494  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         594  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         761  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         859  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         996  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1094  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1192  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1290  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1388  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1484  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1582  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1682  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1847  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1943  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2041  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2139  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2239  0.0  0.0      0     0 ?        Z    05:01   0:00 [simple_switch_g] <defunct>
root        2337  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2433  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2531  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2698  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2794  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2892  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2988  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3086  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3184  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3284  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3384  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3482  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3580  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3678  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3774  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3874  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        4041  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        4208  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4375  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4540  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4636  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4773  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4942  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        5042  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        5209  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5305  0.0  0.0      0     0 ?        Z    05:25   0:00 [simple_switch_g] <defunct>
root        5401  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5570  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5694  0.0  0.0      0     0 ?        Z    05:30   0:00 [simple_switch_g] <defunct>
root        5792  0.0  0.0      0     0 ?        Z    05:31   0:00 [simple_switch_g] <defunct>
root        5928  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        6026  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6124  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6258  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6354  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6492  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6588  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6724  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6860  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6987  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        7123  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7221  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7319  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7417  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7515  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7651  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7749  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7849  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8018  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8155  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8287  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8425  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8561  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8659  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8767  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8903  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9001  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9097  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9197  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9329  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9427  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9563  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9661  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9797  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9933  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10033  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10169  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10308  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10406  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10504  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10640  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10738  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10836  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10972  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11072  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11194  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11292  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11390  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11517  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11667  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11803  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11903  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       11999  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12166  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12302  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12402  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12498  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12650  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12817  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12985  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13083  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13185  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13350  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13448  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13546  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13682  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13782  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13882  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13980  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14078  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14214  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14316  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14471  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14569  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14667  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14812  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14910  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15006  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15145  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15270  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15368  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       15466  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15564  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15700  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15796  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15932  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16030  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16166  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       16264  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16398  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16498  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16596  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16694  0.0  0.0      0     0 ?        Z    06:04   0:00 [simple_switch_g] <defunct>
root       16828  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16993  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17091  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17258  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       17356  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17452  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       17588  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       17686  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17820  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17952  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       18050  0.0  0.0      0     0 ?        Z    06:14   0:00 [simple_switch_g] <defunct>
root       18148  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18246  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18344  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       18442  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       18540  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       18676  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18843  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18979  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       19113  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       19249  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       19385  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       19521  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       19619  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19755  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19853  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19987  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       20123  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20223  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20321  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20486  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       20636  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       20734  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       20830  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20966  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       21062  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       21198  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       21294  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       21432  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21528  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21662  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21760  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21894  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21992  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       22090  0.0  0.0      0     0 ?        Z    06:40   0:00 [simple_switch_g] <defunct>
root       22188  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       22326  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22424  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22554  0.0  0.0      0     0 ?        Z    06:45   0:00 [simple_switch_g] <defunct>
root       22690  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       22786  0.0  0.0      0     0 ?        Z    06:48   0:00 [simple_switch_g] <defunct>
root       22884  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       23020  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       23156  0.0  0.0      0     0 ?        Z    06:52   0:00 [simple_switch_g] <defunct>
root       23292  0.0  0.0      0     0 ?        Z    06:55   0:00 [simple_switch_g] <defunct>
root       23390  0.0  0.0      0     0 ?        Z    06:57   0:00 [simple_switch_g] <defunct>
root       23488  0.0  0.0      0     0 ?        Z    06:59   0:00 [simple_switch_g] <defunct>
root       23624  0.0  0.0      0     0 ?        Z    07:05   0:00 [simple_switch_g] <defunct>
root       23722  0.0  0.0      0     0 ?        Z    07:17   0:00 [simple_switch_g] <defunct>
root       23820  0.0  0.0      0     0 ?        Z    07:19   0:00 [simple_switch_g] <defunct>
root       23957  0.0  0.0      0     0 ?        Z    07:24   0:00 [simple_switch_g] <defunct>
root       24053  0.0  0.0      0     0 ?        Z    07:28   0:00 [simple_switch_g] <defunct>
root       24151  0.2  0.0      0     0 ?        Zl   07:30   0:00 [simple_switch_g] <defunct>
root       24211  0.0  0.0   3540  2148 ?        S    07:31   0:00 grep simple_switch