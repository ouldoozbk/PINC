Found p4c base_test.py package: /root/p4c/tools/ptf/base_test.py
Running p4testgen on /work_space/47087bd9-b393-411a-9463-81d3165adb8f.p4 ...
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
root         150  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         302  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         400  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         569  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         667  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         765  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         863  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root         959  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1055  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1151  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1249  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1347  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1445  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1545  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1643  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1739  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        1837  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2002  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2098  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2255  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2353  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2449  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2547  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2645  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2743  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        2839  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3006  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3102  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3200  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3298  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3396  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3496  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3596  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3692  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3788  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        3886  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4053  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4220  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4372  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4472  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4608  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4747  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        4916  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5063  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5161  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5259  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5426  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5524  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5660  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5817  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        5913  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6049  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6147  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6243  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6341  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6439  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6537  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6704  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6804  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        6902  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7046  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7144  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7244  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7342  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7440  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7576  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7674  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7772  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7870  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        7966  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8101  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8199  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8297  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8454  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8588  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8686  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8853  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        8951  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9087  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9185  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9352  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9486  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9622  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9756  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9854  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root        9990  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10126  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10262  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10416  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10554  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10719  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10855  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       10953  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11120  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11244  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11415  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11540  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11676  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11811  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       11909  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12075  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12171  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12267  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12432  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12568  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12670  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12766  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       12902  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13067  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13234  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13332  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13470  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13566  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13702  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13802  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       13900  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14065  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14234  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14370  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14470  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14617  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14769  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       14869  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15016  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15112  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15210  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15375  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15496  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15594  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15730  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15828  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       15926  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16024  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16158  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16258  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16392  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16490  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16588  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16722  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16820  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       16918  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17052  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17150  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17286  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17422  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17520  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17620  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17718  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17816  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       17952  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18050  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18186  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18284  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18380  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18476  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18610  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18746  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       18880  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19014  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19112  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19248  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19382  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19480  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19616  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19783  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       19881  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20015  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20113  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20215  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20349  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20489  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20585  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20717  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20815  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       20951  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21049  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21183  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21283  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21419  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21553  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21651  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21747  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21883  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       21981  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22077  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22211  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22378  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22476  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22574  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22672  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22808  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       22906  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23004  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23102  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23238  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23374  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23510  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23647  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23779  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       23877  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24042  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24138  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24274  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24372  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24508  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24646  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24782  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       24918  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25054  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25190  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25290  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25430  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25528  0.0  0.0      0     0 ?        Z    Oct15   0:00 [simple_switch_g] <defunct>
root       25664  0.0  0.0      0     0 ?        Z    21:08   0:00 [simple_switch_g] <defunct>
root       25798  0.0  0.0      0     0 ?        Z    21:11   0:00 [simple_switch_g] <defunct>
root       25896  0.0  0.0      0     0 ?        Z    21:14   0:00 [simple_switch_g] <defunct>
root       26030  0.0  0.0      0     0 ?        Z    21:16   0:00 [simple_switch_g] <defunct>
root       26166  0.0  0.0      0     0 ?        Z    21:19   0:00 [simple_switch_g] <defunct>
root       26264  0.0  0.0      0     0 ?        Z    21:22   0:00 [simple_switch_g] <defunct>
root       26362  0.0  0.0      0     0 ?        Z    21:26   0:00 [simple_switch_g] <defunct>
root       26496  0.1  0.0      0     0 ?        Zl   21:30   0:00 [simple_switch_g] <defunct>
root       26556  0.0  0.0   3540  2148 ?        S    21:30   0:00 grep simple_switch