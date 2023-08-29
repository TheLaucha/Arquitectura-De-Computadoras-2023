; VARIABLES
ORG 1000h
  NUM DB 94h

; AH Es el registro que se va a rotar
ORG 3000h
ROTARIZQ: MOV AH, [BX] 
  ADD AH, AH
  ADC AH, 0
  MOV [BX], AH
RET

ORG 2000h
  MOV BX, offset NUM
  CALL ROTARIZQ
HLT
END

