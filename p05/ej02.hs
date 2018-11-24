import Data.Char (ord)
import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- sum'
         0 ~=? sum' []
      ,  0 ~=? sum' [0]
      ,  1 ~=? sum' [0,0,0,1,0]
      , 15 ~=? sum' [1,2,3,4,5]

        -- any'
      , False ~=? any' []
      , False ~=? any' [False, False, False]
      ,  True ~=? any' [False, False, True, False]
      ,  True ~=? any' [True, True, True, True]

        -- all'
      ,  True ~=? all' []
      ,  True ~=? all' [True,True,True]
      , False ~=? all' [True, True, False, True]
      , False ~=? all' [False, False, False, False]

        -- codes
      , []            ~=? codes []
      , [97]          ~=? codes ['a']
      , [122, 97]     ~=? codes ['z', 'a']
      , [122, 98, 97] ~=? codes ['z', 'b', 'a']

        -- remainders
      , [] ~=? remainders 5 []
      , [1, 2, 3, 4, 0, 1, 2, 3, 4, 0] ~=? remainders 5 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

        -- squares
      , [] ~=? squares []
      , [1,4,9,16,25] ~=? squares [1,2,3,4,5]

        -- lengths
      , [] ~=? lengths []
      , [0, 1, 2, 3, 4] ~=? lengths [[], [1], [1,2], [1,2,3], [1,2,3,4]]

        -- order
      , []             ~=? order []
      , []             ~=? order [(9,1), (9,2), (9,3)]
      , [(9,4), (9,5)] ~=? order [(9,1), (9,2), (9,3), (9,4), (9,5)]

        -- pairs
      , []        ~=? pairs []
      , []        ~=? pairs [1, 3, 5, 7, 9, 11]
      , [2, 4, 6] ~=? pairs [1, 2, 3, 4, 5, 6]

        -- chars
      , []              ~=? chars []
      , []              ~=? chars ['1', '2', '3']
      , ['a', 'b', 'c'] ~=? chars ['1', '2', '3', 'a', 'b', 'c']

        -- moreThan
      , ([]::[[Int]])      ~=? moreThan ([]::[[Int]]) 2
      , []                 ~=? moreThan [[1], [1,2], [2,1], [2], []] 2
      , [[1,2,3], [4,5,6]] ~=? moreThan [[1], [1,2], [1,2,3], [], [4,5,6]] 2
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Functions
-- 2. Definir recursivamente las siguientes funciones y dar sus tipos:
-- sum, suma los elementos de una lista de números.
sum' :: [Int] -> Int
sum' []     = 0
sum' (x:xs) = x + (sum' xs)

-- any, devuelve True si algún elemento de una lista es True.
any' :: [Bool] -> Bool
any' []     = False
any' (b:bs) = b || (any' bs)

-- all, devuelve True si todos los elementos de una lista son True.
all' :: [Bool] -> Bool
all' []     = True
all' (b:bs) = b && (all' bs)

-- codes, dada una lista de caracteres, devuelve la lista de sus códigos.
codes :: [Char] -> [Int]
codes []     = []
codes (c:cs) = (ord c):(codes cs)

-- remainders, dada una lista de números, devuelve los restos de su división por un número.
remainders :: Int -> [Int] -> [Int]
remainders d []     = []
remainders d (n:ns) = (n `mod` d):(remainders d ns)

-- squares, dada una lista de números, devuelve la lista de sus cuadrados.
squares :: [Int] -> [Int]
squares []     = []
squares (n:ns) = (n*n):(squares ns)

-- lengths, dada una lista de listas, devuelve la lista de sus longitudes.
lengths :: [[a]] -> [Int]
lengths []     = []
lengths (l:ls) = (length l):(lengths ls)

-- order, dada una lista de pares ordenados de números, devuelve la lista de aquellos
-- cuya primer componente es menor que el triple de la segunda.
order :: [(Int,Int)] -> [(Int,Int)]
order []          = []
order ((a,b):abs) = if a < (3 * b)
                    then (a,b):(order abs)
                    else order abs

-- pairs, dada una lista de números, devuelve la lista con aquellos que son pares.
pairs :: [Int] -> [Int]
pairs []     = []
pairs (n:ns) = if n `mod` 2 == 0
               then n:(pairs ns)
               else pairs ns

-- chars, dada una lista de caracteres, devuelve la lista de los que son letras.
chars :: [Char] -> [Char]
chars []     = []
chars (c:cs) = if ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z')
               then c:(chars cs)
               else chars cs

-- moreThan, dada una lista de listas xss y un número n, devuelve la lista de aquellas
-- listas de xss que tienen longitud mayor que n.
moreThan :: [[a]] -> Int -> [[a]]
moreThan [] _       = []
moreThan (xs:xss) n = if length xs > n
                      then xs:(moreThan xss n)
                      else moreThan xss n

