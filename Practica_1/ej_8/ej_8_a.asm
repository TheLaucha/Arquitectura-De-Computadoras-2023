; VARIABLES
ORG 1000h
  STR DB "abcd"
  DB 00h
  RES DB ?

ORG 3000h
LONGITUD: MOV DL, 0
LOOP: MOV AH, [BX]
  CMP AH, 00h
  JZ FIN
  INC DL
  INC BX
  JMP LOOP
FIN: RET

ORG 2000h
  MOV BX, offset STR
  CALL LONGITUD
  MOV RES, DL
  hlt
END
