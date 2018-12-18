# Parcial Funcional

## 1.
Dada las siguientes definiciones
```haskell
type Bit = O | I
data BitT = Nil | Bin Bool BitT BitT
```
La idea es que al recorrer `BitT` el `O` indica que el recorrido siguen para el 
subárbol izq y el `I` que sigue para el subárbol derecho.

Definir las siguientes funciones usando pattern matching.

#### a. `contains :: [Bit] -> BitT -> Bool`
`contains` recibe una lista de `Bit`s y un árbol `BitT` y dice si la lista se 
encuentra en el árbol, es decir, si siguiendo el recorrido de pasos indicado 
por la lista se arriba a un nodo que tiene el `Bool` en `True`.

#### b. `insert :: [Bit] -> BitT -> BitT`
Recibe una lista de `Bit`s y el árbol árbol resultante es igual al árbol 
recibido que además tiene el nodo indicad (al que se arriba a partir de la 
lista de `Bit`s) en `True`.

#### c. `intersect :: BitT -> BitT -> BitT`
Recibe dos árboles y retorna un árbol que solo contiene los nodos en los que 
ámbos árboles coinciden en `True`.


## 2. Demostrar que `contains bs (intersect ta tb) = contains bs ta && contains bs tb`

## 3. Definir y dar el tipo de una función **fold** para `BitT` (**foldBitT**)

## 4. Definir las siguientes funciones utilizando esquemas (**fold**, **foldBitT**, etc)

Sea `type MHash a = a -> [[Bit]]` es decir, `MHash` es una función que recibe un 
tipo de dato `a` y lo convierte a una lista de cadenas de `Bit`s.


#### a. `size :: BitT -> Int`
Recibe un árbol `BitT` y devuelve la cantidad de nodos en `True` de dicho 
árbol.

#### b. `containsMH :: MHash a -> a -> BitT -> Bool`
Recibe una dato `a` y una función que a partir del dato obtiene sus 
representaciones en arreglos de `Bit`s y un árbol y devuelve si todas las
representaciones del dato se encuentra en el árbol. Esto sería, si todas las
listas de `Bit`s obtenidas a partir del dato indican un camino en el árbol
que arriba a un nodo `True`.

#### c. `insertMH :: MHash a -> a -> BitT -> BitT`
Recibe un dato `a` y una función para pasarlo a listas de `Bit`s y un árbol
e inserta todas las listas de bits en el árbol.

#### d. `allBits :: BitT -> [[Bit]]`
Dado un árbol devuelve todas las cadenas para las que los nodos de ese árbol 
contienen en `True`.

#### e. `longestOs :: BitT -> Int`
Devuelve la longitud de la rama más larga de nodos hacia la izquierda seguidos.

```
      False
     /     \
  True      False
  /  \       /   \
Nil  Nil   False  True
          /  \      / \
      True   Nil   Nil Nil
      /  \
    Nil   Nil

En este árbol la cadena más larga sería [I,O,O] de longitud 2 (el [O,O] es de long 2)
```
