.data
CONTROL: .word 0x10000
DATA: .word 0x10008
COLOR: .byte 13, 0, 127, 0, 0, 0, 0, 0

.code
LD $s0, CONTROL($0)
LD $s1, DATA($0)
LD $s2, COLOR($0)


DADDI $t0, $0, 0
DADDI $t2, $0, 50


loop:   SD $s2, 0($s1)
	DADDI $t1, $0, 5
	SD $t1, 0($s0)
	DADDI $t0, $t0, 1
	LB $t4, 5 ($s2)
	DADDI $t4, $t4, 1
	SB $t4, 5 ($s2)
	BNE $t0, $t2, loop
	HALT