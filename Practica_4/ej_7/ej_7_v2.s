.data
TABLA: .word 1,2,3,4,5,6,7,8,9,10
X: .word 5
CANT: .word 0
RES: .word 0

.code
DADDI r1, r0, -8 # R1 -> Puntero para la tabla y resultado
DADDI r2, r0, 80 # R2 ->
LD r3, X(r0)     # R3 -> Valor X
DADDI r4, r0, 1  # R4 -> Valor a guardar si es mayor
LD r5, CANT(r0)  # R5 -> Cantidad de numeros mayores que X

LOOP: DADDI r1, r1, 8
  BEQ r1, r2, FIN # Si R1 == R2 entonces llego a 80 que seria el final de numeros.
  LD r10, TABLA(r1) # R10 -> Tiene el numero Actual de la tabla
  SLT r11, r3, r10  # Si r3(X) <= r10
  BNE r11, r4, LOOP
  DADDI r5, r5, 1
  SD r4, RES(r1)
  J LOOP
FIN: SD r5, CANT(r0)
halt