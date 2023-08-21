; VARIABLES
ORG 1000h
A DW 5
B DW 2
C DW 3
D DW ?

; Escribir un programa como en a) pero ahora el cálculo y el almacenamiento del resultado debe realizarse en una
; subrutina llamada calculo, sin recibir ni devolver parámetros, es decir, utilizando A, B, C y D como variables
; globales. Si bien esta técnica no está recomendada, en ejercicio sirve para ver sus diferencias con el uso de
; parámetros.

ORG 3000h
Calculo: MOV AX, A
  ADD AX, B
  SUB AX, C
  MOV D, AX
RET

ORG 2000h
CALL Calculo
hlt
END

