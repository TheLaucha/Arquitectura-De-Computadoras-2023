; VARIABLES
ORG 1000h
  NUM1 DB 5
  NUM2 DB 2
  RES DB ?

ORG 2000h
  MOV AL, NUM1
  CMP AL, 0
  JZ FIN
  MOV BL, NUM2
  CMP BL, 0
  JZ FIN
  MOV DL, 0
  LOOP: ADD DL, AL
  DEC BL
  JNZ LOOP
FIN: MOV RES, DL
  hlt
END

