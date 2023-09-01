; variables
ORG 1000h
  NUM1_A DW 3000h
  NUM1_B DW 2000h
  NUM2_A DW 1000h
  NUM2_B DW 1000h
  Res_A DW ?
  Res_B DW ?
  
ORG 2000h
  MOV AX, NUM1_A
  MOV BX, NUM1_B
  MOV CX, NUM2_A
  MOV DX, NUM2_B
  ADD AX, CX ; Sumo partes altas
  ADD BX, DX ; Sumo partes bajas
  MOV Res_A, AX
  MOV Res_B, BX
  HLT
END