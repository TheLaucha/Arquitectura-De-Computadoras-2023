.data
cad1: .asciiz "hola"
cad2: .asciiz "hola"
result: .word 0

.code
DADDI $a0, $0, cad1       # Carga la dir de cad1
DADDI $a1, $0, cad2       # Carga la dir de cad2
JAL compara               
sd $v0, result($zero)
halt

compara: DADD $v0, $0, $0   # Inicializa $v0 en 0
loop: lbu $t0, 0($a0)       # Carga el primer elemento de cad1
  lbu $t1, 0($a1)           # Carga el primer elemento de cad2
  beqz $t0, fin_a0          # Si $t0 == 0 salta a fin_a0 --> En que momento $t0 puede llegar a ser 0 =
  beqz $t1, final           # Si $t1 == 0 salta a final, esto significa que $t0 tiene mas caracteres y esa es la diferencia.
  BNE $t0, $t1, final       # Si no son iguales va a final
  DADDI $v0, $v0, 1         # Avanza en la pos
  DADDI $a0, $a0, 1         # Avanza en la cadena 1
  DADDI $a1, $a1, 1         # Avanza en la cadena 2
  J loop
fin_a0: bnez $t1, final     # Si $t1 <> 0 voy a final ya que se analizaron todos los caracteres y hubo diferencias en el ultimo
  DADDI $v0, $0, -1         # Sino, estoy significa que no hay mas caracteres en $t1 entonces es identico
final: JR $ra               