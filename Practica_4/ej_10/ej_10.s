.data
cadena: .asciiz "adbdcdedfdgdhdid"
finCadena: .asciiz "?"
car: .asciiz "d"
cant: .word 0

.code
DADDI r4, r0, 0           # R4 -> Contador
LBU r2, car(r0)           # R2 -> Caracter a buscar
LBU r5, finCadena(r0)     # R5 -> Fin de cadena
DADDI r3, r3, 0           # R3 -> Puntero de cadena
LOOP: LBU r1, cadena(r3)  # R1 -> Caracter actual
  BEQ r1, r5, TERMINO     # Si r1 == r5 -> Termino
  BNE r1, r2, NO_ES_IGUAL # 
  DADDI r4, r4, 1
NO_ES_IGUAL: DADDI r3, r3, 1
  J LOOP
TERMINO: SD r4, cant(r0)
HALT