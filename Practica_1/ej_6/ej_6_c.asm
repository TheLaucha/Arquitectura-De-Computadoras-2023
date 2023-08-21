; VARIABLES
ORG 1000h
  NUM1 DW 5
  NUM2 DW 2
  RES DW ?

ORG 3000h
MUL: MOV DX, 0
  MOV BX, AX
  MOV AX, [BX]
  MOV BX, CX
  MOV CX, [BX]
  CMP CX, 0
  JZ TERMINO
LOOP: ADD DX, AX
  DEC CX
  JNZ LOOP
TERMINO: RET

ORG 2000h
  MOV AX, offset NUM1
  MOV CX, offset NUM2
  CALL MUL
  MOV RES, DX
  hlt
END
