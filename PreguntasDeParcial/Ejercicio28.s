.code
    DADDI   R1, R0, 1
    DADDI   R2, R0, 2
    DADD    R3, R0, R0
    BEQ R1, R2, LISTO
    BNE R1, R2, FIN
    J FIN
LISTO:    DADDI R3, R0, 1
FIN: HALT