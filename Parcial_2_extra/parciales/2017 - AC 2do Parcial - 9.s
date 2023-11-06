.data
# tabla1: .word 15,11,24
# tabla2: .word 0,0,0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
A: .word 0
B: .word 0
C: .word 0
RES: .word 0
msj: .asciiz "Ingrese 3 numeros enteros"

.code
# DADDI r1, r0, 0
# DADDI r2, r0, 3
# LOOP: LD r3, tabla1(r1)
# DADDI r3, r3, 1
# SD r3, tabla2(r1)
# DADDI r2, r2, -1
# BNEZ r2, LOOP
# DADDI r1, r1, 8
# HALT
# LWU $s6, CONTROL($0)
# LWU $s7, DATA($0)
# DADDI $t0, $0, 9
# SD $t0, 0($s6)
# LBU $t3, 0($s7)
LWU $s0, CONTROL($0)
LWU $s1, DATA($0)

# Imprimo msj
DADDI $t0, $0, msj
SD $t0, 0($s1)
DADDI $t0, $0, 4
SD $t0, 0($s0)

DADDI $a0, $0, A
JAL INGRESO_NUM
DADDI $a0, $0, B
JAL INGRESO_NUM
DADDI $a0, $0, C
JAL INGRESO_NUM

LD $a0, A($0)
LD $a1, B($0)
LD $a2, C($0)
JAL CALCULO
SD $v0, RES($0)

# Imprimo valor
DADDI $t0, $0, 6
SD $t0, 0($s0)
SD $v0, 0($s1)
DADDI $t0, $0, 1
SD $t0, 0($s0)

HALT

INGRESO_NUM: DADDI $t0, $0, 8
  SD $t0, 0($s0)
  LD $t1, 0($s1)
  SD $t1, 0($a0)
  JR $ra

CALCULO: DADDI $v0, $0, 0
  DSUB $t1, $a0, $a1
  DADDI $t0, $0, 1
LOOP: BEQZ $a2, TERMINO
  DMUL $t0, $t1, $t0
  DADDI $a2, $a2, -1
  J LOOP
TERMINO: DADD $v0, $v0, $t0
  JR $ra
