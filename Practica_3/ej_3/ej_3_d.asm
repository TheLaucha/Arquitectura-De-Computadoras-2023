DATO EQU 40h
ESTADO EQU 41h

ORG 1000h
  MSJ DB "INGRESE 5 CARACTERES: "
  FIN_MSJ DB ?
  CAD DB ?

ORG 2000h
  ; Imprimo mensaje
  MOV BX, OFFSET MSJ
  MOV AL, OFFSET FIN_MSJ - OFFSET MSJ
  INT 7
  ; Leo caracteres
  MOV DL, 5
  MOV BX, OFFSET CAD
OTRO: INT 6
  INC BX
  DEC DL
  JNZ OTRO
  ; Configuro BX para que apunte al inicio
  MOV BX, OFFSET CAD
  ; Configuro impresora por polling
  IN AL, ESTADO
  AND AL, 7Fh ; 0111 1111
  OUT ESTADO, AL
  ; DERECHO
POLL: IN AL, ESTADO
  AND AL, 1
  JNZ POLL
  ; Mando el car a dato
  MOV AL, [BX]
  OUT DATO, AL
  ; Checkeo si termine
  INC BX
  INC DL
  CMP DL, 5
  JNZ POLL
  ; INVERSO
  DEC BX
POLL2: IN AL, ESTADO
  AND AL, 1
  JNZ POLL2
  ; Mando el car a dato
  MOV AL, [BX]
  OUT DATO, AL
  ; Checkeo si termine
  DEC BX
  DEC DL
  JNZ POLL2
  LOOP: JMP LOOP
  INT 0
END