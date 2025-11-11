Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/0ae31724-31cb-4b4a-bcab-4fe10564c5cf.p4 ...
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
root          86  0.0  0.0      0     0 ?        Z    04:44   0:00 [simple_switch_g] <defunct>
root         222  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         320  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         469  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         569  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         669  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         765  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         863  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         959  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1126  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1224  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1320  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1418  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1516  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1612  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1710  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1875  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1973  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2069  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2167  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2299  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2434  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2530  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2628  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2726  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2822  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2920  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3018  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3116  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3283  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3450  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3548  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3648  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3746  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3915  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        4080  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        4178  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4347  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4514  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4610  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4710  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4808  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4975  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        5142  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5278  0.0  0.0      0     0 ?        Z    05:25   0:00 [simple_switch_g] <defunct>
root        5393  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5542  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5640  0.0  0.0      0     0 ?        Z    05:29   0:00 [simple_switch_g] <defunct>
root        5738  0.0  0.0      0     0 ?        Z    05:31   0:00 [simple_switch_g] <defunct>
root        5874  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5972  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6070  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6206  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6302  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6402  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6500  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6600  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6698  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6796  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6894  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        7016  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        7152  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7250  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7386  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7518  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7618  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7756  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7921  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8057  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8193  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8329  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8427  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8594  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8736  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8832  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8954  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9088  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9186  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9353  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9489  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9634  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9734  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9832  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9966  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10064  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10203  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10299  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10464  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10629  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10779  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10946  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11044  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11140  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11238  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11378  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11512  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11610  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11708  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11844  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12011  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12138  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12305  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12401  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12499  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12597  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12695  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12793  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12963  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13099  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13235  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13373  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13509  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13605  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13739  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13871  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13969  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14065  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14201  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14370  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14468  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14568  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14666  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14816  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14914  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15010  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15144  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15274  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15372  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       15537  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15673  0.0  0.0      0     0 ?        Z    05:59   0:00 [simple_switch_g] <defunct>
root       15771  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15938  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16034  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16201  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16335  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16469  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16603  0.0  0.0      0     0 ?        Z    06:05   0:00 [simple_switch_g] <defunct>
root       16737  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16902  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       17000  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17098  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17233  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       17369  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17503  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17603  0.0  0.0      0     0 ?        Z    06:12   0:00 [simple_switch_g] <defunct>
root       17701  0.0  0.0      0     0 ?        Z    06:14   0:00 [simple_switch_g] <defunct>
root       17799  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17897  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17993  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       18129  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       18225  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       18361  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18459  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18624  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18722  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18818  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18954  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       19052  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       19223  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       19359  0.0  0.0      0     0 ?        Z    06:24   0:00 [simple_switch_g] <defunct>
root       19495  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19629  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       19761  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19857  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19957  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20057  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20155  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       20289  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       20387  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20487  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20587  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       20685  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       20823  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       20959  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       21124  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       21222  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21318  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21416  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21548  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21646  0.0  0.0      0     0 ?        Z    06:38   0:00 [simple_switch_g] <defunct>
root       21744  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21842  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21978  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       22078  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       22230  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22366  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22462  0.0  0.0      0     0 ?        Z    06:43   0:00 [simple_switch_g] <defunct>
root       22558  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       22723  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       22859  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       22957  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       23124  0.0  0.0      0     0 ?        Z    06:52   0:00 [simple_switch_g] <defunct>
root       23222  0.0  0.0      0     0 ?        Z    06:54   0:00 [simple_switch_g] <defunct>
root       23318  0.0  0.0      0     0 ?        Z    06:56   0:00 [simple_switch_g] <defunct>
root       23485  0.0  0.0      0     0 ?        Z    06:59   0:00 [simple_switch_g] <defunct>
root       23583  0.0  0.0      0     0 ?        Z    07:03   0:00 [simple_switch_g] <defunct>
root       23681  0.0  0.0      0     0 ?        Z    07:11   0:00 [simple_switch_g] <defunct>
root       23779  0.0  0.0      0     0 ?        Z    07:19   0:00 [simple_switch_g] <defunct>
root       23906  0.0  0.0      0     0 ?        Z    07:21   0:00 [simple_switch_g] <defunct>
root       24004  0.0  0.0      0     0 ?        Z    07:25   0:00 [simple_switch_g] <defunct>
root       24100  0.0  0.0      0     0 ?        Z    07:30   0:00 [simple_switch_g] <defunct>
root       24198  0.1  0.0      0     0 ?        Zl   07:32   0:00 [simple_switch_g] <defunct>
root       24258  0.0  0.0   3540  1996 ?        S    07:33   0:00 grep simple_switch