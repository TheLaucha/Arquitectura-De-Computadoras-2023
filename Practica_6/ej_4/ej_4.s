.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
clave: .asciiz "pass"
msj: .asciiz "Ingrese una clave de 4 caracteres."
msj2: .asciiz "Ingrese un caracter: "
msjBienvenido: .asciiz "Bienvenido!"
msjError: .asciiz "ERROR: "
cant: .word 4
cad: .asciiz ""


.code
daddi $sp, $zero, 0x400
LWU $s0, CONTROL($0)
LWU $s1, DATA($0)

Volver_a_pedir: LD $s2, cant($0)    # $s2 = Contador de caracteres ingresados, guardar en pila cuando ingreso a la subrutina 
DADDI $s3, $0, 0    # $s3 = Contador incremental

DADDI $t0, $0, msj  # Dir msj
SD $t0, 0($s1)      # DATA = dir msj
DADDI $t0, $0, 4    
SD $t0, 0($s0)      # CONTROL = 4 para imprimir la cadena

OTRO: JAL char
SB $v0, cad($s3)
DADDI $s3, $s3, 1
DADDI $s2, $s2, -1
BNEZ $s2, OTRO

DADDI $a0, $0, clave
DADDI $a1, $0, cad
JAL comparar

BNEZ $v0, SON_IGUALES
DADDI $a0, $0, msjError
JAL respuesta
J Volver_a_pedir
SON_IGUALES: DADDI $a0, $0, msjBienvenido
JAL respuesta
HALT


char: DADDI $sp, $sp, -16
  SD $s2, 8($sp)
  SD $s3, 0($sp)

  DADDI $t0, $0, 9
  SD $t0, 0($s0)        # CONTROL = 9 -> Para leer codigo ascii
  LBU $v0, 0($s1)       # Cargo el codigo ascii que se encuentra en DATA

  LD $s3, 0($sp)
  LD $s2, 8($sp)
  DADDI $sp, $sp, 16
  JR $ra

comparar: DADDI $v0, $0, 0      # $v0 = 1 si son iguales, 0 en caso contrario
LOOP: LBU $t0, 0($a0)               # $t0 = car de clave
  LBU $t1, 0($a1)               # $t1 = car de clave ingresada
  BEQZ $t0, fin_cadena1
  BEQZ $t1, FIN
  BNE $t0, $t1, FIN
  DADDI $a0, $a0, 1
  DADDI $a1, $a1, 1
  J LOOP   

fin_cadena1: BNEZ $t1, FIN
  DADDI $v0, $0, 1
FIN: JR $ra

respuesta: DADDI $t0, $0, 6
  SD $t0, 0($s0)              # Control = 6 para limpiar la terminal

  SD $a0, 0($s1)              # Data = dir de mensaje a mostrar

  DADDI $t0, $0, 4
  SD $t0, 0($s0)
  JR $ra
