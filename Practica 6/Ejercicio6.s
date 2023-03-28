.data 
    coorX: .byte 0 ; coordenada X de un punto 
    coorY: .byte 0 ; coordenada Y de un punto 
    color: .byte 0, 0, 0, 0 ; color: máximo rojo + máximo azul => magenta 
    CONTROL: .word32 0x10000 
    DATA:  .word32 0x10008
    MSJX:   .asciiz "Ingrese coordenada X: "
    MSJY:   .asciiz "Ingrese la coordenada Y: "
    MSJR:   .asciiz "Ingrese el valor de Rojo: "
    MSJG:   .asciiz "Ingrese el valor de Verde:"
    MSJB:   .asciiz "Ingrese el valor de Azul: "

 
.text 
    lwu     $s0, CONTROL($zero)     ; $s6 = dirección de CONTROL 
    lwu     $s1, DATA($zero)        ; $s7 = dirección de DATA 
    
    daddi   $t0, $zero, 7           ; $t0 = 7 -> función 7: limpiar pantalla gráfica 
    sd      $t0, 0($s0)             ; CONTROL recibe 7 y limpia la pantalla gráfica 
    daddi   $t0, $zero, 6           ; $t0 = 6 -> función 6: limpiar pantalla alfanumerica 
    sd      $t0, 0($s0)             ; CONTROL recibe 6 y limpia la pantalla alfanumerica

    daddi   $t4, $zero, 4
    daddi   $t5, $zero, 8

    daddi   $t0, $zero, MSJR
    sd      $t0, 0($s1)             ; Carga el mensaje en DATA
    sd      $t4, 0($s0)             ; Imprime el mensaje
    sd      $t5, 0($s0)             ; Pide un entero
    lbu     $t0, 0($s1)
    sb      $t0, color($zero)
    
    daddi   $t0, $zero, MSJG
    sd      $t0, 0($s1)             ; Carga el mensaje en DATA
    sd      $t4, 0($s0)             ; Imprime el mensaje
    sd      $t5, 0($s0)             ; Pide un entero
    lbu     $t0, 0($s1)
    daddi   $t1, $zero, 1
    sb      $t0, color($zero)

    daddi   $t0, $zero, MSJB
    sd      $t0, 0($s1)             ; Carga el mensaje en DATA
    sd      $t4, 0($s0)             ; Imprime el mensaje
    sd      $t5, 0($s0)             ; Pide un entero
    lbu     $t0, 0($s1)
    daddi   $t1, $t1, 1
    sb      $t0, color($zero)

    daddi   $t0, $zero, MSJX
    sd      $t0, 0($s1)
    sd      $t4, 0($s0)
    sd      $t5, 0($s0)
    lbu     $t0, 0($s1)
    sb      $t0, coorX($zero)

    daddi   $t0, $zero, MSJY
    sd      $t0, 0($s1)
    sd      $t4, 0($s0)
    sd      $t5, 0($s0)
    lbu     $t0, 0($s1)
    sb      $t0, coorY($zero)

    lbu     $t0, coorX($zero)       ; $s0 = valor de coordenada X 
    sb      $t0, 5($s1)             ; DATA+5 recibe el valor de coordenada X 
    lbu     $t0, coorY($zero)       ; $s1 = valor de coordenada Y 
    sb      $t0, 4($s1)             ; DATA+4 recibe el valor de coordenada Y 
    
    lwu     $t0, color($zero)       ; $s2 = valor de color a pintar 
    sw      $t0, 0($s1)             ; DATA recibe el valor del color a pintar 
    
    daddi   $t0, $zero, 5           ; $t0 = 5 -> función 5: salida gráfica 
    sd      $t0, 0($s0)             ; CONTROL recibe 5 y produce el dibujo del punto 
halt