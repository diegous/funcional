module Ej04B
  where

data Stack a = Pila [a] deriving (Eq, Show)

-- emptyS crea una pila vacı́a.
emptyS :: Stack a
emptyS = Pila []

-- isEmptyS indica si la pila está vacı́a.
isEmptyS :: Stack a -> Bool
isEmptyS (Pila []) = True
isEmptyS _         = False

-- pushS devuelve la pila luego de insertar el elemento dado como argumento.
pushS :: a -> Stack a -> Stack a
pushS a (Pila xs) = Pila (a:xs)

-- popS que devuelve la pila a la que se le sacó el elemento del tope. La
-- operación es parcial, estando indefinida para la pila vacı́a.
popS :: Stack a -> Stack a
popS (Pila (x:xs)) = (Pila xs)

-- topS da el elemento que está al tope de la pila. La operación es parcial,
-- estando indefinida para la pila vacı́a.
topS :: Stack a -> a
topS (Pila (x:xs)) = x

-- sizeS informa el tamaño de la pila.
sizeS :: Stack a -> Int
sizeS (Pila xs) = length xs
