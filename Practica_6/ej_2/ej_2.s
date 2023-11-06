.data
CONTROL: .word32 0x10000
DATA: .word32 0x10008
digito: .word 0
msj: .asciiz "Ingrese un numero entero de un digito"
msj2: .asciiz "El numero ingresado no cumple la condicion, vuelva a ingresar un numero."
CERO:          .asciiz " CERO "
UNO:          .asciiz " UNO   "
DOS:          .asciiz " DOS   "
TRES:         .asciiz " TRES  "
CUATRO:       .asciiz " CUATRO"
CINCO:        .asciiz " CINCO "
SEIS:         .asciiz " SEIS  "
SIETE:        .asciiz " SIETE "
OCHO:         .asciiz " OCHO  "
NUEVE:        .asciiz " NUEVE "

.code
LWU $s0, DATA($zero)
LWU $s1, CONTROL($zero)

DADDI $a0, $0, msj      # Dir msj 1
DADDI $a1, $0, msj2     # Dir msj 2
JAL INGRESO

SD $v0, digito($0)
DADDI $t0, $0, 6
SD $t0, 0($s1)            # Control = 6 para que limpie la terminal

DADDI $a0, $0, CERO
LD $a1, digito($0)
JAL MENSAJE
HALT

INGRESO: DADDI $t0, $0, 6
  SD $t0, 0($s1)            # Control = 6 para que limpie la terminal
  SD $a0, 0($s0)            # Data = Dir msj

LOOP: DADDI $t0, $0, 4      
  SD $t0, 0($s1)            # Control = 4 para que imprima el mensaje

  DADDI $t0, $0, 8
  SD $t0, 0($s1)            # Control = 8 para que lea un numero

  LD $t1, 0($s0)            # Tomo el valor ingresdo desde data
  BEQZ $t1, NoCumple        # Si es igual a 0 es porque no es un numero.
  SLTI $t2, $t1, 1          # $t2 = 1 si $t1 es menor que 1
  BNEZ $t2, NoCumple        # Si $t2 no es igual a 0 quiere decir que no cumple la condicion de ser un digito entero
  SLTI $t2, $t1, 10         # $t2 = 1 si $t1 es menor que 10
  BEQZ $t2, NoCumple        # Si $t2 es igual a 0 quiere decir que el numero es mayor o igual que 10 por lo que no cumple
  
  DADD $v0, $v0, $t1        # Si paso las validaciones, copio el valor en una variable de retorno.
  JR $ra

NoCumple: DADDI $t0, $0, 6
  SD $t0, 0($s1)            # Control = 6 para que limpie la terminal
  SD $a1, 0($s0)            # Data = Dir msj2
  J LOOP

MENSAJE: nop
LOOP2: BEQZ $a1, IMPRIMIR
  DADDI $a1, $a1, -1
  DADDI $a0, $a0, 8
  J LOOP2
IMPRIMIR: SD $a0, 0($s0)
  DADDI $t1, $0, 4
  SD $t1, 0($s1)
  JR $ra


