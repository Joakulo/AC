.data
    VECTOR:     .word   1234, 2345, 3546, 4567, 5678
    NUEVO:      .word   0

    .text
        daddi   $t1, $zero, 0
        daddi   $t2, $zero, 5

loop:   ld      $t0, VECTOR($t1)
        daddi   $t2, $t2, -1
        daddi   $t0, $t0, +1
        sd      $t0, NUEVO($t1)
        daddi   $t1, $t1, 8
    bnez    $t2, loop

    halt