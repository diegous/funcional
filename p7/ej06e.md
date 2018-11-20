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

```

