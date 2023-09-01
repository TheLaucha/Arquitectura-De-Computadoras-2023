; variables
ORG 1000h
  NUM1 DB 13
  NUM2 DB 2
  RESULTADO DB ?

ORG 3000h
DIV: ; BACKUP REGISTROS
  PUSH AX
  PUSH BX
  PUSH CX
  PUSH DX
  ; ===
  MOV BX, SP
  ; Guardo num1 en AX (DIVIDENDO)
  ADD BX, 14
  MOV AX, [BX]
  ; Guardo num2 en CX (DIVISOR)
  SUB BX, 2
  MOV CX, [BX]
  ; INICIALIZO CONTADOR
  MOV DX, 0
  ; REALIZO LA DIVISION
LOOP: SUB AX, CX
  JS FIN
  INC DX
  JMP LOOP
FIN: SUB BX, 2
  MOV [BX], DX
  ; RECUPERO REGISTROS
  POP DX
  POP CX
  POP BX
  POP AX
RET

ORG 2000h
  MOV AX, 00H
  MOV AL, NUM1
  PUSH AX
  MOV AL, NUM2
  PUSH AX
  MOV AL, RESULTADO
  PUSH AX
  CALL DIV
  POP AX
  MOV RESULTADO, AL
  HLT
END