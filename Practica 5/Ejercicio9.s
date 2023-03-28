.data
caracter: .ascii "n"
tabla: .asciiz "aeiou"
.code
lb $a0, caracter($zero)
jal ES_VOCAL
halt

ES_VOCAL: dadd $t0, $zero, $a0 ; Traigo caracter
dadd $t1, $zero, $zero ; Variable indice -> permite acceder a cada vocal en tabla
daddi $t4, $zero, 0x20 
dadd $v0, $zero, $zero ; Valor de retorno, se supone que el caracter ingresado es vocal
loop: lb $t2, tabla($t1)
daddi $t1, $t1, 1
nop
beqz $t2, fin 
beq $t0, $t2, cumple
dsub $t2, $t2, $t4 ; Convierte caracter a mayuscula
nop
bne $t0, $t2, no_cumple
beq $t0, $t2, cumple
j loop
no_cumple: j loop
cumple: daddi $v0, $zero, 1
fin: jr $ra
