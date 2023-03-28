.data
    CONTROL:  .word32 0x10000
    DATA:     .word32 0x10008
    MSJ:      .asciiz "Ingrese un caracter: "
    MSJ2:     .asciiz "El caracter ingresado no es un numero"
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
    CARACTER: .asciiz ""

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

#___________________________Ingreso un caracter
    jal INGRESO
    dadd $s2, $v0, $zero        # Muevo el caracter a $s2

#___________________________Analizo si es un numero o no
    daddi $t2, $zero, 1         # Va a comparar al final si en algun caso slt = 1
    slti $t0, $s2, 0x30         # Comparo con 0x30 = 0
    daddi $t1, $zero, 0x39      
    slt $t0, $t1, $s2           # Comparo con 0x39 = 9
    beq $t0, $t2, MAL           # Si $t0 y $t2 son iguales, quiere decir que algun slt dio 1

    daddi $a0, $zero, CERO
    daddi $a1, $s2, 0
    jal IMPRIME

FIN: halt

MAL: daddi $t0, $zero, MSJ2
    sd $t0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0)
j DE_NUEVO

INGRESO: daddi $t0, $zero, 9
    sd $t0, 0($s0)              # Se lee un caracter por teclado
    lb $v0, 0($s1)              # Cargo el caracter en $v0 para devolverlo de la subrutina

#___________________________Imprimo el caracter leido en pantalla
    sd $v0, CARACTER($zero)
    daddi $t0, $zero, CARACTER
    sd $t0, 0($s1)              # Muevo el caracter a DATA
    daddi $t0, $zero, 4
    sd $t0, 0($s0)              # Imprimo DATA

jr $ra

IMPRIME:    daddi $t0, $zero, 0
    daddi $t1, $zero, 0
    daddi $a1, $a1, -0x30       # Le resta 0x30 al caracter para dejarlo en formato decimal
    loop: beq $t0, $a1, IMP     # Mientras que el caracter no llegue a 0
        daddi $a1, $a1, -1
        daddi $a0, $a0, 8
    j loop

    IMP: sd $a0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0)
jr $ra