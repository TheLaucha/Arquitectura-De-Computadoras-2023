.data
A: .word 3
B: .word 8
RES: .word 0

.code
LD r1, A(r0)
LD r2, B(r0)
DADD R3, r0, r0
LOOP: DADD r3, r3, r1
  DADDI r2, r2, -1
  BNEZ r2, LOOP
SD r3, RES(r0)  
HALT