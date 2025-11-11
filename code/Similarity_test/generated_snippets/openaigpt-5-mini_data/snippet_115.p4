Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/55ff06ff-1ed3-4264-bf15-d6216ac55ed4.p4 ...
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
root         320  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         418  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         558  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         656  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         756  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         854  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         952  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1050  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1165  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1263  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1399  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1497  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1664  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1762  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1860  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1958  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2125  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2221  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2321  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2417  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2515  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2613  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2709  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2807  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2903  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2999  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3097  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3197  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3297  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3397  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3493  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3611  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3709  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3847  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3981  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4133  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4231  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4329  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4467  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4636  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4790  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4888  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4986  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5128  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5295  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5442  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5566  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5664  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5762  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5896  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5994  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6132  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6232  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6368  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6466  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6602  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6700  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6839  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6937  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7073  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7209  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7343  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7443  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7541  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7711  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7847  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8014  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8150  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8315  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8447  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8614  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8752  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8850  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8984  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9082  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9178  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9314  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9450  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9550  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9718  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9816  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9916  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10052  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10148  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10290  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10424  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10522  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10662  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10758  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10856  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10952  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11050  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11186  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11355  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11457  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11553  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11682  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11847  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11981  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12118  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12254  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12354  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12454  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12552  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12689  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12829  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12925  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13087  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13223  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13359  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13497  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13666  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13764  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13862  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13962  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14060  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14160  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14311  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14409  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14547  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14645  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14743  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14841  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14978  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15123  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15221  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15319  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15419  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15517  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15653  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15749  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15914  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16012  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16179  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16279  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16379  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16509  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16645  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16779  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16877  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17044  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17180  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17317  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17415  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17511  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17647  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17804  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17940  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18038  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18136  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18255  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18389  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18485  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18583  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18719  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18817  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18953  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19087  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19185  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19321  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19419  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19517  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19617  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19784  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19882  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20047  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20145  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20243  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20341  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20439  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20537  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20635  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20733  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20831  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20967  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21065  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21201  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21335  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21471  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21569  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21667  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21765  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21901  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22001  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22137  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22235  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22335  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22433  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22569  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22736  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22834  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22970  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23066  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23162  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23260  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23358  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23456  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23623  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23721  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23819  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23953  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24051  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24149  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24245  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24343  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24477  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24573  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24669  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24831  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24996  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25094  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25230  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25364  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25502  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25600  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25698  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25796  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25898  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       26036  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       26172  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       26310  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       26446  0.0  0.0      0     0 ?        Z    21:08   0:00 [simple_switch_g] <defunct>
root       26544  0.2  0.0      0     0 ?        Zl   21:11   0:00 [simple_switch_g] <defunct>
root       26606  0.0  0.0   3540  2180 ?        S    21:11   0:00 grep simple_switch