b) Demostrar que la implementación dada termina para todo par de enteros.

Caso b = 0)

mcd a b
=           (def. mcd)
a


Caso b > 0)
HI1: "r = a `mod` b" termina
HI2: "mcd b r" termina

mcd a b
=           (def. mcd)
mcd b (a `mod` b)
=           (arit. y HI1)
mcd b r
=           (HI2)
n
