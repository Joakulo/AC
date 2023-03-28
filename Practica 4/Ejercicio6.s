.data
    A: .word 1
    B: .word 1
    C: .word 1
    D: .word 0

.code
    ld R1, A(R0) 
    ld R2, B(R0) 
    ld R3, C(R0)
    ld R4, D(R0)

    
    bne R1, R2, continuar
    DADDI R4, R4, 2
    bne R1, R3, TERMINAR
    DADDI R4, R4, 1
    j TERMINAR

    continuar: bne R1, R3, continuar2
    DADDI R4, R4, 2
    bne R3, R2, TERMINAR
    DADDI R4, R4, 1
    j TERMINAR

    continuar2: bne R2, R3, TERMINAR
    DADDI R4, R4, 2

    TERMINAR: sd R4, D(R0)


    FIN: HALT