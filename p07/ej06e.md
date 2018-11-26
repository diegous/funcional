# Demostrar `concat . map concat = concat . concat`

Por principio de extensionalidad, es lo mismo que
```haskell
(concat . map concat) xs = (concat . concat) xs
-- aplicando (.) es equivalente a
concat (map concat xs) = concat (concat xs)
```

Por inducción en la estructura de las listas

## Caso xs = []
```
concat (map concat [])
=       def map
concat []
=       def concat
[]




concat (concat [])
=       def concat
concat []
=       def concat
[]                      <== quedó igual
```


## Caso xs = y:ys
**HI: `concat (map concat ys) = concat (concat ys)`**
```
concat (map concat (y:ys))
=       def map
concat (concat y : map concat ys))
^^^^^^
=       def concat
(concat y) ++ (concat (map concat ys))





concat (concat (y:ys))
        ^^^^^^
=       def concat
concat (y ++ (concat ys))
=       lema 1 (abajo)
concat y ++ concat (concat ys)
=       HI
concat y ++ concat (map concat ys)    <== Quedó igual :D

```


**lema 1**

Se va a demostrar que `concat (xs++ys) = concat xs ++ concat ys` para toda lista `xs` e `ys`

_Caso xs = []_
```
concat ([]++ys)
=         def (++)
concat ys



concat [] ++ concat ys
=         def concat.1
[] ++ concat ys
=         def (++).1
concat ys
```

_Caso xs = x:xs'_

_HI: concat (xs' ++ ys) = concat xs' ++ concat ys_
```
concat ((x:xs') ++ ys)
=         def (++).2
concat (x:xs' ++ ys)
=         def concat.2
x ++ concat (xs' ++ ys)
=         HI
x ++ concat xs' ++ concat ys



concat (x:xs') ++ concat ys
=         def concat.2
(x ++ concat xs') ++ concat ys
=         saco paréntesis
x ++ concat xs' ++ concat ys    <== Quedó igual
```
