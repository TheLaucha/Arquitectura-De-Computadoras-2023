.data
base: .double 5.85
altura: .double 13.47
sup: .double 0.0

.code
l.d f1, base(r0)    # F1 = Base
l.d f2, altura(r0)  # F2 = Altura
mul.d f3, f1, f2    # F3 = Base x Altura

daddi r2, r0, 2
mtc1 r2, f4         # F4 = 2
cvt.d.l f5, f4      # F5 = 2.0

div.d f6, f3, f5    # F5 = Resultado
s.d f6, sup(r0)
halt