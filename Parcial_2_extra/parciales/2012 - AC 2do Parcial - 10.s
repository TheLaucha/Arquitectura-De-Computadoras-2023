# .data
# TABLA: .word 1,2,3,4,5

# .code
# DADDI R14, R0, 5
# DADD R15, R0, R0
# LOOP:  SD R15, TABLA(R15)
# DADDI R14, R14, -1 
# DADDI R15, R15, 8
# BNEZ R14, LOOP
# HALT

# .data
# TABLA: .word 1,2,3,4,5
# 
# .code
# DADDI R14, R0, 5
# DADD R15, R0, R0
# LOOP: DADDI R14, R14, -1 
# SD R15, TABLA(R15)
# BNEZ R14, LOOP
# DADDI R15, R15, 8
# HALT

# .data
# dato: .word 5
# 
# .code
# LD R4, dato(R0)
# DADD R1, R14, R6
# DADDI R2, R2, 1
# SD R5, dato(r12)
# HALT

.data
TABLA: .word 4,11,18,6,17,28,9,0,11,23,15,6,37,29,14
MENOR: .word 20
MAYOR: .word 10
CANTIDAD: .word 15
TOTAL: .word 0
NUEVO: .word 0

.code
DADDI $a0, $0, TABLA
LD $a1, MAYOR($0)
LD $a2, CANTIDAD($0)
DADDI $a3, $0, NUEVO
JAL ANALIZAR
SD $v0, TOTAL($0)
HALT

ANALIZAR: DADDI $v0, $0, 0        # $v0 -> Cantidad de elementos mayores a mayor
loop: LD $t0, 0($a0)              # $t0 -> Coloco en $t0 el valor actual de donde apunta tabla
slt $t1, $a1, $t0                 # Pone $t1 en 1 si el MAYOR(10) es menor que el num act.
BEQZ $t1, siguiente
DADDI $v0, $v0, 1                 # Incremento la cantidad de numeros mayores
SD $t0, 0($a3)                    # Guardo
DADDI $a3, $a3, 8                 # Incremento la direccion de la nueva tabla
siguiente: DADDI $a2, $a2, -1     # Decremento cantidad
DADDI $a0, $a0, 8                 # Avanzo en la tabla a analizar
BEQZ $a2, termino
J loop
termino: JR $ra




