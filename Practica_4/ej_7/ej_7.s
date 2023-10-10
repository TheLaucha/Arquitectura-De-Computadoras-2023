.data
X: .word 5
TABLA: .word 1,2,3,4,5,6,7,8,9,10
CANT: .word 0
RES: .space 40

.code
ld r1, TABLA(r0)
ld r2, X(r0)
ld r3, CANT(r0)
dadd r4, r0, r0
daddi r7, r7, 10

loop: slt r5, r2, r1 # X <= r1
beqz r5, esMayor
J esMenorIgual
esMayor: daddi r3, r3, 1
daddi r6, r6, 1
sd r6, RES(r4)
esMenorIgual: daddi r4, r4, 4
daddi r7, r7, -1
beqz r7, termino
ld r2, X(r4)
J loop
termino: sd r3, CANT(r0)
halt