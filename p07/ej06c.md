# Demostrar `filter p (xs ++ ys) = filter p xs ++ filter p ys`
Propiedad a demostrar:

_Para toda lista xs. para toda lista ys. se cumple que `filter p (xs ++ ys) = filter p xs ++ filter p ys`_

Por inducción en la estrucuta de la lista `xs`:

## Caso xs = []
```
filter p ([] ++ ys)
=       arit de listas
filter p ys


filter p [] ++ filter p ys
=       def filter
[] ++ filter p ys
=       arit listas
filter p ys
```

## Caso xs = x:xs'
**HI: `filter p (xs' ++ ys) = filter p xs' ++ filter p ys`**
```
filter p ((x:xs') ++ ys)
=       def (++)
filter p (x:xs' ++ ys)
  =       def filter y (p x) es True
  x:filter p (xs' ++ ys)
  =       HI
  x:filter p xs' ++ filter p ys

  =       def filter y (p x) es False
  filter p (xs' ++ ys)
  =       HI
  filter p xs' ++ filter p ys


filter p (x:xs') ++ filter p ys
  =       def filter y (p x) es True
  (x:filter p xs') ++ filter p ys
  =       def (++)
  x:filter p xs' ++ filter p ys     <== quedó igual

  =       def filter y (p x) es False
  filter p xs' ++ filter p ys       <== quedó igual
```


