.data
car: .asciiz "I"
vocales: .asciiz "aAeEiIoOuU"
res: .word 5

.code
LBU $a0, car($zero)
DADDI $a1, $zero, vocales
JAL ES_VOCAL
SD $v0, res($zero)
HALT

ES_VOCAL: DADDI $v0, $0, 0      # Inicializo la variable retorno en 0
loop: LBU $t1, 0($a1)
  BEQZ $t1, termino             # Si llego al final termino
  BEQ $t1, $a0, encontreVocal
  DADDI $a1, $a1, 1             # Avanzo en la tabla
  J loop
encontreVocal: DADDI $v0, $0, 1
termino: JR $ra