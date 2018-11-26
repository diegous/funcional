# Demostrar `map (map f) . map (x:) = map ((f x):) . map (map f)`

Por principio de extensionalidad, es lo mismo que:
```haskell
(map (map f) . map (x:)) xs = ((map ((f x):)) . (map (map f))) xs
-- es equivalente a
map (map odd) (map (1:) xs) = ((map ((f x):)) . (map (map f))) xs
```

Por inducción en la estructura de las listas:

## Caso xs = []
```
map ((map f) . map (x:)) []
=         def map
[]


((map ((f x):)) . (map (map f))) []
=         def (.)
map ((f x):) (map (map f) [])
=         def map
map ((f x):) []
=         def map
[]
```


## Caso xs = y:ys
**HI: `(map (map f) . map (x:)) ys = map ((f x):) (map (map f) ys)`**
```
(map (map f) . map (x:)) (y:ys)
 ^^^
=         def (.)
map (map f) (map (x:) y:ys)
             ^^^
=         def map
map (map f) ((x:) y : map (x:) ys)
               ^^
=         def (:)
map (map f) ((x:y) : map (x:) ys)
^^^
=         def map
(map f) (x:y) : map (map f) (map (x:) ys)
                ^^^^^^^^^^^^^^^^^^^^^^^^^
=         def (.)
(map f) (x:y) : (map (map f) . map (x:)) ys
^^^^^^^
=         equiv paréntesis
map f (x:y) : (map (map f) . map (x:)) ys
^^^
=         def map
(f x:map f y) : (map (map f) . map (x:)) ys






map ((f x):) (map (map f) (y:ys))
              ^^^
=         def map
map ((f x):) ((map f y):map (map f) ys)
^^^
=         def map
((f x):) (map f y) : map ((f x):) (map (map f) ys)
      ^^
=         def (:)
((f x):map f y) : map ((f x):) (map (map f) ys)
 ^^^^^
=         arit paréntesis
(f x:map f y) : map ((f x):) (map (map f) ys)
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
=         HI
(f x:map f y) : (map (map f) . map (x:)) ys           <==== quedó igual
```
