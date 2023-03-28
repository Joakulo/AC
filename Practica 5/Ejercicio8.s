.data ; Con Forwarding y BTB
A: .asciiz "Hola Mundo"
B: .asciiz "Hola Mundo"
.code
daddi $a0, $zero, A
daddi $a1, $zero, B
jal donde_difieren
halt

donde_difieren: 
    dadd $t0, $zero, $zero ; pos del caracter
    daddi $v0, $zero, -1
    loop: 
        lb $t1, 0($a0)
        daddi $t0, $t0, 1
        lb $t2, 0($a1)
        daddi $a0, $a0, 1
        daddi $a1, $a1, 1
        bne $t1, $t2, distintos
        beqz $t1, fin
        beqz $t2, fin
    j loop
    distintos: dadd $v0, $zero, $t0
fin: jr $ra