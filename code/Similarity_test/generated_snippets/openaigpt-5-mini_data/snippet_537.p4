Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/d82394c6-4f46-45ed-9c4a-dff19d2b4d5e.p4 ...
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
root         228  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         326  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         493  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         591  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         691  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         821  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         921  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1019  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1117  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1215  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1313  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1411  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1509  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1607  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1705  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1803  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1903  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2001  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2132  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2228  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2328  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2426  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2522  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2618  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2714  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2812  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2910  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3079  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3246  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3413  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3509  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3607  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3743  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3839  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3977  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4077  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4173  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4342  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4442  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4611  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4765  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4929  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5027  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5196  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5346  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5508  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5606  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5702  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5838  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5974  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6110  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6235  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6333  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6477  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6613  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6778  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6930  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7028  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7126  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7262  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7400  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7565  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7717  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7854  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7952  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8050  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8217  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8339  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8477  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8577  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8713  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8849  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8985  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9152  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9321  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9490  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9588  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9724  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9891  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9987  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10123  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10223  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10361  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10495  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10591  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10687  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10785  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10883  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11032  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11198  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11334  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11478  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11578  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11745  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11841  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11975  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12112  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12208  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12350  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12517  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12657  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12793  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12943  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13041  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13177  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13319  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13417  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13553  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13653  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13789  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13887  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14052  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14148  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14284  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14380  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14478  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14614  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14712  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14810  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14946  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15042  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15176  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15312  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15448  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15546  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15682  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15780  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15878  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16045  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16212  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16379  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16477  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16611  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16745  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16881  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16979  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17079  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17177  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17344  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17440  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17540  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17674  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17810  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17946  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18044  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18209  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18309  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18407  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18541  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18639  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18777  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18875  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19011  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19178  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19312  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19410  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19577  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19742  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19878  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20045  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20143  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20279  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20377  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20511  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20607  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20741  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20839  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20975  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21073  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21171  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21338  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21436  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21534  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21630  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21766  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21864  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21962  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22129  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22227  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22325  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22423  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22590  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22688  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22786  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22884  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22982  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23080  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23178  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23315  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23411  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23547  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23645  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23782  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23917  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24013  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24147  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24283  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24381  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24517  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24655  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24755  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24893  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24991  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25091  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25227  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25365  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25501  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25601  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25737  0.0  0.0      0     0 ?        Z    21:10   0:00 [simple_switch_g] <defunct>
root       25835  0.0  0.0      0     0 ?        Z    21:12   0:00 [simple_switch_g] <defunct>
root       25971  0.0  0.0      0     0 ?        Z    21:16   0:00 [simple_switch_g] <defunct>
root       26107  0.0  0.0      0     0 ?        Z    21:19   0:00 [simple_switch_g] <defunct>
root       26243  0.0  0.0      0     0 ?        Z    21:25   0:00 [simple_switch_g] <defunct>
root       26341  0.0  0.0      0     0 ?        Z    21:27   0:00 [simple_switch_g] <defunct>
root       26437  0.1  0.0      0     0 ?        Zl   21:30   0:00 [simple_switch_g] <defunct>
root       26497  0.0  0.0   3540  2180 ?        S    21:30   0:00 grep simple_switch