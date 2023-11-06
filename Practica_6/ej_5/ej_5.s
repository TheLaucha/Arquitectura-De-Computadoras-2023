.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
valor: .double 0
potencia: .word 0
res: .double 0
msj: .asciiz "Ingrese la base"
msj2: .asciiz "Ingrese el exponente"
UNO: .double 1.0

.code
DADDI $sp, $0, 0x400

LWU $s0, CONTROL($0)
LWU $s1, DATA($0)

DADDI $a0, $0, msj
JAL INGRESE_BASE

DADDI $a0, $0, msj2
JAL INGRESE_POTENCIA
SD $v0, potencia($0)

LD $a1, potencia($0)
JAL A_LA_POTENCIA


DADDI $t0, $0, 6
SD $t0, 0($s0)
S.D f2, res($0)
S.D f1, 0($s1)    # Data = valor res
DADDI $t0, $0, 3  # Control = 3 (No muestra el resultado correcto)
SD $t0, 0($s0)
HALT

# $a0 = Dir de msj a mostrar
INGRESE_BASE: DADDI $sp, $sp, -16
  SD $s0, 8($sp)
  SD $s1, 0($sp)

  DADDI $t0, $0, 6
  SD $t0, 0($s0)        # Control = 6 Limpio terminal
  SD $a0, 0($s1)        # Data = Dir de msj
  DADDI $t0, $0, 4      
  SD $t0, 0($s0)        # Control = 4 Para escribir mensaje
  DADDI $t0, $0, 8      
  SD $t0, 0($s0)        # Control = 8 Lectura numero entero o punto flotante

  L.D f1, 0($s1)        # tomo num en punto flotante
  S.D f1, valor($0)

  LD $s1, 0($sp)
  LD $s0, 8($sp)
  DADDI $sp, $sp, 16
  JR $ra


# $a0 = Dir de msj a mostrar
INGRESE_POTENCIA: DADDI $sp, $sp, -16
  SD $s0, 8($sp)
  SD $s1, 0($sp)

  DADDI $t0, $0, 6
  SD $t0, 0($s0)        # Control = 6 Limpio terminal
  SD $a0, 0($s1)        # Data = Dir de msj
  DADDI $t0, $0, 4      
  SD $t0, 0($s0)        # Control = 4 Para escribir mensaje
  DADDI $t0, $0, 8      
  SD $t0, 0($s0)        # Control = 8 Lectura numero entero o punto flotante

  LD $v0, 0($s1)        # Cargo $v0 con el valor de DATA

  LD $s1, 0($sp)
  LD $s0, 8($sp)
  DADDI $sp, $sp, 16
  JR $ra

# $a1 = potencia
A_LA_POTENCIA: DADDI $sp, $sp, -16
  SD $s0, 8($sp)
  SD $s1, 0($sp)

  DADD $t0, $0, $a1     # $t0 = contador de potencia

  L.D f2, UNO($0)       # f2 = resultado
LOOP: BEQZ $t0, termino
  MUL.D f2, f2, f1
  DADDI $t0, $t0, -1
  J LOOP

termino: LD $s1, 0($sp)
  LD $s1, 8($sp)
  DADDI $sp, $sp, 16

  JR $ra