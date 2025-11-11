Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/79abcce9-5e31-424f-92be-bbcc7ec858d8.p4 ...
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
root         204  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         302  0.0  0.0      0     0 ?        Z    04:46   0:00 [simple_switch_g] <defunct>
root         436  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         534  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         632  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         730  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         828  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         973  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1073  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1171  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1269  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1367  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1465  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1563  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1661  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1757  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1893  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        1989  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2136  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2236  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2334  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2434  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2532  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2632  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2732  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        2828  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        2926  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3078  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3176  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3343  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3441  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3537  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3671  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        3769  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        3889  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        3987  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4087  0.0  0.0      0     0 ?        Z    05:18   0:00 [simple_switch_g] <defunct>
root        4183  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4352  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4450  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        4550  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        4669  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        4765  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        4930  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5080  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5202  0.0  0.0      0     0 ?        Z    05:30   0:00 [simple_switch_g] <defunct>
root        5317  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5453  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        5589  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        5689  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        5785  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        5883  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        5981  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6081  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6179  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6315  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6451  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        6587  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        6685  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        6822  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        6922  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7089  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7254  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7406  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7504  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7604  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7702  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7854  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7952  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8050  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8148  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8280  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8447  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8545  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8679  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8777  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8899  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9021  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9119  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9217  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9382  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9520  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9618  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9716  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9814  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9981  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10123  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10221  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10350  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10450  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10548  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10646  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10782  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10937  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11037  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11135  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11233  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11369  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11469  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11636  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11771  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11905  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12003  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12170  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12308  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12408  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12506  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12673  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12807  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12905  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13041  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13210  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13340  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13436  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13572  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13706  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13843  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13941  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14086  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14255  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14393  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14562  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14698  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14798  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14932  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15028  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15152  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15250  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15350  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       15484  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15620  0.0  0.0      0     0 ?        Z    05:59   0:00 [simple_switch_g] <defunct>
root       15754  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15890  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16026  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16162  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       16260  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       16420  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16556  0.0  0.0      0     0 ?        Z    06:04   0:00 [simple_switch_g] <defunct>
root       16690  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16826  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16924  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       17060  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17227  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       17325  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       17423  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17590  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17726  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       17822  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17956  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18054  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       18188  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       18324  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       18460  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18627  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18763  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18861  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18997  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       19124  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       19294  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       19461  0.0  0.0      0     0 ?        Z    06:24   0:00 [simple_switch_g] <defunct>
root       19597  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19727  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19825  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19959  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       20057  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20155  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20253  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20351  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       20449  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       20585  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20683  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20783  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       20881  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       21021  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       21157  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       21293  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21389  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21487  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21622  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21720  0.0  0.0      0     0 ?        Z    06:38   0:00 [simple_switch_g] <defunct>
root       21818  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21916  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       22066  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       22202  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22300  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22436  0.0  0.0      0     0 ?        Z    06:45   0:00 [simple_switch_g] <defunct>
root       22572  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       22739  0.0  0.0      0     0 ?        Z    06:48   0:00 [simple_switch_g] <defunct>
root       22873  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       23040  0.0  0.0      0     0 ?        Z    06:52   0:00 [simple_switch_g] <defunct>
root       23176  0.0  0.0      0     0 ?        Z    06:55   0:00 [simple_switch_g] <defunct>
root       23274  0.0  0.0      0     0 ?        Z    06:57   0:00 [simple_switch_g] <defunct>
root       23410  0.0  0.0      0     0 ?        Z    07:01   0:00 [simple_switch_g] <defunct>
root       23508  0.0  0.0      0     0 ?        Z    07:07   0:00 [simple_switch_g] <defunct>
root       23606  0.0  0.0      0     0 ?        Z    07:18   0:00 [simple_switch_g] <defunct>
root       23704  0.0  0.0      0     0 ?        Z    07:20   0:00 [simple_switch_g] <defunct>
root       23856  0.0  0.0      0     0 ?        Z    07:25   0:00 [simple_switch_g] <defunct>
root       24023  0.0  0.0      0     0 ?        Z    07:30   0:00 [simple_switch_g] <defunct>
root       24121  0.2  0.0      0     0 ?        Zl   07:32   0:00 [simple_switch_g] <defunct>
root       24181  0.0  0.0   3540  1976 ?        S    07:33   0:00 grep simple_switch