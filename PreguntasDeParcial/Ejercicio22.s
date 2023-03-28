.data
    CONTROL:  .word32    0x10000
    DATA:     .word32    0x10008
    MSJ:      .asciiz    "Ingrese un numero"
    N:        .word      12
    tabla1:   .double    0,1,2,3,4,5,6,7,8,9,10,11
    tabla2:   .double    0

    .text
        lw      $s0, CONTROL($zero)
        lw      $s1, DATA($zero)
        ld      $a0, N($zero)
        jal INGRESO

        daddi   $a0, $zero, tabla1
        daddi   $a1, $zero, tabla2
        ld      $a2, N($zero)
        jal POTENCIACION

halt

INGRESO: daddi   $t0, $zero, 4
        daddi   $t1, $zero, 8
        daddi   $t4, $zero, 0

        daddi   $t2, $zero, MSJ         
loop:   beqz    $a0, FIN
        daddi   $a0, $a0, -1

        sd      $t2, 0($s1)
        sd      $t0, 0($s0)             # Imprime el mensaje
        sd      $t1, 0($s0)             # Pide un numero
        ld      $t3, 0($s1)             
        sd      $t3, tabla1($t4)        # Lo guarda en memoria
        daddi   $t4, $t4, 8
        j loop      
FIN:    jr $ra


POTENCIACION: beqz    $a2, FIN2
        l.d     F1, 0($a0)
        mul.d   F1, F1, F1
        daddi   $a0, $a0, 8
        daddi   $a2, $a2, -1
        s.d     F1, 0($a1)
        daddi   $a1, $a1, 8
        j POTENCIACION
FIN2: halt
