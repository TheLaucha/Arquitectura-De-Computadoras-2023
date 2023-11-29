.data
TABLA: .word 4,11,18,6,17,28,9
MAYOR: .word 15
CANTIDAD: .word 7
NUEVO: .word 0

.code
DADDI $t0, $0, 0
LD $t1, CANTIDAD($0)
LD $t2, MAYOR($0)
DADD $t3, $0, $0
DADD $t4, $0, $0
LOOP: LD $t5, TABLA($t0)
  SLT $t6, $t2, $t5
  BEQZ $t6, ES_MENOR
  DADDI $t3, $t3, 1
  SD $t5, NUEVO($t4)
  DADDI $t4, $t4, 8
ES_MENOR: DADDI $t1, $t1, -1
  DADDI $t0, $t0, 8
  BNEZ $t1, LOOP
  SD $t3, CANTIDAD($0)
  HALT