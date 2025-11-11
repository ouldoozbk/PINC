Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/e433b6a2-6af9-4b5e-b5d0-4c9ad19902fa.p4 ...
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
root          86  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         222  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         389  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         523  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         692  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         788  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         884  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1018  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1116  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1252  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1348  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1446  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1542  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1642  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1742  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1840  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1940  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2038  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2136  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2234  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2330  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2428  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2526  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2624  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2760  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2858  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2954  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3091  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3256  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3352  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3450  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3615  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3713  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3882  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3982  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4120  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4285  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4383  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4510  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4652  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4819  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4986  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5151  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5318  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5455  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5553  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5649  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5745  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5881  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5979  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6077  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6173  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6309  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6407  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6507  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6643  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6812  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6979  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7077  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7213  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7311  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7475  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7611  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7747  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7845  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7977  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8129  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8265  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8434  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8574  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8694  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8828  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8926  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9026  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9122  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9220  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9318  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9416  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9514  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9650  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9748  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9846  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9944  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10078  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10247  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10343  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10479  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10577  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10677  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10775  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10873  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11040  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11176  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11274  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11374  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11472  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11641  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11739  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11861  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12030  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12166  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12302  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12438  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12574  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12712  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12810  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12908  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13044  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13209  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13307  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13443  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13579  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13744  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13842  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13940  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14077  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14211  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14309  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14407  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14505  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14603  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14703  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14865  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14963  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15105  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15239  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15375  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15473  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15640  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15736  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15872  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16006  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16142  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16307  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16405  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16501  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16668  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16764  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16862  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16962  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17098  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17265  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17361  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17497  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17595  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17731  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17867  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18003  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18101  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18237  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18335  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18473  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18571  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18707  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18805  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18941  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19077  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19215  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19360  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19458  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19556  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19685  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19781  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19919  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20017  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20119  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20255  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20353  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20451  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20549  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20647  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20781  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20879  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21046  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21182  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21345  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21443  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21541  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21677  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21775  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21942  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22040  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22136  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22234  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22332  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22430  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22528  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22624  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22722  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22858  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22956  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23090  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23227  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23367  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23465  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23632  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23766  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23902  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24069  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24205  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24303  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24441  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24577  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24675  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24773  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24911  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25047  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25185  0.0  0.0      0     0 ?        Z    21:06   0:00 [simple_switch_g] <defunct>
root       25321  0.2  0.0      0     0 ?        Zl   21:11   0:00 [simple_switch_g] <defunct>
root       25383  0.0  0.0   3540  2232 ?        S    21:11   0:00 grep simple_switch