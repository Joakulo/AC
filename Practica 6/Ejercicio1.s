.data
    CONTROL: .word32 0x10000
    DATA: .word32 0x10008
    texto: .asciiz "a"

.text
    lwu $s0, CONTROL($zero)     # $s0 = direccion de CONTROL
    lwu $s1, DATA($zero)        # $s1 = direccion de DATA
    daddi $t1, $zero, 13        # $t1 = "Enter" en ascii
    daddi $t2, $zero, 0         # $t2 = iterador
    daddi $t3, $zero, 9         # $t3 = se usa el 9 para la lectura de un caracter en CONTROL

    loop: beq $t0, $t1, FIN     # Si el caracter ingresado es igual a "Enter" (13), salta a FIN

    sb $t3, 0($s0)              # Pasa $t3 (9) a CONTROL = Lee un caracter

    lb $t0, 0($s1)              # Lo que se escribio en DATA se guarda en $t0
    sb $t0, texto($t2)          # Guarda en texto el caracter leido
    daddi $t2, $t2, 1           # Suma 1 al iterador

    j loop

    FIN: daddi $t4, $zero, texto   # $t4 = direccion de texto
    sd $t4, 0($s1)              # guarda la direccion de texto en DATA

    daddi $t3, $zero, 4         # $t3 = 4 despues se mueve a CONTROL    
    sb $t3, 0($s0)              # 4 en CONTROL = imprime
halt