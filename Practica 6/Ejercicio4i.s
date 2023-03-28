.data
    CONTROL:    .word32     0x10000
    DATA:       .word32     0x10008
    MSJ:        .asciiz     "Ingrese la clave \n"
    BIEN:       .asciiz     " Bienvenido"
    ERROR:      .asciiz     " ERROR \n"
    CLAVE:      .asciiz     "1234"
    CADENA:     .asciiz     "a"

.text
    ld $s0, CONTROL($zero)
    ld $s1, DATA($zero)

DE_NUEVO: jal CHAR
    jal RESPUESTA

    bnez $v0, DE_NUEVO

halt

CHAR:   daddi $t0, $zero, MSJ   # $t0 = MSJ
    daddi $t1, $zero, 4         # $t1 = 4
    daddi $t2, $zero, 9         # $t2 = 9
    daddi $t4, $zero, 0         # $t4 = 0 (iterador guardado en memoria)
    daddi $t5, $zero, 4

    sd $t0, 0($s1)              # Imprime el mensaje
    sd $t1, 0($s0)

loop: sd $t2, 0($s0)            # Lee un caracter
    lb $t3, 0($s1)              # Guarda el caracter en $t3
    sb $t3, CADENA($t4)         # Guarda el caracter en memoria

    daddi $t3, $t4, CADENA      # Imprimo el caracter ingresado
    sd $t3, 0($s1)
    sd $t1, 0($s0)

    daddi $t4, $t4, 1           # Iterador de memoria++
    daddi $t5, $t5, -1          # Iterador del loop--
    bnez  $t5, loop

jr $ra


RESPUESTA: ld $t6, CLAVE($zero)
    ld $t7, CADENA($zero)
    slt $v0, $t6, $t7
    bnez $v0, MAL
    slt $v0, $t7, $t6
    bnez $v0, MAL

    daddi $t0, $zero, BIEN
    sd $t0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0)

    j FIN

    MAL: daddi $t0, $zero, ERROR
    sd $t0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0)
    
    daddi $t0, $zero, 0
    sd $t0, CADENA($zero)

FIN: jr $ra
