.data
    peso: .double 75.7
    talla: .double 1.73
    IMC: .double 0.0
    Estado: .word 0

.code
    l.d f2,talla($zero)
    mul.d f2,f2,f2
    l.d f1,peso($zero)
    l.d f3,IMC($zero)
    div.d f3,f1,f2

    c.lt.d ,f3,18
    halt
