.data
tabla1: .word 15,11,24
tabla2: .word 0,0,0

.code
DADDI r1, r0, 0
DADDI r2, r0, 3
LOOP: LD r3, tabla1(r1)
  DADDI r3, r3, 1
  SD r3, tabla2(r1)
  DADDI r2, r2, -1
  BNEZ r2, LOOP
  DADDI r1, r1, 8 
  HALT
