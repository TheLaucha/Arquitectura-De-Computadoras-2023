PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000h
  MSJ DB "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
  FIN_MSJ DB ?

ORG 2000h
  ; Configuro CA Y CB
  MOV AL, 0FDh ; 1111 1101
  OUT CA, AL
  MOV AL, 0
  OUT CB, AL
  ; 
  MOV BX, OFFSET MSJ
  ; Check si esta libre
POLL: IN AL, PA
  AND AL, 1
  JNZ POLL
  ; Muevo el caracter a PB
  MOV AL, [BX]
  OUT PB, AL
  ; Pongo Strobe en 1
  IN AL, PA
  OR AL, 2
  OUT PA, AL
  ; Pongo Strobe en 0
  IN AL, PA
  AND AL, 0FDh ; 1111 1101
  OUT PA, AL
  ; Check si termine
  INC BX
  CMP BX, OFFSET FIN_MSJ
  JNZ POLL
  LOOP: JMP LOOP
  INT 0
END