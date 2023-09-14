PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 1000h
Letra_A DB "A"

ORG 2000h
  ; Configurar PIO
  MOV AL, 0FDh ; 1111 1101
  OUT CA, AL
  MOV AL, 0
  OUT CB, AL
  ;
  MOV BX, OFFSET Letra_A
  ; Check si esta libre
POLL: IN AL, PA
  AND AL, 1
  JNZ POLL
  ; Mando el dato a PB
  MOV AL, [BX]
  OUT PB, AL
  ; Pongo el Strobe en 1
  IN AL, PA
  OR AL, 2
  OUT PA, AL
  ; Pongo el Strobe en 0
  IN AL, PA
  AND AL, 0FDh
  OUT PA, AL
  LOOP: JMP LOOP
  INT 0
END