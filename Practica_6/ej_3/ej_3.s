.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
msj: .asciiz "Ingrese un numero entero de un digito."
msj2: .asciiz "El valor ingresado es incorrecto, ingrese un numero entero de un digito."
dig1: .word 0
dig2: .word 0

.code
LWU $s0, CONTROL($0)
LWU $s1, DATA($0)
DADDI $a0, $0, msj
DADDI $a1, $0, msj2
JAL INGRESO
SD $v0, dig1($0)
JAL INGRESO
SD $v0, dig2($0)
LD $a0, dig1($0)
LD $a1, dig2($0)
JAL RESULTADO
HALT

INGRESO: DADDI $t0, $0, 6
  SD $t0, 0($s0)             # Control = 6 para que limpia la terminal
  SD $a0, 0($s1)             # Data = Dir de msj

LOOP: DADDI $t0, $0, 4          
  SD $t0, 0($s0)             # Control = 4 para imprimir msj

  DADDI $t0, $0, 8
  SD $t0, 0($s0)             # Control = 8 para leer un digito

  LD $t1, 0($s1)
  BEQZ $t1, NoCumple
  SLTI $t2, $t1, 0           # Si $t1 < 0 entonces $t2 = 1 -> No cumple
  BNEZ $t2, NoCumple
  SLTI $t2, $t1, 10          # Si $t1 < 10 entonces $t2 = 1 -> Si $t2 = 0 -> No cumple
  BEQZ $t2, NoCumple
  DADD $v0, $0, $t1
  JR $ra

NoCumple: DADDI $t0, $0, 6
  SD $t0, 0($s0)
  SD $a1, 0($s1)    # Data = dir msj 2
  J LOOP

RESULTADO: DADD $t0, $a0, $a1
  DADDI $t1, $0, 6
  SD $t1, 0($s0)        # Control 6 para limpiar terminal
  SD $t0, 0($s1)        # Cargo data con el resultado de la suma
  DADDI $t1, $0, 1      
  SD $t1, 0($s0)        # Control = 1 para imprimir numeros enteros
  JR $ra
