.data
TABLA: .word 1,2,3,4,5

.code
DADDI R14, R0, 5
DADD R15, R0, R0
LOOP: SD R15, TABLA(R15)
DADDI R14, R14, -1
DADDI R15, R15, 8
BNEZ R14, LOOP
HALT