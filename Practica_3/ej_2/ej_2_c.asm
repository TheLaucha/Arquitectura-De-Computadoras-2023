PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000h
  CAR DB ?

ORG 2000h
  ; Configuro el PIO
  MOV AL, 0FDh ; 1111 1101
  OUT CA, AL
  MOV AL, 0
  OUT CB, AL
  ; Configuro el programa
  MOV DL, 5 ; Contador
  MOV BX, OFFSET CAR
LOOP: INT 6
  ; Veo si esta libre
  POLL: IN AL, PA
  AND AL, 1
  JNZ POLL
  ; Mando CAR a PB
  MOV AL, [BX]
  OUT PB, AL
  ; Pongo Strobe en 1
  IN AL, PA
  OR AL, 2
  OUT PA, AL
  ; Pongo Strobe en 0
  IN AL, PA
  AND AL, 0FDh
  OUT PA, AL
  ; Veo si es el final
  DEC DL
  JNZ LOOP
  INT 0
END