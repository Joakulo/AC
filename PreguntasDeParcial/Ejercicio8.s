.data
    TABLA:      .word   4,11,18,6,17,28,9,0,11,23,15,6,37,29,14
    MENOR:      .word   20
    MAYOR:      .word   10
    CANTIDAD:   .word   15
    TOTAL:      .word   0
    NUEVO:      .word   0

    .text
        daddi   $t1, $zero, 0           # Iterador TABLA
        daddi   $t2, $zero, 0           # Iterador NUEVO
        ld      $t3, CANTIDAD($zero)    # Cantidad de iteraciones en el loop
        ld      $s0, MAYOR($zero)       # Numero a comparar
        daddi   $s1, $zero, 0           # TOTAL

loop:   beqz    $t3, FIN
        daddi   $t3, $t3, -1
        ld      $t0, TABLA($t1)
        daddi   $t1, $t1, 8
        slt     $t4, $s0, $t0
        bnez    $t4, GRANDE
        j loop

GRANDE: sd      $t0, NUEVO($t2)
        daddi   $t2, $t2, 8
        daddi   $s1, $s1, 1
        j loop

FIN:    sd      $s1, TOTAL($zero)
    halt