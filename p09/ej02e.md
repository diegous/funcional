# e) Demostrar la equivalencia de las funciones definidas en los ı́tems (b) y (d)

## `heightBin`
Se quiere demostrar que `heightBin t = heightBin' t`, para todo t::BinTree

### Caso t = Empty
```
heightBin Empty
=         def heightBin.1
0



heightBin' Empty
=         def heightBin'
foldBin 0 f Empty
=         def foldBin.1
0
```

### Caso t = Bin a t1 t2
_HI.1: `heightBin t1 = heightBin' t1` para todo t1::BinTree_  
_HI.2: `heightBin t2 = heightBin' t2` para todo t2::BinTree_
```
heightBin (Bin a t1 t2)
=         def heightBin.2
1 + (heightBin t1) `max` (heightBin t2)
=         HI1 & HI2
1 + (heightBin' t1) `max` (heightBin' t2)



heightBin' (Bin a t1 t2)
=         def heightBin'
foldBin 0 f (Bin a t1 t2)
=         def foldBin.2
f x (foldBin z f t1) (foldBin z f t2)
=         def f
1 + (foldBin 0 f t1) `max` (foldBin 0 f t2)
=         def heightBin'
1 + (heightBin' t1) `max` (heightBin' t2)    <=== Quedó igual
```


---


## `nodesBin`
Se quiere demostrar que `nodesBin t = nodesBin' t`, para todo t::BinTree

### Caso t = Empty
```
nodesBin Empty
=         def nodesBin.1
0



nodesBin' Empty
=         def nodesBin'
foldBin 0 f Empty
=         def foldBin.1
0
```

### Caso t = Bin a t1 t2
_HI.1: `nodesBin t1 = nodesBin' t1` para todo t1::BinTree_  
_HI.2: `nodesBin t2 = nodesBin' t2` para todo t2::BinTree_
```
nodesBin (Bin a t1 t2)
=         def nodesBin.2
1 + (nodesBin t1) + (nodesBin t2)
=         HI1 & HI2
1 + (nodesBin' t1) + (nodesBin' t2)



nodesBin' (Bin a t1 t2)
=         def nodesBin'
foldBin 0 f (Bin a t1 t2)
=         def foldBin.2
f x (foldBin z f t1) (foldBin z f t2)
=         def f
1 + (foldBin 0 f t1) + (foldBin 0 f t2)
=         def nodesBin'
1 + (nodesBin' t1) + (nodesBin' t2)    <=== Quedó igual
```


---


## `mapBin`
Se quiere demostrar que `mapBin h t = mapBin' h t`, para todo t::BinTree

### Caso t = Empty
```
mapBin h Empty
=         def mapBin.1
0



mapBin' h Empty
=         def mapBin'
(foldBin Empty (Bin . h)) Empty
=         def foldBin.1
0
```

### Caso t = Bin a t1 t2
_HI.1: `mapBin h t1 = mapBin' h t1` para todo t1::BinTree_  
_HI.2: `mapBin h t2 = mapBin' h t2` para todo t2::BinTree_
```
mapBin h (Bin a t1 t2)
=         def mapBin.2
Bin (h a) (mapBin h t1) (mapBin h t2)
=         HI1 & HI2
Bin (h a) (mapBin' h t1) (mapBin' h t2)



mapBin' h (Bin a t1 t2)
=         def mapBin'
foldBin Empty (Bin . h) (Bin a t1 t2)
=         def foldBin.2
(Bin . h) a (foldBin Empty (Bin . h) t1) (foldBin Empty (Bin . h) t2)
=         def (.)
Bin (h a) (foldBin Empty (Bin . h) t1) (foldBin Empty (Bin . h) t2)h
=         def mapBin'
Bin (h a) (mapBin' h t1) (mapBin' h t2)    <=== Quedó igual
```

---

## `mirrorBin`
Se quiere demostrar que `mirrorBin t = mirrorBin' t`, para todo t::BinTree

### Caso t = Empty
```
mirrorBin Empty
=         def mirrorBin.1
Empty



mirrorBin' Empty
=         def mirrorBin'
foldBin Empty (flip . Bin) Empty
=         def foldBin.1
Empty
```

### Caso t = Bin a t1 t2
_HI.1: `mirrorBin t1 = mirrorBin' t1` para todo t1::BinTree_  
_HI.2: `mirrorBin t2 = mirrorBin' t2` para todo t2::BinTree_
```
mirrorBin (Bin a t1 t2)
=         def mirrorBin.2
Bin a (mirrorBin t2) (mirrorBin t1)
=         HI1 & HI2
Bin a (mirrorBin' t2) (mirrorBin' t1)



mirrorBin' (Bin a t1 t2)
=         def mirrorBin'
foldBin Empty (flip . Bin) (Bin a t1 t2)
=         def foldBin.2
(flip . Bin) a (foldBin Empty (flip . Bin) t1) (foldBin Empty (flip . Bin) t2)
=         def (.)
flip (Bin a (foldBin Empty (flip . Bin) t1) (foldBin Empty (flip . Bin) t2))
=         def flip
Bin a (foldBin Empty (flip . Bin) t2) (foldBin Empty (flip . Bin) t1)
=         def mirrorBin'
Bin a (mirrorBin' t2) (mirrorBin' t1)     <== Quedó igual
```
