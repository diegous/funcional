import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- nextDiv
            -- normal cases
          TestCase (assertEqual "nextDiv"  (-2) (nextDiv (-3) 2)),
          TestCase (assertEqual "nextDiv"  (-1) (nextDiv (-2) 2)),
          TestCase (assertEqual "nextDiv"  1 (nextDiv (-1)  0)),
          TestCase (assertEqual "nextDiv"  1 (nextDiv (-1)  2)),
          TestCase (assertEqual "nextDiv"  1 (nextDiv   0   2)),
          TestCase (assertEqual "nextDiv"  2 (nextDiv   1   2)),
          TestCase (assertEqual "nextDiv"  1 (nextDiv   0  10)),
          TestCase (assertEqual "nextDiv"  2 (nextDiv   1  10)),
          TestCase (assertEqual "nextDiv"  5 (nextDiv   2  10)),
          TestCase (assertEqual "nextDiv" 10 (nextDiv   5  10)),

          -- edge cases: estos darían bottom (no terminan nunca)
          -- TestCase (assertEqual "nextDiv"  0 (nextDiv  10  10)),
          -- TestCase (assertEqual "nextDiv"  0 (nextDiv  11  10)),

          -- sumDivs
          TestCase (assertEqual "sumDivs"  1 (sumDivs 1)),
          TestCase (assertEqual "sumDivs"  3 (sumDivs 2)),
          TestCase (assertEqual "sumDivs"  7 (sumDivs 4)),
          TestCase (assertEqual "sumDivs"  6 (sumDivs 5)),
          TestCase (assertEqual "sumDivs" 12 (sumDivs 6)),
          TestCase (assertEqual "sumDivs"  8 (sumDivs 7)),
          TestCase (assertEqual "sumDivs" 15 (sumDivs 8)),
          TestCase (assertEqual "sumDivs" 13 (sumDivs 9)),

          -- power
          TestCase (assertEqual "power"  1 (power 2 0)),
          TestCase (assertEqual "power"  2 (power 2 1)),
          TestCase (assertEqual "power"  4 (power 2 2)),
          TestCase (assertEqual "power"  8 (power 2 3)),
          TestCase (assertEqual "power" 16 (power 2 4)),
          TestCase (assertEqual "power" 32 (power 2 5)),

          -- dividesTo
          TestCase (assertEqual "dividesTo" False (dividesTo 0 7)),
          TestCase (assertEqual "dividesTo" True  (dividesTo 1 7)),
          TestCase (assertEqual "dividesTo" False (dividesTo 2 7)),
          TestCase (assertEqual "dividesTo" False (dividesTo 3 7)),
          TestCase (assertEqual "dividesTo" False (dividesTo 4 7)),
          TestCase (assertEqual "dividesTo" False (dividesTo 5 7)),
          TestCase (assertEqual "dividesTo" False (dividesTo 6 7)),
          TestCase (assertEqual "dividesTo" True  (dividesTo 7 7)),
          TestCase (assertEqual "dividesTo" False (dividesTo 8 7)),

          -- sum'
          TestCase (assertEqual "sum'"  0 (sum' succ 1 0)),
          TestCase (assertEqual "sum'" 66 (sum' succ 0 10)),
          TestCase (assertEqual "sum'" 51 (sum' succ 5 10)),

          -- prime
          TestCase (assertEqual "prime" False (prime  0)),
          TestCase (assertEqual "prime" False (prime  1)),
          TestCase (assertEqual "prime" True  (prime  2)),
          TestCase (assertEqual "prime" True  (prime  3)),
          TestCase (assertEqual "prime" False (prime  4)),
          TestCase (assertEqual "prime" True  (prime  5)),
          TestCase (assertEqual "prime" False (prime  6)),
          TestCase (assertEqual "prime" True  (prime  7)),
          TestCase (assertEqual "prime" False (prime  8)),
          TestCase (assertEqual "prime" False (prime  9)),
          TestCase (assertEqual "prime" False (prime 10)),
          TestCase (assertEqual "prime" True  (prime 11)),
          TestCase (assertEqual "prime" False (prime 12)),
          TestCase (assertEqual "prime" True  (prime 13)),
          TestCase (assertEqual "prime" False (prime 14)),

          -- phi
          TestCase (assertEqual "phi"  2 (phi  1)),
          TestCase (assertEqual "phi"  3 (phi  2)),
          TestCase (assertEqual "phi"  5 (phi  3)),
          TestCase (assertEqual "phi"  7 (phi  4)),
          TestCase (assertEqual "phi" 11 (phi  5)),
          TestCase (assertEqual "phi" 13 (phi  6)),
          TestCase (assertEqual "phi" 17 (phi  7)),
          TestCase (assertEqual "phi" 19 (phi  8)),
          TestCase (assertEqual "phi" 23 (phi  9)),
          TestCase (assertEqual "phi" 29 (phi 10)),
          TestCase (assertEqual "phi" 31 (phi 11)),
          TestCase (assertEqual "phi" 37 (phi 12)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Definir recursivamente las siguientes funciones y dar sus tipos:

-- nextDiv, toma dos números x, y y devuelve el primer divisor de y mayor que x.
nextDiv :: Int -> Int -> Int
nextDiv (-1) _ = 1 -- empezando de -1 el próximo divisor de n es siempre 1
nextDiv x y | mod y (x+1) == 0 = (x+1)
            | otherwise        = nextDiv (x+1) y


-- sumDivs, toma un número y devuelve la suma de sus divisores.
-- acá voy a asumir que solo quiere los divisores positivos, si no esto siempre da 0
sumDivs :: Int -> Int
sumDivs x = sumDivsOf x 1

sumDivsOf :: Int -> Int -> Int
sumDivsOf n current | n == current = n -- n siempre es divisor de n
                    | otherwise = divValue + (sumDivsOf n (current+1))
                    where divValue = if mod n current == 0
                                     then current
                                     else 0


-- power, que toma un número y un natural, y devuelve el resultado de elevar el primero a la potencia dada
-- por el segundo.
power :: Int -> Int -> Int
power _ 0 = 1
power n 1 = n
power n p = n * (power n (p-1))


-- dividesTo, de la práctica 1 (toma dos números y dice si el primero divide al segundo)
dividesTo :: Int -> Int -> Bool
dividesTo 0 _ = False
dividesTo x y = isMult 1 x y

isMult :: Int -> Int -> Int -> Bool
isMult factor n product | factor * n == product = True
                        | factor * n > product  = False
                        | otherwise             = isMult (factor+1) n product


-- sum, tal que sum f i j = la sumatoria de k=i..j de f(k)
sum' :: (Int -> Int) -> Int -> Int -> Int
sum' f start end | start > end = 0
                 | start == end = f end
                 | otherwise    = (f start) + (sum' f (start+1) end)


-- prime, que decide si un n número es primo.
prime :: Int -> Bool
prime n = if n < 2
          then False
          else (nextDiv 1 n) == n


-- phi, que toma un entero i y devuelve el i-ésimo número primo.
phi :: Int -> Int
phi n = nextPrime n 1

nextPrime :: Int -> Int -> Int
nextPrime 0 candidato = candidato - 1
nextPrime cantPrimos candidato = if (prime candidato)
                                 then nextPrime (cantPrimos-1) (candidato+1)
                                 else nextPrime cantPrimos     (candidato+1)
