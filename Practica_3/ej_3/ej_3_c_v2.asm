EOI EQU 20h
IMR EQU 21h
INT2 EQU 26h
ID_HAND EQU 10
DATO EQU 40h
ESTADO EQU 41h

ORG 40
IP_HAND DW RUT_HAND

ORG 3000h
RUT_HAND: PUSH AX
  MOV AL, [BX]
  OUT DATO, AL
  INC BX
  DEC DL
  JNZ FINAL
  MOV AL, 0FFh
  OUT IMR, AL
FINAL: MOV AL, EOI
  OUT EOI, AL
  POP AX
  IRET

ORG 1000h
  MSJ DB "UNIVERSIDAD NACIONAL DE LA PLATA"
  FIN_MSJ DB ?

ORG 2000h
  MOV BX, OFFSET MSJ
  MOV DL, OFFSET FIN_MSJ - OFFSET MSJ
  ; Configuro el PIC
  CLI
    MOV AL, 0FBh ; 1111 1011
    OUT IMR, AL
    MOV AL, ID_HAND
    OUT INT2, AL
    ; Consultar si esto hay que hacerlo aca o abajo
    ; Configuro el HANDSHAKE Para interrupcion
    MOV AL, 80h
    OUT ESTADO, AL
  STI
  ; Consultarlo si esto hay que hacerlo aca o arriba
  ; Configuro el HANDSHAKE Para interrupcion
  ; IN AL, ESTADO
  ; OR AL, 80h ; 1000 0000
  ; OUT ESTADO, AL
  POLL: CMP DL, 0
  JNZ POLL
  ; Desactivo el handshake por interrupcion
  IN AL, ESTADO
  AND AL, 07Fh
  OUT ESTADO, AL
  LOOP: JMP LOOP
  INT 0
END