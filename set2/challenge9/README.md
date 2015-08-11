##PKCS#7 Padding

The input length is a multiple of k octets, where k is greater than one.

___The input shall be padded at the trailing end with k-(lth mod k) octets all having value k-(lth mod k), where lth is the length of the input.___

          01 -- if lth mod k = k - 1
       02 02 -- if lth mod k = k - 2
    03 03 03 -- if lth mod k = k - 3
           .
           .
           .
    k... k k -- if lth mod k = 0


The padding can be remove unambiguously since all input is padded, including input values that are alreadt a multiple pf the block size, and no padding string is a suffix of another. This padding method is well defined if and only if k is less than 256.






