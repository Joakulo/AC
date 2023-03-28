.data
    CONTROL: .word32 0x10000
    DATA:    .word32 0x10008
    MSJ:     .asciiz "Ingrese un numero: \n"
    MSJ2:    .asciiz "El numero ingresado no es de un digito \n"
    NUM1:    .word   0
    NUM2:    .word   0
    RES:     .asciiz "1"

.text
    ld $s0, CONTROL($zero)      # $s0 = CONTROl
    ld $s1, DATA($zero)         # $s1 = DATA


# PRIMER NUMERO
#___________________________Ingresa el numero y lo guarda en memoria
DE_NUEVO1: daddi $a0, $zero, 0
    jal INGRESO
    daddi $a0, $v0, 0
    jal CHEQUEO
    bnez  $v0, DE_NUEVO1


#SEGUNDO NUMERO
#___________________________Ingresa el numero y lo guarda en memoria
DE_NUEVO2: daddi $a0, $zero, 8
    jal INGRESO
    daddi $a0, $v0, 0
    jal CHEQUEO
    bnez  $v0, DE_NUEVO2


#___________________________Una vez ingresados los numeros, se suma y se imprime
    ld $a0, NUM1($zero)
    ld $a1, NUM2($zero)
    jal RESULTADO 

halt

INGRESO:   daddi $t0, $zero, MSJ    # Imprime el mensaje      
    sd $t0, 0($s1)
    daddi $t0, $zero, 4
    sd $t0, 0($s0) 

    daddi $t0, $zero, 8
    sd $t0, 0($s0)              # Se lee un numero por teclado
    ld $v0, 0($s1)              # Cargo el numero en $v0 para devolverlo de la subrutina
    sd $v0, NUM1($a0)

#___________________________Imprimo el numero en pantalla
    # daddi $t0, $zero, NUM1
    # dadd $t0, $t0, $a0      
    # sd $t0, 0($s1)              # Muevo la direccion del numero a DATA
    # daddi $t0, $zero, 4
    # sd $t0, 0($s0)              # Imprimo DATA
jr $ra

#___________________________Cargo en $s2 el resultado
RESULTADO: dadd $s2, $a0, $a1
    daddi $t1, $zero, 0
    slti $t0, $s2, 10           # slti = 1 si $s2 < 10
    bnez $t0, IMP               # si slti = 1, imprime directamente

    daddi $s2, $s2, -10         # si slti = 0, le resta 10 para hacerlo de un digito
    daddi $t1, $t1, 1

IMP:  daddi $s2, $s2, 0x30      # Convierte el resultado en un caracter
    sb $s2, RES($t1)            # Guardo el resultado en memoria
    daddi $t0, $zero, RES
    sd $t0, 0($s1)              # Muevo la direccion del resultado a DATA
    daddi $t0, $zero, 4
    sd $t0, 0($s0)              # Imprimo el resultado
jr $ra

CHEQUEO:     daddi $t2, $zero, 10
    slt   $t0, $t2, $a0         # Chequeo si es mayor a 10
    bnez  $t0, MAL              # si slti = 1, esta fuera del rango
    slti  $t0, $a0, 0           # Chequeo si es menor a 0
    bnez  $t0, MAL              # si slti = 1, esta fuera del rango
    dadd $v0, $zero, $t0        # si slti = 0, es positivo de un digito
    j FIN

MAL:    daddi $t1, $zero, MSJ2
    sd $t1, 0($s1)
    daddi $t1, $zero, 4
    sd $t1, 0($s0)
    dadd $v0, $zero, $t0

FIN: jr $ra