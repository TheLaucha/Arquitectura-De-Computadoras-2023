.data
cad1: .asciiz "holamundo"
cad2: .asciiz "holamundo"
pos: .word -1

.code
DADDI $a0, $0, cad1 
DADDI $a1, $0, cad2
JAL analizar
slti $t0, $v0, 0
BNEZ $t0, fin
SD $v0, pos($0)
fin: halt

analizar: DADDI $v0, $0, 0 # Inicializo la variable de retorno
loop: LBU $t0, 0($a0)
  LBU $t1, 0($a1)
  BEQZ $t0, termino         # Termino porque la cadena llego a 0
  BEQZ $t1, termino         # Termino porque la cadena llego a 0
  BEQ $t0, $t1, sigo
  J termino
sigo: DADDI $v0, $v0, 1         # Incremento la pos
  DADDI $a0, $a0, 1         # Avanzo en la cadena
  DADDI $a1, $a1, 1         # Avanzo en la cadena
  J loop
termino: JR $ra
