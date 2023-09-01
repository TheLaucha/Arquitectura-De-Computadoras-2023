; VARIABLES
ORG 1000h
  STR DB "contar1#!"
      DB 00h

ORG 3000h
ES_VOCAL: MOV DL, 00fh
  CMP CL, 41h ; A
  JZ FIN
  CMP CL, 61h ; a
  JZ FIN
  CMP CL, 45h ; E
  JZ FIN
  CMP CL, 65h ; e
  JZ FIN
  CMP CL, 49h ; I
  JZ FIN
  CMP CL, 69h ; i
  JZ FIN
  CMP CL, 4Fh ; O
  JZ FIN
  CMP CL, 6Fh ; o
  JZ FIN
  CMP CL, 55h ; U
  JZ FIN
  CMP CL, 75h ; u
  JZ FIN
  MOV DL, 00h
FIN: RET

CONTAR_VOC: MOV AL, 0
LOOP:  MOV CL, [BX]
  CMP CL, 00h
  JZ FIN_2
  CALL ES_VOCAL
  CMP DL, 00fh
  JNZ NO_ES
  INC AL
NO_ES: INC BX
  JMP LOOP
FIN_2: RET

ORG 2000h
  MOV BX, offset STR
  CALL CONTAR_VOC
HLT
END
