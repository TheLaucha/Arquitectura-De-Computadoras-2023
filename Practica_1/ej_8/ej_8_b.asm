; VARIABLES
ORG 1000h
  STR DB "aBcDE1#!"
      DB 00H
  LETRA_a DB "a"
  LETRA_z DB "z"
  RES DB ?

ORG 3000h
CONTAR_MIN: MOV AL, LETRA_a
  MOV AH, LETRA_z
  MOV DL, 0
  LOOP: MOV CL, [BX]
  CMP CL, 00h
  JZ FIN
  CMP CL, AL
  JS NO_ES_MIN
  CMP AH, CL
  JS NO_ES_MIN
  INC DL
NO_ES_MIN: INC BX
  JMP LOOP
FIN: RET

ORG 2000h
  MOV BX, offset STR
  CALL CONTAR_MIN
  MOV RES, DL
  hlt
END

