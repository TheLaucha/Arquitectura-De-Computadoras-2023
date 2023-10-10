.data
A: .word 5
B: .word 3
RES: .word 0

.code
LD r1, A(r0)
LD r2, B(r0)
DADD r3, r0, r0
LOOP: DADDI r2, r2, -1
  BNEZ r2, LOOP
DADD r3, r3, r1
SD r3, RES(r0)
HALT