import Test.HUnit

-- estos los saqué de p4/ej01
nextDiv :: Int -> Int -> Int
nextDiv (-1) _ = 1 -- empezando de -1 el próximo divisor de n es siempre 1
nextDiv x y | mod y (x+1) == 0 = (x+1)
            | otherwise        = nextDiv (x+1) y

prime :: Int -> Bool
prime n = if n < 2
          then False
          else (nextDiv 1 n) == n

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- pal
          TestCase (assertEqual "pal" True  (pal "a") ),
          TestCase (assertEqual "pal" True  (pal "aa") ),
          TestCase (assertEqual "pal" False (pal "ab") ),
          TestCase (assertEqual "pal" True  (pal "abcde fgh i jk lm ml kj i hgf edcba") ),
          TestCase (assertEqual "pal" False (pal "abcde fgh i jk lm ml kj i igf edcba") ),
          TestCase (assertEqual "pal" True  (pal "abcde fgh i jk lm  ml kj i hgf edcba") ),
          TestCase (assertEqual "pal" False (pal "abcde fgh i jk lm ml kj i hgf edcba ") ),

          -- hs
          TestCase (assertEqual "hs" 0 (hs []) ),
          TestCase (assertEqual "hs" 4 (hs ["a", "b", "c", "h", "ah", "ha", "hoy", "haber", "eloyh"]) ),

          -- avgLength
          TestCase (assertEqual "avgLength" 0.0 (avgLength ["", "", "", ""]) ),
          TestCase (assertEqual "avgLength" 2.5 (avgLength ["a", "ab", "abc", "abcd"]) ),
          TestCase (assertEqual "avgLength" 2.0 (avgLength ["a", "ab", "abc", "abcd", ""]) ),

          -- adjacents
          TestCase (assertEqual "adjacents" ([]::[(Int,Int)])     (adjacents []) ),
          TestCase (assertEqual "adjacents" ([]::[(Int,Int)])     (adjacents [2]) ),
          TestCase (assertEqual "adjacents" [(2,4)]               (adjacents [2,4]) ),
          TestCase (assertEqual "adjacents" [(2,1),(1,11),(11,4)] (adjacents [2,1,11,4]) ),

          -- diffAdj
          TestCase (assertEqual "diffAdj" ([]::[(Int,Int)])    (diffAdj []) ),
          TestCase (assertEqual "diffAdj" ([]::[(Int,Int)])    (diffAdj [1]) ),
          TestCase (assertEqual "diffAdj" ([]::[(Int,Int)])    (diffAdj [1,2,3]) ),
          TestCase (assertEqual "diffAdj" [(2,4)]              (diffAdj [1,2,4,5]) ),
          TestCase (assertEqual "diffAdj" [(0,2),(2,8),(9,11)] (diffAdj [0,2,8,9,11,12]) ),

          -- remDups
          -- TestCase (assertEqual "remDups" ([]::[Int]) (remDups []) ),
          -- TestCase (assertEqual "remDups" [1]         (remDups [1]) ),
          -- TestCase (assertEqual "remDups" [1]         (remDups [1,1]) ),
          -- TestCase (assertEqual "remDups" [1,2,4,5,2] (remDups [1,2,2,4,5,5,2]) ),

          -- primes
          TestCase (assertEqual "primes" [2] (primes 1) ),
          TestCase (assertEqual "primes" [2,3] (primes 2) ),
          TestCase (assertEqual "primes" [2,3,5] (primes 3) ),


          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- pal, que determina si un string es palı́ndromo.
pal :: String -> Bool
pal s = s == (reverse s)

-- hs, que cuenta la cantidad de palabras que empiezan con h en una lista dada.
hs :: [String] -> Int
hs = let noBlanks = filter ((>0) . length)
         hWords   = filter ((=='h') . head)
      in  length . hWords . noBlanks

-- avgLength, que calcula la longitud promedio de las palabras de una lista.
avgLength :: [String] -> Float
avgLength xs = let total  = sum (map length xs)
                   amount = length xs
                in (fromIntegral total) / (fromIntegral amount)

-- adjacents, que tome una lista y retorna la lista de todos los pares ordenados de elementos adyacentes,
-- por ejemplo: adjacents [2, 1, 11, 4] = [(2,1),(1,11),(11,4)]
adjacents :: [a] -> [(a,a)]
adjacents xs = zip xs (tail xs)

-- diffAdj, que toma una lista de números y devuelve la lista de los pares ordenados de todos los números
-- adyacentes cuya diferencia es par.
diffAdj :: [Int] -> [(Int,Int)]
diffAdj xs = filter (\(x,y) -> even (x-y)) (adjacents xs)

-- remDups, que devuelve una lista con los mismos elementos que la original, pero eliminando todos aquellos
-- valores que fueran adyacentes e iguales, dejando una sola ocurrencia de cada uno.
-- remDups :: [Int] -> [Int]
-- remDups = foldr (\x ys -> if x == (head ys) then ys else x:ys) []


-- primes, que dado un entero n devuelve una lista con los n primeros primos.
primes :: Int -> [Int]
primes n = reverse ((foldr f []) (replicate n 1))
         where f n xs = if xs == [] then [nextPrime n]
                        else nextPrime (head xs):xs

nextPrime :: Int -> Int
nextPrime n = if prime (n+1)
              then n+1
              else nextPrime (n+1)
