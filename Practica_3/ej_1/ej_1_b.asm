PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000h
  MSJ_ON DB "Llave prendida"
  FIN_MSJ_ON DB ?
  MSJ_OFF DB "Llave apagada"
  FIN_MSJ_OFF DB ?

ORG 2000h
  MOV AL, 0FFh
  OUT CA, AL
  IN AL, PA
  AND AL, 80h ; 1000 0000
  CMP AL, 0
  JZ ESTA_APAGADA
  MOV BX, OFFSET MSJ_ON
  MOV AL, OFFSET FIN_MSJ_ON - OFFSET MSJ_ON
  JMP IMPRIMIR
ESTA_APAGADA: MOV BX, OFFSET MSJ_OFF
  MOV AL, OFFSET FIN_MSJ_OFF - OFFSET MSJ_OFF
IMPRIMIR: INT 7
  INT 0
END