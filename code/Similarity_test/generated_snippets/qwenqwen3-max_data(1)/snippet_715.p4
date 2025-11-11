Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/67fba2f9-185a-467b-80eb-f9adcca4c795.p4 ...
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
root          86  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         222  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         320  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         467  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         634  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         732  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         830  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         997  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1134  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1301  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1431  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1529  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1627  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1725  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1823  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1955  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2051  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2149  0.0  0.0      0     0 ?        Z    05:01   0:00 [simple_switch_g] <defunct>
root        2254  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2352  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2448  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2546  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2642  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2738  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2836  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3003  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3099  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3266  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3362  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3458  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3556  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3674  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3774  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        3947  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        4086  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4243  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4410  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4506  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4673  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4773  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        4887  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        5054  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5154  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5250  0.0  0.0      0     0 ?        Z    05:25   0:00 [simple_switch_g] <defunct>
root        5348  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5517  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5615  0.0  0.0      0     0 ?        Z    05:29   0:00 [simple_switch_g] <defunct>
root        5760  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5856  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        5994  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6092  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6188  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6288  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6384  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6482  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6580  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6714  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6848  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        6948  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7046  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7182  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7318  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7485  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7583  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7679  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7846  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7944  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8042  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8192  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8357  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8455  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8587  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8754  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8854  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        9009  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9145  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9243  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9410  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9546  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9680  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9780  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9880  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9978  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10112  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10210  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10354  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10450  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10548  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10646  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10811  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10961  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11126  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11224  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11320  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11490  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11657  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11793  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11891  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12028  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12163  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12261  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12357  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12493  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12645  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12772  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12927  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       13063  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       13213  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13311  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13476  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13574  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13714  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13812  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13950  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       14119  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       14255  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       14389  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       14527  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       14625  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14731  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14858  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14958  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       15056  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       15200  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       15349  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       15485  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15583  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15750  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15848  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15946  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       16044  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       16181  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       16279  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       16379  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       16477  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       16575  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       16675  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       16773  0.0  0.0      0     0 ?        Z    05:59   0:00 [simple_switch_g] <defunct>
root       16871  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       17007  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       17105  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       17203  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       17339  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       17437  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       17535  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       17672  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       17768  0.0  0.0      0     0 ?        Z    06:04   0:00 [simple_switch_g] <defunct>
root       17866  0.0  0.0      0     0 ?        Z    06:05   0:00 [simple_switch_g] <defunct>
root       18033  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       18131  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       18231  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       18367  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       18534  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       18670  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       18837  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       18971  0.0  0.0      0     0 ?        Z    06:12   0:00 [simple_switch_g] <defunct>
root       19069  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       19167  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       19265  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       19361  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       19459  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       19555  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       19691  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       19825  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       19992  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       20092  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       20230  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       20364  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       20464  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       20562  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       20698  0.0  0.0      0     0 ?        Z    06:24   0:00 [simple_switch_g] <defunct>
root       20834  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       20979  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       21077  0.0  0.0      0     0 ?        Z    06:26   0:00 [simple_switch_g] <defunct>
root       21211  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       21368  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       21533  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       21631  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       21767  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       21903  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       22035  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       22150  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       22248  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       22386  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       22522  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       22622  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       22789  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       22889  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       23024  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       23122  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       23254  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       23352  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       23488  0.0  0.0      0     0 ?        Z    06:40   0:00 [simple_switch_g] <defunct>
root       23622  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       23720  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       23816  0.0  0.0      0     0 ?        Z    06:43   0:00 [simple_switch_g] <defunct>
root       23952  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       24117  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       24215  0.0  0.0      0     0 ?        Z    06:48   0:00 [simple_switch_g] <defunct>
root       24313  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       24447  0.0  0.0      0     0 ?        Z    06:51   0:00 [simple_switch_g] <defunct>
root       24545  0.0  0.0      0     0 ?        Z    06:53   0:00 [simple_switch_g] <defunct>
root       24641  0.0  0.0      0     0 ?        Z    06:55   0:00 [simple_switch_g] <defunct>
root       24806  0.0  0.0      0     0 ?        Z    06:58   0:00 [simple_switch_g] <defunct>
root       24904  0.0  0.0      0     0 ?        Z    07:01   0:00 [simple_switch_g] <defunct>
root       25002  0.0  0.0      0     0 ?        Z    07:08   0:00 [simple_switch_g] <defunct>
root       25100  0.0  0.0      0     0 ?        Z    07:18   0:00 [simple_switch_g] <defunct>
root       25196  0.0  0.0      0     0 ?        Z    07:20   0:00 [simple_switch_g] <defunct>
root       25294  0.0  0.0      0     0 ?        Z    07:24   0:00 [simple_switch_g] <defunct>
root       25392  0.0  0.0      0     0 ?        Z    07:30   0:00 [simple_switch_g] <defunct>
root       25490  0.0  0.0      0     0 ?        Z    07:32   0:00 [simple_switch_g] <defunct>
root       25624  0.0  0.0      0     0 ?        Z    07:34   0:00 [simple_switch_g] <defunct>
root       25761  0.0  0.0      0     0 ?        Z    07:37   0:00 [simple_switch_g] <defunct>
root       25859  0.0  0.0      0     0 ?        Z    07:39   0:00 [simple_switch_g] <defunct>
root       25957  0.0  0.0      0     0 ?        Z    07:42   0:00 [simple_switch_g] <defunct>
root       26087  0.0  0.0      0     0 ?        Z    07:44   0:00 [simple_switch_g] <defunct>
root       26185  0.2  0.0      0     0 ?        Zl   07:46   0:00 [simple_switch_g] <defunct>
root       26247  0.0  0.0   3540  2172 ?        S    07:47   0:00 grep simple_switch