## Demostrar `map f . concat = concat . map (map f)`
Por principio de extensionalidad, es lo mismo que
```haskell
(map f) . concat xss = concat . (map (map f)) xss
```

_Por inducción en la estructura de la lista xss_

### Caso xss = []
```
(map f) . concat []
=             def concat
map f []
=             def map
[]


concat . (map (map f)) []
=             def map
concat []
=             def concat
[]
```

### Caso xss = xs:xss'
_HI: `map f . concat xss' = concat . map (map f) xss'`_
```
concat (map (map f) (xs:xss'))
=             def map
concat (map f xs):(map (map f) xss')
=             def concat
(map f xs) ++ (concat . map (map f) xss')
=             HI
(map f xs) ++ (map f . concat xss')
=             def (++)




(map f) . concat (xs:xss')
=             def concat
map f (xs ++ (concat xss'))

```
SIN TERMINAR, CÓMO SIGO ACÁ?
No puedo sacar a `xs` así nomás porque es parte de otra lista
