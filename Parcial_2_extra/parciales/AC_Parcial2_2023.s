# .code
# DADDI R1, R0, 1
# LOOP: NOP
#   DADDI R1, R1, -1
#   BNEZ R1, LOOP
#   HALT

.data
a: .word 1, 3, 5, 1, 2
b: .word 7, 3, 9, 1, 5
c: .word 2, 8, 0, 1, 2
res: .word 0, 0, 0, 0, 0

.code
DADDI $sp, $sp, 0x400
DADDI $s0, $0, 5    # $s0 = contador
DADDI $s1, $0, a    # Dir de A
DADDI $s2, $0, b    # Dir de B
DADDI $s3, $0, c    # Dir de C
DADDI $s4, $0, 0    # $s4 direccion de arrays
LOOP: BEQZ $s0, TERMINO
  LD $a1, 0($s1)    # Cargo el dato A
  LD $a2, 0($s2)    # Cargo el dato B
  LD $a3, 0($s3)    # Cargo el dato C
  JAL calculo
  SD $v1, res($s4)
  DADDI $s0, $s0, -1
  DADDI $s1, $s1, 8
  DADDI $s2, $s2, 8
  DADDI $s3, $s3, 8
  DADDI $s4, $s4, 8
  J LOOP
TERMINO: HALT

calculo: DADDI $sp, $sp, -40
  SD $s0, 32($sp)
  SD $s1, 24($sp)
  SD $s2, 16($sp)
  SD $s3, 8($sp)
  SD $s4, 0($sp)
  # Calculo
  DADD $t0, $a1, $a2
  DMUL $t1, $a3, $a3
  DDIV $v1, $t0, $t1    # F6 es la variable de retorno
  # Retorno
  LD $s4, 0($sp)
  LD $s3, 8($sp)
  LD $s2, 16($sp)
  LD $s1, 24($sp)
  LD $s0, 32($sp)
  DADDI $sp, $sp, 40
  JR $ra