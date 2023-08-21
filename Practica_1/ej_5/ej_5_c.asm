; VARIABLES
ORG 1000h
A DW 5
B DW 2
C DW 3
D DW ?

; Volver a escribir el programa, pero ahora con una subrutina que reciba A, B y C 
; por valor a través de los registros AX, BX y CX, calcule AX+BX-CX, 
; y devuelva el resultado por valor en el registro DX. El programa principal debe
; llamar a la subrutina y luego guardar el resultado en la memoria con etiqueta D

ORG 3000h
Calculo: ADD AX, BX
  SUB AX, CX
  MOV DX, AX
RET

ORG 2000h
MOV AX, A
MOV BX, B
MOV CX, C
CALL Calculo
MOV D, DX
hlt
END

