.data
TABLA1: .word 21,12,5,16,8,39,10,41,4,33
TABLA2: .word 32,24,15,32,17,28,11,20,44,21
ROJO: .byte 255,0,0,0
VERDE: .byte 0,255,0,0
CONTROL: .word 0x10000
DATA: .word 0x10008

.code
LD $s0, CONTROL($zero)
LD $s1, DATA($zero)
LD $s6, ROJO($zero)
LD $s7, VERDE($zero)
daddi $a0, $zero, TABLA1
daddi $a1, $zero, 9
JAL MIN_MAX
daddi $a1, $zero, 9
dadd $s2, $zero, $v1 
dadd $s3, $zero, $v0
daddi $a0, $zero, TABLA2
JAL MIN_MAX
dadd $s4, $zero, $v1
dadd $s5, $zero,$v0

daddi $t5, $zero, 5

sd $s6, 0($s1)
sb $s3, 5($s1)
sb $s4, 4($s1)
sb $t5, 0($s0)

sd $s7, 0($s1)
sb $s5, 5($s1)
sb $s2, 4($s1)
sb $t5,0($s0)

halt



MIN_MAX: ld $v1,0($a0)          #min
ld $v0,0($a0)                   #max
LOOP: beqz $a1, Fin
    ld $t4, 0($a0)
    slt $t3, $v0, $t4
    beqz $t3, Seguir
    daddi $v0, $t4, 0
Seguir: slt $t3, $v1, $t4
    beqz $t3, Seguir2
    daddi $v1, $t4, 0
Seguir2: daddi $a0, $a0, 8
    daddi $a1, $a1, -1
    j LOOP
Fin: jr $ra