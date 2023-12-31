ORG 1000h
  NUM_1 DW 5
  NUM_2 DW 2
  RES DW ?

ORG 3000h
MUL: MOV BX, AX
  MOV AX, [BX]
  MOV BX, CX
  MOV CX, [BX]
  CMP AX, 0
  JZ FIN
LOOP: CMP CX, 0
  JZ FIN
  ADD DX, AX
  DEC CX
  JMP LOOP
FIN: RET

ORG 2000h
  MOV AX, OFFSET NUM_1
  MOV CX, OFFSET NUM_2
  MOV DX, 0
  CALL MUL
  MOV RES, DX
  INT 0
END