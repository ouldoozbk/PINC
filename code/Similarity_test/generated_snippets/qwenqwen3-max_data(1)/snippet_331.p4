Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/b8ccfb00-6808-4d23-9b6e-8febd7b96e20.p4 ...
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
root         389  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         523  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         692  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         788  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         884  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1018  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1116  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1252  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1348  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1446  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1542  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1642  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1742  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1840  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1940  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2038  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2136  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2234  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2330  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2428  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2526  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2624  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2760  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        2858  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        2954  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3091  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3256  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3352  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3450  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3615  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3713  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        3882  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        3982  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4120  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4285  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4383  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4510  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4652  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        4819  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        4986  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5151  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5318  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5455  0.0  0.0      0     0 ?        Z    05:30   0:00 [simple_switch_g] <defunct>
root        5553  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5649  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5745  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        5881  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        5979  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6077  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6173  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6309  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6407  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6507  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6643  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        6812  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        6979  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7077  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7213  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7311  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7475  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7611  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7747  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        7845  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        7977  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8129  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8265  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8434  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8574  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8694  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8828  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        8926  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9026  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9122  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9220  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9318  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9416  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9514  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9650  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9748  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9846  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9944  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10078  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10247  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10343  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10479  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10577  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10677  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10775  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       10873  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11040  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11176  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11274  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11374  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11472  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11641  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11739  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11861  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12030  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12166  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12302  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12438  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       12574  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       12712  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       12810  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       12908  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13044  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13209  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13307  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       13443  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       13579  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       13744  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       13842  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       13940  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       14077  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       14211  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       14309  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       14407  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       14505  0.0  0.0      0     0 ?        Z    05:59   0:00 [simple_switch_g] <defunct>
root       14603  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       14703  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       14865  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       14963  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       15105  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       15239  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       15375  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       15473  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       15640  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       15736  0.0  0.0      0     0 ?        Z    06:04   0:00 [simple_switch_g] <defunct>
root       15872  0.0  0.0      0     0 ?        Z    06:05   0:00 [simple_switch_g] <defunct>
root       16006  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16142  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16307  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       16405  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       16501  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       16668  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       16764  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       16862  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       16962  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17098  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       17265  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17361  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17497  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       17595  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       17731  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       17867  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18003  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18101  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18237  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       18335  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       18473  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       18571  0.0  0.0      0     0 ?        Z    06:24   0:00 [simple_switch_g] <defunct>
root       18707  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       18805  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       18941  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       19077  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19215  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       19360  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       19458  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       19556  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       19685  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       19781  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       19919  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       20017  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       20119  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       20255  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       20353  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       20451  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       20549  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       20647  0.0  0.0      0     0 ?        Z    06:38   0:00 [simple_switch_g] <defunct>
root       20781  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       20879  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21046  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       21182  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       21345  0.0  0.0      0     0 ?        Z    06:43   0:00 [simple_switch_g] <defunct>
root       21443  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       21541  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       21677  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       21775  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       21942  0.0  0.0      0     0 ?        Z    06:52   0:00 [simple_switch_g] <defunct>
root       22040  0.0  0.0      0     0 ?        Z    06:54   0:00 [simple_switch_g] <defunct>
root       22136  0.0  0.0      0     0 ?        Z    06:56   0:00 [simple_switch_g] <defunct>
root       22234  0.0  0.0      0     0 ?        Z    06:58   0:00 [simple_switch_g] <defunct>
root       22332  0.0  0.0      0     0 ?        Z    07:03   0:00 [simple_switch_g] <defunct>
root       22430  0.0  0.0      0     0 ?        Z    07:10   0:00 [simple_switch_g] <defunct>
root       22528  0.0  0.0      0     0 ?        Z    07:18   0:00 [simple_switch_g] <defunct>
root       22624  0.0  0.0      0     0 ?        Z    07:20   0:00 [simple_switch_g] <defunct>
root       22722  0.0  0.0      0     0 ?        Z    07:24   0:00 [simple_switch_g] <defunct>
root       22858  0.0  0.0      0     0 ?        Z    07:30   0:00 [simple_switch_g] <defunct>
root       22956  0.2  0.0      0     0 ?        Zl   07:32   0:00 [simple_switch_g] <defunct>
root       23016  0.0  0.0   3540  2156 ?        S    07:32   0:00 grep simple_switch