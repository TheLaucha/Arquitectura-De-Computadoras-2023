.data
M: .word 5
tabla: .word 1,2,8,10,3
cant: .word 5
res: .word 0

.code
ld $a0, M($zero)      # $a0 = 5
DADDI $a1, $0, tabla  # $a1 = DIR tabla
ld $a2, cant($zero)   # $a2 = 5
JAL analizar
SD $v0, res($zero)
halt

analizar: DADDI $v0, $zero, 0   # Inicializo $v0
loop: ld $t1, 0($a1)           # Copio en el registro temporal el primer elemento de la tabla
  BEQ $t1, $a0, sigo            # Si $t1 == $a0 no incremenento y sigo
  slt $t0, $t1, $a0             # Si $t1 < $a0, entonces dejo 1 en $t0
  BNEZ $t0, sigo                # Si $t0 <> 0 no incremento y sigo 
  DADDI $v0, $v0, 1
sigo: DADDI $a2, $a2, -1        # Decremento el contador de elementos
  DADDI $a1, $a1, 8             # Avanzo en la tabla
  BNEZ $a2, loop             
  JR $ra