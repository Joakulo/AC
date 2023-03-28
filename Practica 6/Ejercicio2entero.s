.data
    CONTROL:  .word32 0x10000
    DATA:     .word32 0x10008
    MSJ:      .asciiz "Ingrese un numero: "
    MSJ2:     .asciiz "El numero ingresado no es de un digito \n"
    CERO:     .asciiz "Cero"
    UNO:      .asciiz "Uno"
    DOS:      .asciiz "Dos"
    TRES:     .asciiz "Tres"
    CUATRO:   .asciiz "Cuatro"
    CINCO:    .asciiz "Cinco"
    SEIS:     .asciiz "Seis"
    SIETE:    .asciiz "Siete"
    OCHO:     .asciiz "Ocho"
    NUEVE:    .asciiz "Nueve"
    DIGITO:   .byte   0

.text
    lwu $s0, CONTROL($zero)     # $s0 = Direccion de CONTROL
    lwu $s1, DATA($zero)        # $s1 = Direccion de DATA

    daddi $t0, $zero, 6
    sd $t0, 0($s0)              # Limpio la pantalla

#___________________________Imprimo el mensaje en pantalla
DE_NUEVO:    daddi $t0, $zero, MSJ       
    sd $t0, 0($s1)              # Envio la direccion del mensaje a DATA
    daddi $t0, $zero, 4
    sd $t0, 0($s0)              # Imprimo lo que hay en DATA

#___________________________Ingreso un digito
    jal INGRESO
    dadd $s2, $v0, $zero        # Muevo el digito a $s2

#___________________________Analizo si es de un digito o no
    daddi $t1, $zero, 10 
    slti $t0, $s2, 0            # Comparo con 0
    bnez $t0, MAL
    slt $t0, $t1, $s2           # Comparo con 10
    bnez $t0, MAL           

    daddi $a0, $zero, CERO
    daddi $a1, $s2, 0
    jal IMPRIME

FIN: halt

MAL: daddi $t0, $zero, MSJ2
    sd $t0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0)
j DE_NUEVO

INGRESO: daddi $t0, $zero, 8
    sd $t0, 0($s0)              # Se lee un numero por teclado
    lb $v0, 0($s1)              # Cargo el numero en $v0 para devolverlo de la subrutina

#___________________________Imprimo el numero leido en pantalla
    sd $v0, DIGITO($zero)
    daddi $t0, $zero, DIGITO
    sd $t0, 0($s1)              # Muevo el numero a DATA
    daddi $t0, $zero, 4
    sd $t0, 0($s0)              # Imprimo DATA

jr $ra

IMPRIME:    daddi $t0, $zero, 0
    loop: beq $t0, $a1, IMP     # Mientras que el digito no llegue a 0
        daddi $a1, $a1, -1
        daddi $a0, $a0, 8
    j loop

    IMP: sd $a0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0)
jr $ra