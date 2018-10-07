## Demostrar `fastrev ys xs = (fastrev [] xs) ++ ys` para todas listas xs, ys

_Por inducción en la estructuras de las listas_

**Caso xs = [])**
```
fastrev ys xs
=                       (def fastrev)
ys


(fastrev [] xs) ++ ys
=                       (def fastrev)
[] ++ ys
=                       (def ++)
ys
```

**Caso xs = l:ls)**

HI: `fastrev (l:ys) ls = (fastrev [l] ls) ++ ys`
```
fastrev ys xs
=                       (def fastrev)
fastrev (l:ys) ls
=                       (HI)
(fastrev [l] ls) ++ ys


(fastrev [] xs) ++ ys
=                       (def fastrev)
(fastrev (l:[]) ls) ++ ys
=                       (sintaxis listas)
(fastrev [l] ls) ++ ys
```
