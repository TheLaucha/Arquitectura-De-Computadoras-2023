.data
X: .word 5
Y: .word 10
A: .word 5
RES: .word 0

.code
LD r1, X(r0)
LD r2, Y(r0)
LD r3, A(r0)
# BEQZ r3, FIN
LOOP: DADDI r3, r3, -1
  BNEZ r3, LOOP
  DADD r1, r1, r2
FIN: SD r1, RES(r0)
HALT
