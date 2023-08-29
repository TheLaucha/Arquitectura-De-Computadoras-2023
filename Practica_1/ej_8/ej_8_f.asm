; Preguntar si es necesario inicializar registros.
; VARIABLES
ORG 1000h
  STR DB "Hola Munde!"
      DB 00h
  Original DB "e"
  Reemplazo DB "o"

ORG 3000h
; AL Original
; CL Reemplazo
; DL Caracter actual
REEMPLAZAR_CAR: MOV BX, SP
  ADD BX, 6
  MOV AL, [BX]
  SUB BX, 2
  MOV CL, [BX]
  SUB BX, 2
  MOV BX, [BX]
LOOP: MOV DL, [BX]
  CMP DL, 00h
  JZ FIN
  CMP DL, AL
  JNZ SIGUE
  MOV [BX], CL
SIGUE: INC BX
  JMP LOOP
FIN: RET

ORG 2000h
  MOV AX, 00h ; Inicializo
  MOV AL, Original
  PUSH AX
  MOV CX, 00h ; Inicializo
  MOV CL, Reemplazo
  PUSH CX
  MOV AX, offset STR
  PUSH AX
  CALL REEMPLAZAR_CAR
HLT
END

