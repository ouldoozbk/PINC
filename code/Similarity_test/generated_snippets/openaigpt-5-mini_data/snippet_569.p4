Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/4dd76671-14ea-4f0e-b0ef-ae9b7cbbc5f1.p4 ...
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
root         342  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         509  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         607  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         705  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         801  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         899  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         997  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1095  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1193  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1291  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1403  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1499  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1597  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1764  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1862  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1958  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2125  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2221  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2319  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2417  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2515  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2613  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2711  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2807  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2905  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3003  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3101  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3199  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3297  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3397  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3521  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3619  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3788  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3886  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3986  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4084  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4180  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4349  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4447  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4557  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4657  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4822  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4922  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5022  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5152  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5250  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5346  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5442  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5540  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5636  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5734  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5832  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5930  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6028  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6155  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6291  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6389  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6485  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6621  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6757  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6893  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7058  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7192  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7290  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7442  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7538  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7636  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7788  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7953  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8089  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8189  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8322  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8458  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8556  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8654  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8752  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8852  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8948  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9084  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9184  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9353  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9451  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9587  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9687  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9821  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9990  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10090  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10188  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10355  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10491  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10627  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10725  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10823  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10923  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11021  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11188  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11322  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11487  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11585  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11683  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11850  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11946  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12044  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12140  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12274  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12410  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12548  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12644  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12780  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12880  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12978  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13105  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13205  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13372  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13508  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13608  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13775  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13873  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14040  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14207  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14303  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14437  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14535  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14633  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14731  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14829  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14925  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15059  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15195  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15331  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15429  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15559  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15724  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15822  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15920  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16056  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16223  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16321  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16417  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16564  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16662  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16758  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16856  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16952  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17086  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17253  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17351  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17485  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17583  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17717  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17884  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17982  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18078  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18174  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18308  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18442  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18540  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18640  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18776  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18912  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19048  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19146  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19244  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19342  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19440  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19538  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19636  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19772  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19870  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19970  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20066  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20162  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20333  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20500  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20598  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20696  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20794  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20892  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21028  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21128  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21226  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21324  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21422  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21520  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21618  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21783  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21919  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22086  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22182  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22280  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22378  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22476  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22612  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22779  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22913  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23011  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23138  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23236  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23332  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23466  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23602  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23700  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23796  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23961  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24059  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24194  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24290  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24412  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24510  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24608  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24706  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24844  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24942  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25044  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25180  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25280  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25414  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25581  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25717  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25855  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25955  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       26091  0.0  0.0      0     0 ?        Z    21:08   0:00 [simple_switch_g] <defunct>
root       26227  0.0  0.0      0     0 ?        Z    21:12   0:00 [simple_switch_g] <defunct>
root       26325  0.0  0.0      0     0 ?        Z    21:15   0:00 [simple_switch_g] <defunct>
root       26423  0.0  0.0      0     0 ?        Z    21:18   0:00 [simple_switch_g] <defunct>
root       26557  0.0  0.0      0     0 ?        Z    21:22   0:00 [simple_switch_g] <defunct>
root       26691  0.0  0.0      0     0 ?        Z    21:26   0:00 [simple_switch_g] <defunct>
root       26819  0.0  0.0      0     0 ?        Z    21:29   0:00 [simple_switch_g] <defunct>
root       26955  0.1  0.0      0     0 ?        Zl   21:31   0:00 [simple_switch_g] <defunct>
root       27017  0.0  0.0   3540  2160 ?        S    21:31   0:00 grep simple_switch