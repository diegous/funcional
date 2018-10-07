import Data.Char (ord)
import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- sum'
          TestCase (assertEqual "sum'"  0 (sum' [])),
          TestCase (assertEqual "sum'"  0 (sum' [0])),
          TestCase (assertEqual "sum'"  1 (sum' [0,0,0,1,0])),
          TestCase (assertEqual "sum'" 15 (sum' [1,2,3,4,5])),

          -- any'
          TestCase (assertEqual "any'" False (any' [])),
          TestCase (assertEqual "any'" False (any' [False, False, False])),
          TestCase (assertEqual "any'" True  (any' [False, False, True, False])),
          TestCase (assertEqual "any'" True  (any' [True, True, True, True])),

          -- all'
          TestCase (assertEqual "all'" True  (all' [])),
          TestCase (assertEqual "all'" True  (all' [True,True,True])),
          TestCase (assertEqual "all'" False (all' [True, True, False, True])),
          TestCase (assertEqual "all'" False (all' [False, False, False, False])),

          -- codes
          TestCase (assertEqual "codes" []  (codes [])),
          TestCase (assertEqual "codes" [97]  (codes ['a'])),
          TestCase (assertEqual "codes" [122, 97]  (codes ['z', 'a'])),
          TestCase (assertEqual "codes" [122, 98, 97]  (codes ['z', 'b', 'a'])),

          -- remainders
          TestCase (assertEqual "remainders" []  (remainders 5 [])),
          TestCase (assertEqual "remainders" [1, 2, 3, 4, 0, 1, 2, 3, 4, 0]  (remainders 5 [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])),

          -- squares
          TestCase (assertEqual "squares" []  (squares [])),
          TestCase (assertEqual "squares" [1,4,9,16,25]  (squares [1,2,3,4,5])),

          -- lengths
          TestCase (assertEqual "lengths" []  (lengths [])),
          TestCase (assertEqual "lengths" [0, 1, 2, 3, 4]  (lengths [[], [1], [1,2], [1,2,3], [1,2,3,4]])),

          -- order
          TestCase (assertEqual "order" []             (order [])),
          TestCase (assertEqual "order" []             (order [(9,1), (9,2), (9,3)])),
          TestCase (assertEqual "order" [(9,4), (9,5)] (order [(9,1), (9,2), (9,3), (9,4), (9,5)])),

          -- pairs
          TestCase (assertEqual "pairs" []        (pairs [])),
          TestCase (assertEqual "pairs" []        (pairs [1, 3, 5, 7, 9, 11])),
          TestCase (assertEqual "pairs" [2, 4, 6] (pairs [1, 2, 3, 4, 5, 6])),

          -- chars
          TestCase (assertEqual "chars" []              (chars [])),
          TestCase (assertEqual "chars" []              (chars ['1', '2', '3'])),
          TestCase (assertEqual "chars" ['a', 'b', 'c'] (chars ['1', '2', '3', 'a', 'b', 'c'])),

          -- moreThan
          TestCase (assertEqual "moreThan" ([]::[[Int]])      (moreThan ([]::[[Int]]) 2)),
          TestCase (assertEqual "moreThan" []                 (moreThan [[1], [1,2], [2,1], [2], []] 2)),
          TestCase (assertEqual "moreThan" [[1,2,3], [4,5,6]] (moreThan [[1], [1,2], [1,2,3], [], [4,5,6]] 2)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
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

