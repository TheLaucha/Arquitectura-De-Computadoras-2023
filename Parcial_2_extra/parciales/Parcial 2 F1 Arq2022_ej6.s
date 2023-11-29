.data
tabla1: .word 5,10,2,8,33,40,7
tabla2: .word 5,10,22,33,44,8,15
CONTROL: .word32 0x10000
DATA: .word32 0x10008
CANT: .word 7
MAX_TABLA_1: .word 0
MIN_TABLA_1: .word 9999
MAX_TABLA_2: .word 0
MIN_TABLA_2: .word 9999
verde: .byte 0,255,0,0 
azul: .byte 0,0,255,0

.code
DADDI $sp, $sp, 0x400
LWU $s0, CONTROL($0)
LWU $s1, DATA($0)
# Evaluo Tabla 1
DADDI $a0, $0, tabla1    # $a0 -> Dir de tabla1
LD $a1, CANT($0)        # $a1 -> Cant de elementos
LD $a2, MIN_TABLA_1($0)
LD $a3, MAX_TABLA_1($0)
JAL MIN_MAX
SD $v0, MIN_TABLA_1($0)
SD $v1, MAX_TABLA_1($0)
# Evaluo Tabla 2
DADDI $a0, $0, tabla2    # $a0 -> Dir de tabla1
LD $a1, CANT($0)        # $a1 -> Cant de elementos
LD $a2, MIN_TABLA_2($0)
LD $a3, MAX_TABLA_2($0)
JAL MIN_MAX
SD $v0, MIN_TABLA_2($0)
SD $v1, MAX_TABLA_2($0)
# Imprimo color verde
LBU $t0, MIN_TABLA_2($0) # X
LBU $t1, MAX_TABLA_2($0) # Y
SB $t0, 5($s1) 
SB $t1, 4($s1)
LWU $t2, verde($0)
SW $t2, 0($s1)
DADDI $t0, $0, 5
SD $t0, 0($s0)
# Imprimo color azul
LBU $t0, MIN_TABLA_1($0)
SB $t0, 5($s1)
LBU $t1, MAX_TABLA_1($0)
SB $t1, 4($s1)
LWU $t2, azul($0)
SW $t2, 0($s1)
DADDI $t3, $0, 5
SD $t3, 0($s0)
HALT

MIN_MAX: DADDI $sp, $sp, -16
  SD $s0, 8($sp)
  SD $s1, 0($sp)
  # Cargo valores max y min
  DADD $v0, $0, $a2 # Min
  DADD $v1, $0, $a3 # Max
  # Evaluo
  LOOP: LD $t2, 0($a0)
  SLT $t3, $t2, $v0
  BNEZ $t3, es_min
  J eval_max
es_min: DADD $v0, $0, $t2
eval_max: SLT $t3, $v1, $t2
  BNEZ $t3, es_max
  J sig
  es_max: DADD $v1, $0, $t2
sig: DADDI $a1, $a1, -1
  DADDI $a0, $a0, 8
  BNEZ $a1, LOOP
  # Restablezco valores de pila
  LD $s1, 0($sp)
  LD $s2, 8($sp)
  DADDI $sp, $sp, 16
  JR $ra