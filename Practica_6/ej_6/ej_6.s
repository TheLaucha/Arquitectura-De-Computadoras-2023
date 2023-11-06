.data
coorX: .byte 24
coorY: .byte 24
color: .byte 255,0,255,0
CONTROL: .word32 0x10000
DATA: .word32 0x10008
msj1: .asciiz "Ingrese coordenada X"
msj2: .asciiz "Ingrese coordenada Y"
msj3: .asciiz "Ingrese el color (4 bytes)"

.code
lwu $s0, CONTROL($0)
lwu $s1, DATA($0)

DADDI $t0, $0, 7
SD $t0, 0($s0)      # Control = 7 -> Limpiar pantalla grafica

DADDI $t0, $0, msj1
SD $t0, 0($s1)
DADDI $t1, $0, 4
SD $t1, 0($s0)     # Control = 4 -> Imprime la cadena que hay en data.
DADDI $t1, $0, 8
SD $t1, 0($s0)     # Control = 8 -> Espera el ingreso de un numero
LBU $t2, 0($s1)     # Cargo $t2 con lo que ingrese
SB $t2, coorX($0)  # Guardo

DADDI $t0, $0, msj2
SD $t0, 0($s1)
DADDI $t1, $0, 4
SD $t1, 0($s0)     # Control = 4 -> Imprime la cadena que hay en data.
DADDI $t1, $0, 8
SD $t1, 0($s0)     # Control = 8 -> Espera el ingreso de un numero
LBU $t2, 0($s1)     # Cargo $t2 con lo que ingrese
SB $t2, coorY($0)  # Guardo

DADDI $t0, $0, msj3
SD $t0, 0($s1)
DADDI $t1, $0, 4
SD $t1, 0($s0)     # Control = 4 -> Imprime la cadena que hay en data.
DADDI $t5, $0, 0
DADDI $t6, $0, 4
LOOP: BEQZ $t6, IMPRIMO
  DADDI $t1, $0, 8
  SD $t1, 0($s0)      # Control = 8 -> Espera el ingreso de un numero
  LBU $t2, 0($s1)     # Cargo $t2 con lo que ingrese
  SB $t2, color($t5)  # Guardo
  DADDI $t6, $t6, -1
  DADDI $t5, $t5, 1
  J LOOP

IMPRIMO: lbu $s2, coorX($0)
sb $s2, 5($s1)
lbu $s3, coorY($0)
sb $s3, 4($s1)
lwu $s4, color($0)
sw $s4, 0($s1)

DADDI $t0, $0, 5
SD $t0, 0($s0)    # Control = 5 -> Produce el dibujo
HALT