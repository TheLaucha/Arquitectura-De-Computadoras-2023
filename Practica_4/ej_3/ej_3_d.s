.data
A: .word 1
B: .word 3
tabla: .space 12

.code
ld r2, B(r0)
ld r1, A(r0)
daddi r3, r0, 0
loop: daddi r2, r2, -1
dsll r1, r1, 1
sd r1, tabla(r3)
daddi r3, r0, 4
bnez r2, loop
halt