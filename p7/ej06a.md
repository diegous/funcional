## Demostrar `map f (xs ++ ys) = map f xs ++ map f ys`
La propiedad a demostrar es que

_para todo xs. para todo ys. se cumple `map f (xs ++ ys) = map f xs ++ map f ys`_

_Por inducción en la estructura de la lista xs_

### Caso xs = []
```
map f ([] ++ ys)
=             def (++)
map f ys


map f [] ++ map f ys
=             def map
[] ++ map f ys
=             propiedad neutro listas
map f ys
```

### Caso xs = x:xs'
_HI: `map f (xs' ++ ys) = map f xs' ++ map f ys`_
```
map f ((x:xs') ++ ys)
=             def (++)
map f (x : xs' ++ ys)
=             def map
f x : map f (xs' ++ ys)


map f (x:xs') ++ (map f ys)
=             def map
f x : map f xs' ++ map f ys
=             HI
f x : map f (xs' ++ ys)
```
