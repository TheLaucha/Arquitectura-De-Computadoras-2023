; Consultar si hay que guardar y restablecer los registros cuando se llama a una subrutina.
; variables
ORG 1000h
  NUM1 DW 5
  NUM2 DW 2

ORG 3000h
SWAP: MOV BX, SP
  ADD BX, 4
  ; TOMO DIR NUM 1
  MOV AX, [BX] 
  ; TOMO DIR NUM 2
  SUB BX, 2
  MOV CX, [BX]
  ; GUARDO VALOR NUM 1
  MOV BX, AX
  MOV AX, [BX]
  MOV DX, BX ; BACKUP DE DIR NUM1
  ; GUARDO VALOR NUM 2
  MOV BX, CX
  MOV CX, [BX]
  ; GUARDO EN DIR NUM2, VALOR NUM1
  MOV [BX], AX
  ; GUARDO EN DIR NUM1, VALOR NUM2
  MOV BX, DX
  MOV [BX], CX
  RET
  
ORG 2000h
  MOV AX, OFFSET NUM1
  PUSH AX
  MOV AX, OFFSET NUM2
  PUSH AX
  CALL SWAP
  hlt
END