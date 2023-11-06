.data
tabla: .word 1,2,3,4,5,6,7,8,0
res: .word 0
MASCARA: .byte 00000001

.code
DADDI $sp, $0, 0x400
DADDI $a0, $0, tabla
JAL analizar
SD $v0, res($0)
HALT

analizar: DADDI $sp, $sp, -8
  SD $ra, 0($sp)
  DADDI $v0, $0, 0          # Inicializo el contador en 0
loop: LD $a1, 0($a0)        # Cargo el numero
  BEQ $a1, $0, termino
  JAL ES_IMPAR
  BEQZ $v1, ES_PAR
  DADDI $v0, $v0, 1
ES_PAR: DADDI $a0, $a0, 8   # Avanzo en la tabla
  J loop
termino: LD $ra, 0($sp)
  DADDI $sp, $sp, 8
  JR $ra

ES_IMPAR: DADDI $v1, $0, 0
  LD $t0, MASCARA($0)       # Cargo la mascara
  AND $t1, $a1, $t0
  BEQZ $t1, PAR
  DADDI $v1, $0, 1
PAR: JR $ra
  

