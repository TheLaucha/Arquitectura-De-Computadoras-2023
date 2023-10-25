.data
car: .asciiz "b"
vocales: .asciiz "aAeEiIoOuU"
res: .word 5

.code
LBU $a0, car($zero)
DADDI $a1, $zero, vocales
JAL ES_VOCAL
SD $v0, res($zero)
HALT

ES_VOCAL: DADDI $v0, $0, 0
loop: LBU $t1, 0($a1)
  BEQ $t1, $a0, encontreVocal
  DADDI $a1, $a1, 1
  BEQZ $a1, termino
  J loop
encontreVocal: DADDI $v0, $0, 1
termino: JR $ra