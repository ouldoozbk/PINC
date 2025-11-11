Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/25d60edd-4836-4738-ade2-0a2edca074e1.p4 ...
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
root         286  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         386  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         484  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         582  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         680  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         778  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         874  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1036  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1171  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1269  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1382  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1480  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1647  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1814  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1981  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2077  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2175  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2273  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2409  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2505  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2603  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2701  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2801  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2899  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        3035  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3133  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3231  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3329  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3498  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3596  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3692  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3817  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3986  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        4122  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4220  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4371  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4467  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4604  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4748  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        4850  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        4982  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5149  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5247  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5414  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5579  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5716  0.0  0.0      0     0 ?        Z    05:30   0:00 [simple_switch_g] <defunct>
root        5814  0.0  0.0      0     0 ?        Z    05:31   0:00 [simple_switch_g] <defunct>
root        5910  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        6008  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6108  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6245  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6381  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6517  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6653  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6751  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6851  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6973  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        7109  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7276  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7414  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7550  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7648  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7792  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7890  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7986  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8121  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8257  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8357  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8524  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8662  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8831  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8971  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9091  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9225  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9363  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9463  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9561  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9657  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9793  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9927  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10094  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10192  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10290  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10388  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10550  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10646  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10811  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10909  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11007  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11176  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11274  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11410  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11508  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11608  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11744  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11911  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12049  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12217  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12353  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12489  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12591  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12689  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12787  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       12887  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13052  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13194  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13292  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13430  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13528  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13664  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13833  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       13933  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14069  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14207  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14303  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       14439  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       14535  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       14633  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       14769  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       14936  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15072  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15170  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15297  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15393  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       15529  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       15627  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       15757  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       15891  0.0  0.0      0     0 ?        Z    06:05   0:00 [simple_switch_g] <defunct>
root       15989  0.0  0.0      0     0 ?        Z    06:05   0:00 [simple_switch_g] <defunct>
root       16123  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       16223  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       16388  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       16553  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       16688  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       16784  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       16880  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       16978  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17076  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       17174  0.0  0.0      0     0 ?        Z    06:14   0:00 [simple_switch_g] <defunct>
root       17272  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17370  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       17468  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       17604  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       17740  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       17836  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       17932  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18097  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18195  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18333  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       18431  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       18569  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       18667  0.0  0.0      0     0 ?        Z    06:24   0:00 [simple_switch_g] <defunct>
root       18803  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       18903  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19039  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       19175  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19275  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19373  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19471  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       19569  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       19667  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       19803  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       19939  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       20037  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       20173  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       20269  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       20369  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       20467  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       20565  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       20663  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       20800  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       20898  0.0  0.0      0     0 ?        Z    06:38   0:00 [simple_switch_g] <defunct>
root       21034  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21130  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21228  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       21364  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       21462  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       21598  0.0  0.0      0     0 ?        Z    06:45   0:00 [simple_switch_g] <defunct>
root       21696  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       21792  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       21959  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       22095  0.0  0.0      0     0 ?        Z    06:51   0:00 [simple_switch_g] <defunct>
root       22262  0.0  0.0      0     0 ?        Z    06:53   0:00 [simple_switch_g] <defunct>
root       22358  0.0  0.0      0     0 ?        Z    06:55   0:00 [simple_switch_g] <defunct>
root       22525  0.0  0.0      0     0 ?        Z    06:58   0:00 [simple_switch_g] <defunct>
root       22657  0.0  0.0      0     0 ?        Z    07:01   0:00 [simple_switch_g] <defunct>
root       22755  0.0  0.0      0     0 ?        Z    07:08   0:00 [simple_switch_g] <defunct>
root       22853  0.2  0.0      0     0 ?        Zl   07:18   0:00 [simple_switch_g] <defunct>
root       22913  0.0  0.0   3540  2100 ?        S    07:18   0:00 grep simple_switch