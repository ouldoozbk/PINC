Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/db217f18-df05-4bc2-a559-78cfd21d18ef.p4 ...
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
root         243  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         379  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         479  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         577  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         744  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         840  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         938  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1038  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1136  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1234  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1349  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1447  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1574  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1670  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1768  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1866  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        1962  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2089  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2187  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2352  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2448  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2546  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2644  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2742  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2840  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        2940  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3040  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3182  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3280  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3378  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3476  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3572  0.0  0.0      0     0 ?        Z    05:10   0:00 [simple_switch_g] <defunct>
root        3737  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3904  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        4004  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        4102  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4200  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4347  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4443  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4575  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4673  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        4773  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        4923  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5021  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5117  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5262  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5431  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5598  0.0  0.0      0     0 ?        Z    05:30   0:00 [simple_switch_g] <defunct>
root        5694  0.0  0.0      0     0 ?        Z    05:31   0:00 [simple_switch_g] <defunct>
root        5790  0.0  0.0      0     0 ?        Z    05:32   0:00 [simple_switch_g] <defunct>
root        5886  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        6022  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6120  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6218  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6339  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6435  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6533  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6633  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6731  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6829  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6965  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7102  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7236  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7403  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7503  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7603  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7703  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7841  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        7979  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8115  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8215  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8349  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8516  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8638  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8736  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        8901  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9008  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9173  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9271  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9403  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9501  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9623  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9721  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9857  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root        9957  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10093  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10233  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10373  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10469  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10565  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10736  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10872  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11039  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11139  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11275  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11442  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11611  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11763  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       11915  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12049  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12181  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12281  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12379  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12475  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12609  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12774  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12872  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13037  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13177  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13309  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       13445  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13612  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13744  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13880  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       14016  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       14114  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14250  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14415  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14515  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14613  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14778  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14914  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15012  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15148  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15244  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15342  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       15440  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15564  0.0  0.0      0     0 ?        Z    05:59   0:00 [simple_switch_g] <defunct>
root       15662  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15762  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       15909  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16007  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16103  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16245  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       16343  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16508  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16608  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16706  0.0  0.0      0     0 ?        Z    06:04   0:00 [simple_switch_g] <defunct>
root       16842  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17007  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17105  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17203  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       17301  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17399  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17536  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       17634  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17770  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       17870  0.0  0.0      0     0 ?        Z    06:12   0:00 [simple_switch_g] <defunct>
root       17968  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       18066  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18162  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18262  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       18396  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       18532  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       18630  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18728  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       18895  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       18995  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       19133  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       19255  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       19393  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       19527  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19627  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       19763  0.0  0.0      0     0 ?        Z    06:26   0:00 [simple_switch_g] <defunct>
root       19861  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       19957  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20122  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20287  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       20385  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       20485  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       20583  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20681  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       20817  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       20915  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       21049  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       21185  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21283  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       21419  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21517  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       21651  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       21787  0.0  0.0      0     0 ?        Z    06:40   0:00 [simple_switch_g] <defunct>
root       21885  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       21985  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       22083  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22219  0.0  0.0      0     0 ?        Z    06:44   0:00 [simple_switch_g] <defunct>
root       22317  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       22415  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       22551  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       22687  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       22829  0.0  0.0      0     0 ?        Z    06:52   0:00 [simple_switch_g] <defunct>
root       22927  0.0  0.0      0     0 ?        Z    06:55   0:00 [simple_switch_g] <defunct>
root       23065  0.0  0.0      0     0 ?        Z    06:57   0:00 [simple_switch_g] <defunct>
root       23232  0.0  0.0      0     0 ?        Z    07:00   0:00 [simple_switch_g] <defunct>
root       23330  0.0  0.0      0     0 ?        Z    07:06   0:00 [simple_switch_g] <defunct>
root       23428  0.1  0.0      0     0 ?        Zl   07:17   0:00 [simple_switch_g] <defunct>
root       23488  0.0  0.0   3540  2092 ?        S    07:17   0:00 grep simple_switch