.data
    base: .double 5.85
    altura: .double 13.47
    dos: .double 2.0
.code
    l.d f1, base($zero)
    l.d f2, altura($zero)
    l.d f5, dos($zero)
    mul.d f3,f1,f2
    div.d f4,f3,f5
    halt