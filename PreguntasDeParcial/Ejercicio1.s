.data
    TABLA:  .word   1, 2, 3, 4, 5

.code
    daddi   R14, R0, 5
    dadd    R15, R0, R0
LOOP: sd     R15, TABLA(R15)
    daddi   R14, R14, -1
    daddi   R15, R15, 8
    bnez    R14, LOOP
halt