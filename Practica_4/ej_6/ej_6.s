.data
A: .word 2
B: .word 2
C: .word 2
D: .word 0

.code
ld r1, A(r0)
ld r2, B(r0)
ld r3, C(r0)
ld r4, D(r0)

bne r1, r2, NoEsIgual1
daddi r4, r4, 1

NoEsIgual1: bne r1, r3, NoEsIgual2
daddi r4, r4, 1
J fin

NoEsIgual2: bne r2, r3, fin
daddi r4, r4, 1

fin: beqz r4, LISTO
daddi r4, r4, 1

LISTO: sd r4, D(r0)


halt