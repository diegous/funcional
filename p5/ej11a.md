## Demostrar `fastrev ys xs = (fastrev [] xs) ++ ys` para todas listas xs, ys

La propiedad para demostrar es la siguiente
para todo xs. para todo ys. `fastrev ys xs = (fastrev [] xs) ++ ys`

_Por inducción en la estructura de la lista xs_


### Caso xs = []
```
fastrev ys []
=                       (def fastrev)
ys


(fastrev [] []) ++ ys
=                       (def fastrev)
[] ++ ys
=                       (def ++)
ys
```

### Caso xs = x:xs'

mal HI:            `fastrev (x:ys) xs' = (fastrev [x] xs') ++ ys`
HI: para todo ys'. `fastrev ys' xs' = (fastrev []  xs') ++ ys'`
```
fastrev ys (x:xs')
=                       (def fastrev)
fastrev (x:ys) xs'
=                       (HI con ys' = x:ys)
(fastrev [x] xs') ++ ys


(fastrev [] (x:xs')) ++ ys
=                       (def fastrev)
(fastrev (x:[]) xs') ++ ys
=                       (sintaxis listas)
(fastrev [x] xs') ++ ys
```
