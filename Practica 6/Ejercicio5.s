.data
    CONTROL:    .word32     0X10000
    DATA:       .word32     0x10008
    MSJ:        .asciiz     "Ingrese una base "
    MSJ2:       .asciiz     "Ingrese un exponente "
    NUM:        .double     0.0
    EXPONENTE:   .word       0
    RES:        .double     0.0

.text
    ld $s0, CONTROL($zero)
    ld $s1, DATA($zero)

    daddi $t1, $zero, 4
    daddi $t2, $zero, 8
    daddi $t0, $zero, MSJ
    daddi $t3, $zero, MSJ2

#_________________________Pide la base
    sd $t0, 0($s1)          # Ingresa el mensaje en DATA
    sd $t1, 0($s0)          # Imprime
    sd $t2, 0($s0)          # Pide una base por teclado
    l.d F1, 0($s1)          # Guarda el numero en F1
    s.d F1, NUM($zero)      # Guarda la base en memoria

#_________________________Pide el exponente
    sd $t3, 0($s1)          # Ingresa el mensaje 2 en DATA
    sd $t1, 0($s0)          # Imprime
    sd $t2, 0($s0)          # Pide un exponente por teclado
    ld $a0, 0($s1)          # Guarda el numero en $a0
    sd $a0, EXPONENTE($zero) # Guarda el exponente en memoria

    jal A_LA_EXPONENTE

#_________________________Imprime el resultado
    l.d F1, RES($zero)   
    s.d F1, 0($s1)
    daddi $t0, $zero, 3
    sd $t0, 0($s0)

halt

A_LA_EXPONENTE: slti $t0, $a0, 0
    bnez $t0, RARI
    bnez $a0, NORMAL   # Si el exponente es !=0 se ejecuta normal 
    
    daddi $v0, $zero, 1     # Se inicializa $t0 en 1
    mtc1 $v0, F2            # Se pasa el 1 a F2. (base^0)
    cvt.d.l F2, F2
    j FIN

RARI: daddi $t0, $zero, -1
    dmul $a0, $a0, $t0
    add.d F2, F0, F1        # Carga la base en F2
loopr: mul.d F2, F2, F1      # Multiplica el resultado actual por el valor inicial
    daddi $a0, $a0, -1      # Iterador--
    bnez $a0, loopr
    div.d F2, F1, F2
    j FIN

NORMAL: add.d F2, F0, F1    # Carga la base en F2
    daddi $a0, $a0, -1
loop: mul.d F2, F2, F1      # Multiplica el resultado actual por el valor inicial
    daddi $a0, $a0, -1      # Iterador--
    bnez $a0, loop

FIN: s.d F2, RES($zero)      # Guarda el valor en memoria
jr $ra