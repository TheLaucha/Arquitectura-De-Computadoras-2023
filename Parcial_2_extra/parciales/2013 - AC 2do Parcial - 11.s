.data
A: .word 3
B: .word 5
C: .word 0

.code
#ld r1, A(r0)
#ld r2, B(r0)
#dadd r3, r0, r0
#lazo: daddi r1, r1, -1 
#dadd r3, r3, r2
#bnez r1, lazo
#sd r3, C(r0)
#halt

# ld r1, A(r0)
# ld r2, B(r0)
# dadd r3, r0, r0
# dadd r3, r3, r2
# daddi r1, r1, -1 
# dadd r3, r3, r2
# daddi r1, r1, -1 
# dadd r3, r3, r2
# daddi r1, r1, -1 
# sd r3, C(r0)
# halt

ld r1, A(r0)
ld r2, B(r0)
dadd r3, r0, r0
lazo: dadd r3, r3, r2 
bnez r1, lazo
daddi r1, r1, -1 
sd r3, C(r0)
halt