.data
texto: .asciiz ""
CONTROL: .word32 0x10000
DATA: .word32 0x10008

.code
lwu $s0, DATA($zero)      

lwu $s1, CONTROL($zero)
DADDI $t0, $zero, 6
SD $t0, 0($s1)

DADDI $t0, $zero, 9
sd $t0, 0($s1)

LBU $t1, 0($s0)
SB $t1, texto($0)

DADDI $t0, $zero, texto
sd $t0, 0($s0)

DADDI $t0, $zero, 4
SD $t0, 0($s1)

HALT