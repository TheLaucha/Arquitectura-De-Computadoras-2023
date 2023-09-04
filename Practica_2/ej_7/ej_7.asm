ORG 1000H
NUM1 DB ?
NUM2 DB ?
DIG1 DB "0"
DIG2 DB ?
MSJ DB "INGRESE UN NUMERO: "
FIN_MSJ DB ?
	
ORG 2000H
	MOV BX, OFFSET MSJ
	MOV AL, OFFSET FIN_MSJ - OFFSET MSJ
	INT 7
	MOV BX, OFFSET NUM1
	INT 6
	
	MOV BX, OFFSET MSJ
	INT 7
	MOV BX, OFFSET NUM2
	INT 6

  ; Sumo los numeros ingresados y le resto 30h
	MOV CL, NUM1
  ADD CL, NUM2
  SUB CL, 30h
  ; Si queda mayor que 3Ah quiere decir que tiene el numero tiene 2 unidades, por lo que le resto 0Ah (10) y muevo 1 al digito decimal. 
  CMP CL, 3Ah
  JS LISTO
  SUB CL, 0Ah
  MOV DIG1, 31h
LISTO: MOV DIG2, CL
  MOV BX, OFFSET DIG1
	MOV AL, 2
	INT 7
	INT 0
END