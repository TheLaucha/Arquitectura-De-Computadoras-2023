.data
# numero: .double 5.2
VALOR: .double 5.2
CONTROL: .word32 0x10000
DATA: .word32 0x10008
msj: .asciiz "Ingrese un numero en punto flotante."
msj2: .asciiz "El resultado es: "
RES: .double 0.0

.code
# L.D F6, numero($0)
# ADD.D F3, F3, F3
# S.D F9, numero($0)
# HALT
# DADDI $t7, $0, 37
# LOOP: DADDI $t7, $t7, -1
#  BNEZ $t7, LOOP
#  HALT
LWU $s0, CONTROL($0)
LWU $s1, DATA($0)
# Imprimo el mensaje pidiendo el numero
DADDI $t0, $0, msj
SD $t0, 0($s1)
DADDI $t1, $0, 4
SD $t1, 0($s0)
# Configuro para recibir el numero
DADDI $t1, $0, 8
SD $t1, 0($s0)
L.D F1, 0($s1)
# Comparo F1 (num ingresado) con valor.
L.D F2, VALOR($0)
C.LT.D F1, F2 # Si F1 < F2 -> Flag = 1
BC1T ES_MENOR_O_IGUAL
C.LT.D F2, F1 # Si F2 < F1 -> Flag = 1
BC1T ES_MAYOR
ES_MENOR_O_IGUAL: SUB.D F3, F2, F1
DIV.D F3, F3, F1
J TERMINO
ES_MAYOR: SUB.D F3, F1, F2
MUL.D F3, F3, F1
# Almaceno el resultado y los muestro junto con el msj
TERMINO: S.D F3, RES($0)
# Limpio la pantalla alfanumerica
DADDI $t0, $0, 6
SD $t0, 0($s0)
# Imprimo el msj
DADDI $t0, $0, msj2
SD $t0, 0($s1)
DADDI $t1, $0, 4
SD $t1, 0($s0)
# Imprimo el dato
S.D F3, 0($s1)
DADDI $t0, $0, 3
SD $t0, 0($s0)
HALT