## Demuestre que `reverse = rev`

_Por principio de extencionalidad, es lo mismo que `reverse xs = rev xs`_

_Por inducción en la estructura de las listas_

**Caso xs = [])**
```
reverse xs
=                 (def xs)
reverse []
=                 (def reverse)
[]

rev xs
=                 (def rev)
fastrev [] xs
=                 (def xs)
fastrev [] []
=                 (def fastrev)
[]
```

**Caso xs = l:ls**

HI: reverse ls = rev ls
```
reverse xs
=                 (def xs)
reverse (l:ls)
=                 (def reverse)
reverse ls ++ [l]
=                 (HI)
(rev ls) ++ [l]



rev xs
=                 (def rev)
fastrev [] xs
=                 (def xs)
fastrev [] (l:ls)
=                 (def fastrev)
fastrev (l:[]) ls
=                 (Lema 1)
(fastrev [] ls) ++ [l]
=                 (def rev)
(rev ls) ++ [l]
```
