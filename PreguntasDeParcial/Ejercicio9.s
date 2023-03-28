.data
    A:  .word   3
    B:  .word   5
    C:  .word   0

    .text
        ld      R1, A(R0)
        ld      R2, B(R0)
        dadd    R3, R0, R0
lazo:   dadd    R3, R3, R2
        daddi   R1, R1, -1
        bnez    R1, lazo
        sd      R3, C(R0)
    HALT