# Demostrar `map (f . g) = map f . map g`

Por principio de extensionalidad, es lo mismo que:
```haskell
map (f . g) xs = (map f . map g) xs
-- que es equivalente a
map (f . g) xs = map f (map g xs)
```

## Caso xs = []
```
map (f . g) []
=     def map
[]


map f (map g [])
=     def map
map f []
=     def map
[]
```

## Caso xs = y:ys
**HI: `map (f . g) ys = map f (map g ys)`**
```
map (f . g) (y:ys)
=     def map
(f . g) y : map (f . g) ys
=     HI
(f . g) y : map f (map g ys)


map f (map g (y:ys))
=     def map
map f (g y : map g ys)
=     def map
f (g y) : map f (map g ys)
=     def (.)
(f . g) y : map f (map g ys)      <== Quedó igual
```
