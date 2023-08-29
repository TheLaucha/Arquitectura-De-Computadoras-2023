; VARIABLES
ORG 1000h
  STR DB "abbcdbbeb!"
      DB 00h
  VALOR DB "b"

ORG 3000h
CONTAR_CAR: MOV DL, 0 ; INICIALIZO CONTADOR
  MOV BX, SP
  ADD BX, 4
  MOV AL, [BX]        ; AX Contiene el VALOR a buscar
  SUB BX, 2
  MOV BX, [BX]        ; BX Contiene la direccion de la cadena
LOOP: MOV CL, [BX]
  CMP CL, 00h
  JZ FIN
  CMP CL, AL
  JNZ CONTINUO
  INC DL
CONTINUO: INC BX
  JMP LOOP
FIN: RET

ORG 2000h
  MOV AH, 0
  MOV AL, VALOR
  PUSH AX
  MOV AX, offset STR
  PUSH AX
  CALL CONTAR_CAR
HLT
END

