EOI EQU 20h
IMR EQU 21h
INT0 EQU 24h
ID_F10 EQU 10
PA EQU 30h
PB EQU 31h
CA EQU 32h
CB EQU 33h

ORG 40
IP_F10 DW RUT_F10

ORG 1000h
  CAD DB ?

ORG 3000h
RUT_F10: PUSH AX
  MOV BX, OFFSET CAD
  ; Check si esta libre
POLL: IN AL, PA
  AND AL, 1
  JNZ POLL
  ; Mando car a PB
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
  ; Checkeo si termine
  INC BX
  DEC DL
  JNZ POLL
  MOV AL, EOI
  OUT EOI, AL
  POP AX
  IRET

ORG 2000h
  ; Configuro PIO
  MOV AL, 0FDh
  OUT CA, AL
  MOV AL, 0
  OUT CB, AL
  ; Configuro PIC
  CLI
    MOV AL, 0FEh ; 1111 1110
    OUT IMR, AL
    MOV AL, ID_F10
    OUT INT0, AL
  STI
  ; Configuro Programa
  MOV BX, OFFSET CAD
  MOV DL, 0 ; Contador
  LOOP: INT 6
    INC BX
    INC DL
  JMP LOOP
  INT 0
END