.data
valor: .word 10
result: .word 0

.code
daddi $sp, $zero, 0x400
ld $a0, valor($0)
JAL factorial
sd $v0, result($0)
HALT

factorial: DADDI $sp, $sp, -16
  SD $ra, 0($sp)
  SD $s0, 8($sp)

  BEQZ $a0, FIN_RECURSIVO
  DADD $s0, $0, $a0     # Tomo el valor actual
  DADDI $a0, $a0, -1

  JAL factorial
  DMUL $v0, $v0, $s0   # $v0 x numActual
  J FIN

FIN_RECURSIVO: DADDI $v0, $0, 1
FIN: LD $s0, 8($sp)
  LD $ra, 0($sp)
  DADDI $sp, $sp, 16
  JR $ra
  