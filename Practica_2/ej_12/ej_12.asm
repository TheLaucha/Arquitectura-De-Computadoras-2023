TIMER EQU 10h
EOI EQU 20h
IMR EQU 21h
ID_CLK EQU 10
INT1 EQU 25h

ORG 40
IP_CLK DW RUT_CLK

ORG 1000h
  SEG DB 30h
      DB 30h
  FIN DB ?

ORG 3000H
RUT_CLK: PUSH AX
    INC SEG+1
    CMP SEG+1, 3Ah
    JNZ RESET
    MOV SEG+1, 30h
    INC SEG
    CMP SEG, 36h
    JNZ RESET
    MOV SEG, 30h
RESET: INT 7
  MOV AL, 0
  OUT TIMER, AL
  MOV AL, EOI
  OUT EOI, AL
  POP AX
  IRET
  
ORG 2000H
  CLI
    MOV AL, 0FDh ; 1111 1101
    OUT IMR, AL
    MOV AL, ID_CLK
    OUT INT1, AL
    MOV AL, 1
    OUT TIMER+1, AL ; Timer registro COMP
    MOV AL, 0
    OUT TIMER, AL ; Timer registro CONT
    MOV BX, OFFSET SEG
    MOV AL, OFFSET FIN - OFFSET SEG
  STI
LOOP: JMP LOOP
END