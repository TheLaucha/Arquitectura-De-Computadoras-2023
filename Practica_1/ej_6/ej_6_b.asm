; VARIABLES
ORG 1000h
  NUM1 DB 5
  NUM2 DB 2
  RES DB ?

ORG 3000h
MUL: MOV DL,0
  CMP BL, 0
  JZ FIN
  LOOP: ADD DL, AL
  DEC BL
  JNZ LOOP
FIN: RET


ORG 2000h
  MOV AL, NUM1
  MOV BL, NUM2
  CALL MUL
  MOV RES, DL
  hlt
END

