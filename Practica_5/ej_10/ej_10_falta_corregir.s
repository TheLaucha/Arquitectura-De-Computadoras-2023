.data
cad: .asciiz "averiguando"
vocales: .asciiz "aAeEiIoOuU"
res: .word 0

.code
DADDI $sp, $0, 0x400
DADDI $a0, $0, cad                # Dir de inicio de la cadena
DADDI $a1, $0, vocales            # Dir de inicio de vocales
JAL CONTAR_VOC
SD $v0, res($0)
HALT

CONTAR_VOC: DADDI $sp, $sp, -24    # Reserva tres lugares en la pila
  SD $ra, 0($sp)                  # Guarda en la pila $ra
  SD $s0, 8($sp)
  SD $s1, 16($sp)
  DADD $s0, $a0, $0               # Copio la dir de inicio de la cadena
  DADD $s1, $a1, $0               # Copio la dir de cad de vocales
  DADDI $v0, $0, 0                # Inicializo el contador en 0
LOOP: LBU $a0, 0($s0)             # Cargo un caracter
  BEQZ $a0, termina               # Si es igual a 0 termina
  JAL ES_VOCAL
  BNEZ $v1, noEsVocal
  DADDI $v0, $v0, 1               # Sumo 1 al contador de vocales
noEsVocal: DADDI $s0, $s0, 1
  J LOOP
termina: LD $ra, 0($sp)
  LD $s0, 8($sp)
  LD $s1, 16($sp)
  DADDI $sp, $sp, 24
  JR $ra

ES_VOCAL: DADDI $v1, $0, 0
  DADDI $sp, $sp, -8
  SD $s1, 0($sp)
loop2: LBU $t0, 0($s1)            # Cargo primer vocal
  BEQZ $t0, noEncontreVocal
  BEQ $a0, $t0, encontreVocal
  DADDI $s1, $s1, 1               # Avanzo en la tabla
  J loop2
encontreVocal: DADDI $v1, $0, 1
noEncontreVocal:  LD $s1, 0($sp)
  DADDI $sp, $sp, 8
  JR $ra