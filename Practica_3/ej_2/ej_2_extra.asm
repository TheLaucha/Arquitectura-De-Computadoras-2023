PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000h
  MSJ DB "Imprimiendo con el PIO"
  FIN_MSJ DB ?

ORG 2000H
  ; Configuro el PIO
  MOV AL, 0FDh ; 1111 1101
  OUT CA, AL
  MOV AL, 000h
  OUT CB, AL
  MOV BX, OFFSET MSJ
POLL: IN AL, PA
  AND AL, 1 ; 0000 0001
  JNZ POLL
  ; Selecciono el caracter y lo mando a PB
  MOV AL, [BX]
  OUT PB, AL
  ; Mando strobe en 1
  IN AL, PA ; Tomamos el estado
  OR AL, 2  ; Forzamos el strobe a 1
  OUT PA, AL
  ; Regreso strobe a 0
  IN AL, PA
  AND AL, 0FDh ; 1111 1101
  OUT PA, AL
  ; Incremento BX y comparo
  INC BX
  CMP BX, OFFSET FIN_MSJ
  JNZ POLL
  LOOP: JMP LOOP
  INT 0
END 