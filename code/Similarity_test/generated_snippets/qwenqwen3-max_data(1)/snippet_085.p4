Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/96766464-c2ec-4a46-9216-be627327d865.p4 ...
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
Test4

******************************************

PTF test finished.  Waiting 2 seconds before killing simple_switch_grpc ...

Verifying that there are no simple_switch_grpc processes running any longer in 4 seconds ...
simple_switch_grpc terminated
root          86  0.0  0.0      0     0 ?        Z    04:43   0:00 [simple_switch_g] <defunct>
root         223  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         321  0.0  0.0      0     0 ?        Z    04:45   0:00 [simple_switch_g] <defunct>
root         419  0.0  0.0      0     0 ?        Z    04:50   0:00 [simple_switch_g] <defunct>
root         588  0.0  0.0      0     0 ?        Z    04:51   0:00 [simple_switch_g] <defunct>
root         686  0.0  0.0      0     0 ?        Z    04:52   0:00 [simple_switch_g] <defunct>
root         784  0.0  0.0      0     0 ?        Z    04:53   0:00 [simple_switch_g] <defunct>
root         882  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root         980  0.0  0.0      0     0 ?        Z    04:54   0:00 [simple_switch_g] <defunct>
root        1119  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1281  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1377  0.0  0.0      0     0 ?        Z    04:55   0:00 [simple_switch_g] <defunct>
root        1475  0.0  0.0      0     0 ?        Z    04:56   0:00 [simple_switch_g] <defunct>
root        1642  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1740  0.0  0.0      0     0 ?        Z    04:57   0:00 [simple_switch_g] <defunct>
root        1838  0.0  0.0      0     0 ?        Z    04:58   0:00 [simple_switch_g] <defunct>
root        1934  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2032  0.0  0.0      0     0 ?        Z    04:59   0:00 [simple_switch_g] <defunct>
root        2130  0.0  0.0      0     0 ?        Z    05:00   0:00 [simple_switch_g] <defunct>
root        2297  0.0  0.0      0     0 ?        Z    05:02   0:00 [simple_switch_g] <defunct>
root        2464  0.0  0.0      0     0 ?        Z    05:03   0:00 [simple_switch_g] <defunct>
root        2560  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2660  0.0  0.0      0     0 ?        Z    05:04   0:00 [simple_switch_g] <defunct>
root        2758  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2856  0.0  0.0      0     0 ?        Z    05:05   0:00 [simple_switch_g] <defunct>
root        2954  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3054  0.0  0.0      0     0 ?        Z    05:06   0:00 [simple_switch_g] <defunct>
root        3152  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3319  0.0  0.0      0     0 ?        Z    05:07   0:00 [simple_switch_g] <defunct>
root        3415  0.0  0.0      0     0 ?        Z    05:08   0:00 [simple_switch_g] <defunct>
root        3580  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3678  0.0  0.0      0     0 ?        Z    05:09   0:00 [simple_switch_g] <defunct>
root        3814  0.0  0.0      0     0 ?        Z    05:11   0:00 [simple_switch_g] <defunct>
root        3912  0.0  0.0      0     0 ?        Z    05:12   0:00 [simple_switch_g] <defunct>
root        4081  0.0  0.0      0     0 ?        Z    05:13   0:00 [simple_switch_g] <defunct>
root        4218  0.0  0.0      0     0 ?        Z    05:14   0:00 [simple_switch_g] <defunct>
root        4387  0.0  0.0      0     0 ?        Z    05:15   0:00 [simple_switch_g] <defunct>
root        4485  0.0  0.0      0     0 ?        Z    05:19   0:00 [simple_switch_g] <defunct>
root        4581  0.0  0.0      0     0 ?        Z    05:20   0:00 [simple_switch_g] <defunct>
root        4718  0.0  0.0      0     0 ?        Z    05:21   0:00 [simple_switch_g] <defunct>
root        4816  0.0  0.0      0     0 ?        Z    05:22   0:00 [simple_switch_g] <defunct>
root        4950  0.0  0.0      0     0 ?        Z    05:23   0:00 [simple_switch_g] <defunct>
root        5048  0.0  0.0      0     0 ?        Z    05:24   0:00 [simple_switch_g] <defunct>
root        5215  0.0  0.0      0     0 ?        Z    05:25   0:00 [simple_switch_g] <defunct>
root        5313  0.0  0.0      0     0 ?        Z    05:26   0:00 [simple_switch_g] <defunct>
root        5483  0.0  0.0      0     0 ?        Z    05:27   0:00 [simple_switch_g] <defunct>
root        5581  0.0  0.0      0     0 ?        Z    05:29   0:00 [simple_switch_g] <defunct>
root        5679  0.0  0.0      0     0 ?        Z    05:31   0:00 [simple_switch_g] <defunct>
root        5846  0.0  0.0      0     0 ?        Z    05:33   0:00 [simple_switch_g] <defunct>
root        5982  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6118  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6216  0.0  0.0      0     0 ?        Z    05:34   0:00 [simple_switch_g] <defunct>
root        6350  0.0  0.0      0     0 ?        Z    05:35   0:00 [simple_switch_g] <defunct>
root        6486  0.0  0.0      0     0 ?        Z    05:36   0:00 [simple_switch_g] <defunct>
root        6622  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6764  0.0  0.0      0     0 ?        Z    05:37   0:00 [simple_switch_g] <defunct>
root        6900  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        6998  0.0  0.0      0     0 ?        Z    05:38   0:00 [simple_switch_g] <defunct>
root        7096  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7194  0.0  0.0      0     0 ?        Z    05:39   0:00 [simple_switch_g] <defunct>
root        7292  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7394  0.0  0.0      0     0 ?        Z    05:40   0:00 [simple_switch_g] <defunct>
root        7492  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7661  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7761  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7859  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        7955  0.0  0.0      0     0 ?        Z    05:41   0:00 [simple_switch_g] <defunct>
root        8053  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8151  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8249  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8401  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8497  0.0  0.0      0     0 ?        Z    05:42   0:00 [simple_switch_g] <defunct>
root        8664  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8802  0.0  0.0      0     0 ?        Z    05:43   0:00 [simple_switch_g] <defunct>
root        8969  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9109  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9207  0.0  0.0      0     0 ?        Z    05:44   0:00 [simple_switch_g] <defunct>
root        9372  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9470  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9637  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9769  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9867  0.0  0.0      0     0 ?        Z    05:45   0:00 [simple_switch_g] <defunct>
root        9991  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10158  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10256  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10354  0.0  0.0      0     0 ?        Z    05:46   0:00 [simple_switch_g] <defunct>
root       10498  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10596  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10694  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       10856  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11021  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11158  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11256  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11354  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11508  0.0  0.0      0     0 ?        Z    05:47   0:00 [simple_switch_g] <defunct>
root       11648  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11782  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11878  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       11974  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12072  0.0  0.0      0     0 ?        Z    05:48   0:00 [simple_switch_g] <defunct>
root       12208  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12344  0.0  0.0      0     0 ?        Z    05:49   0:00 [simple_switch_g] <defunct>
root       12446  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12544  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12711  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12847  0.0  0.0      0     0 ?        Z    05:50   0:00 [simple_switch_g] <defunct>
root       12983  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13119  0.0  0.0      0     0 ?        Z    05:51   0:00 [simple_switch_g] <defunct>
root       13217  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13386  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13551  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13693  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13789  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       13887  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       14023  0.0  0.0      0     0 ?        Z    05:52   0:00 [simple_switch_g] <defunct>
root       14121  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14219  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14317  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14417  0.0  0.0      0     0 ?        Z    05:53   0:00 [simple_switch_g] <defunct>
root       14584  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14682  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14849  0.0  0.0      0     0 ?        Z    05:54   0:00 [simple_switch_g] <defunct>
root       14985  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15083  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15233  0.0  0.0      0     0 ?        Z    05:55   0:00 [simple_switch_g] <defunct>
root       15371  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15508  0.0  0.0      0     0 ?        Z    05:56   0:00 [simple_switch_g] <defunct>
root       15642  0.0  0.0      0     0 ?        Z    05:57   0:00 [simple_switch_g] <defunct>
root       15778  0.0  0.0      0     0 ?        Z    05:58   0:00 [simple_switch_g] <defunct>
root       15914  0.0  0.0      0     0 ?        Z    05:59   0:00 [simple_switch_g] <defunct>
root       16044  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16142  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16309  0.0  0.0      0     0 ?        Z    06:00   0:00 [simple_switch_g] <defunct>
root       16405  0.0  0.0      0     0 ?        Z    06:01   0:00 [simple_switch_g] <defunct>
root       16541  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       16639  0.0  0.0      0     0 ?        Z    06:02   0:00 [simple_switch_g] <defunct>
root       16801  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       16899  0.0  0.0      0     0 ?        Z    06:03   0:00 [simple_switch_g] <defunct>
root       17035  0.0  0.0      0     0 ?        Z    06:05   0:00 [simple_switch_g] <defunct>
root       17171  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17336  0.0  0.0      0     0 ?        Z    06:06   0:00 [simple_switch_g] <defunct>
root       17434  0.0  0.0      0     0 ?        Z    06:07   0:00 [simple_switch_g] <defunct>
root       17570  0.0  0.0      0     0 ?        Z    06:08   0:00 [simple_switch_g] <defunct>
root       17668  0.0  0.0      0     0 ?        Z    06:09   0:00 [simple_switch_g] <defunct>
root       17835  0.0  0.0      0     0 ?        Z    06:10   0:00 [simple_switch_g] <defunct>
root       17971  0.0  0.0      0     0 ?        Z    06:11   0:00 [simple_switch_g] <defunct>
root       18109  0.0  0.0      0     0 ?        Z    06:13   0:00 [simple_switch_g] <defunct>
root       18207  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18374  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18474  0.0  0.0      0     0 ?        Z    06:15   0:00 [simple_switch_g] <defunct>
root       18570  0.0  0.0      0     0 ?        Z    06:16   0:00 [simple_switch_g] <defunct>
root       18706  0.0  0.0      0     0 ?        Z    06:17   0:00 [simple_switch_g] <defunct>
root       18802  0.0  0.0      0     0 ?        Z    06:18   0:00 [simple_switch_g] <defunct>
root       18900  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       19036  0.0  0.0      0     0 ?        Z    06:19   0:00 [simple_switch_g] <defunct>
root       19132  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       19230  0.0  0.0      0     0 ?        Z    06:20   0:00 [simple_switch_g] <defunct>
root       19366  0.0  0.0      0     0 ?        Z    06:21   0:00 [simple_switch_g] <defunct>
root       19502  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       19600  0.0  0.0      0     0 ?        Z    06:22   0:00 [simple_switch_g] <defunct>
root       19700  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       19796  0.0  0.0      0     0 ?        Z    06:23   0:00 [simple_switch_g] <defunct>
root       19932  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       20032  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       20199  0.0  0.0      0     0 ?        Z    06:25   0:00 [simple_switch_g] <defunct>
root       20333  0.0  0.0      0     0 ?        Z    06:27   0:00 [simple_switch_g] <defunct>
root       20431  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20591  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20689  0.0  0.0      0     0 ?        Z    06:28   0:00 [simple_switch_g] <defunct>
root       20787  0.0  0.0      0     0 ?        Z    06:29   0:00 [simple_switch_g] <defunct>
root       20885  0.0  0.0      0     0 ?        Z    06:30   0:00 [simple_switch_g] <defunct>
root       21023  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       21121  0.0  0.0      0     0 ?        Z    06:31   0:00 [simple_switch_g] <defunct>
root       21267  0.0  0.0      0     0 ?        Z    06:32   0:00 [simple_switch_g] <defunct>
root       21403  0.0  0.0      0     0 ?        Z    06:33   0:00 [simple_switch_g] <defunct>
root       21539  0.0  0.0      0     0 ?        Z    06:34   0:00 [simple_switch_g] <defunct>
root       21637  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       21737  0.0  0.0      0     0 ?        Z    06:35   0:00 [simple_switch_g] <defunct>
root       21873  0.0  0.0      0     0 ?        Z    06:36   0:00 [simple_switch_g] <defunct>
root       22011  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       22107  0.0  0.0      0     0 ?        Z    06:37   0:00 [simple_switch_g] <defunct>
root       22274  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       22372  0.0  0.0      0     0 ?        Z    06:39   0:00 [simple_switch_g] <defunct>
root       22508  0.0  0.0      0     0 ?        Z    06:40   0:00 [simple_switch_g] <defunct>
root       22606  0.0  0.0      0     0 ?        Z    06:41   0:00 [simple_switch_g] <defunct>
root       22742  0.0  0.0      0     0 ?        Z    06:42   0:00 [simple_switch_g] <defunct>
root       22840  0.0  0.0      0     0 ?        Z    06:43   0:00 [simple_switch_g] <defunct>
root       22976  0.0  0.0      0     0 ?        Z    06:46   0:00 [simple_switch_g] <defunct>
root       23112  0.0  0.0      0     0 ?        Z    06:47   0:00 [simple_switch_g] <defunct>
root       23210  0.0  0.0      0     0 ?        Z    06:48   0:00 [simple_switch_g] <defunct>
root       23308  0.0  0.0      0     0 ?        Z    06:49   0:00 [simple_switch_g] <defunct>
root       23404  0.0  0.0      0     0 ?        Z    06:50   0:00 [simple_switch_g] <defunct>
root       23540  0.0  0.0      0     0 ?        Z    06:53   0:00 [simple_switch_g] <defunct>
root       23676  0.0  0.0      0     0 ?        Z    06:55   0:00 [simple_switch_g] <defunct>
root       23774  0.0  0.0      0     0 ?        Z    06:57   0:00 [simple_switch_g] <defunct>
root       23910  0.0  0.0      0     0 ?        Z    07:00   0:00 [simple_switch_g] <defunct>
root       24008  0.0  0.0      0     0 ?        Z    07:06   0:00 [simple_switch_g] <defunct>
root       24144  0.0  0.0      0     0 ?        Z    07:17   0:00 [simple_switch_g] <defunct>
root       24242  1.3  0.0      0     0 ?        Zl   07:19   0:00 [simple_switch_g] <defunct>
root       24303  0.0  0.0   3540  1980 ?        S    07:19   0:00 grep simple_switch