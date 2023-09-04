; VARIABLES
ORG 1000h
  NUMS DB "CERO  "
    DB "UNO   "
    DB "DOS   "
    DB "TRES  "
    DB "CUATRO"
    DB "CINCO "
    DB "SEIS  "
    DB "SIETE "
    DB "OCHO  "
    DB "NUEVE "
  act db ? 
  msj db "INGRESE UN NUMERO DE UN DIGITO: "
  fin_msj db ?
  
ORG 3000h
IMPRIMIR: MOV BX, offset nums
  MOV AL, 6
OTRO: CMP act, 30h
  JZ IMP
  DEC act
  ADD BX, 6
  JMP OTRO
IMP: INT 7
  RET

; CL -> Contador
ORG 2000h
  MOV CL, 30h
LOOP: MOV BX, offset msj
  MOV AL, offset fin_msj - offset msj
  INT 7
  MOV BX, offset act
  INT 6
  CMP act, 30h
  JNZ NO_CERO
  INC CL
  JMP SIGO
NO_CERO: MOV CL, 30h
SIGO: CALL IMPRIMIR
  CMP CL, 32h
  JZ TERMINO
  JMP LOOP
TERMINO: INT 0
END

