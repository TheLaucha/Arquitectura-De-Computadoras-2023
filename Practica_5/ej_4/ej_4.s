.data
peso: .double 75.7
estatura: .double 1.73
imc: .double 0.0
estado: .word 0
infra: .double 18.5
normal: .double 25.0
sobre: .double 30.0

.code
l.d f2, estatura(r0)  # F2 = Estatura
l.d f1, peso(r0)      # F1 = Peso
mul.d f3, f2, f2      # F3 = Estatura x Estatura

l.d f10, infra(r0)
l.d f11, normal(r0)
l.d f12, sobre(r0)

div.d f4, f1, f3      # F4 = Peso / Estatura x Estatura
s.d f4, imc(r0)       # Guardo imc

c.lt.d f4, f10        # Infrapeso
bc1t INFRAPESO
c.lt.d f4, f11        # Normal
bc1t NORMALPESO
c.lt.d f4, f12        # Sobrepeso / Obeso
bc1t SOBREPESO
bc1f OBESO

INFRAPESO: daddi r1, r0, 1
  sd r1, estado(r0)
  J termino
NORMALPESO: daddi r1, r0, 2
  sd r1, estado(r0)
  J termino
SOBREPESO: daddi r1, r0, 3
  sd r1, estado(r0)
  J termino
OBESO: daddi r1, r0, 4
  sd r1, estado(r0)
termino: halt


