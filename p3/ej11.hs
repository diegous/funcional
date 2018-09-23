import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- sumDigit'
          TestCase (assertEqual ""  1 (sumDigit '0' 1)),
          TestCase (assertEqual ""  2 (sumDigit '1' 1)),
          TestCase (assertEqual ""  3 (sumDigit '2' 1)),
          TestCase (assertEqual ""  4 (sumDigit '3' 1)),
          TestCase (assertEqual ""  5 (sumDigit '4' 1)),
          TestCase (assertEqual ""  6 (sumDigit '5' 1)),
          TestCase (assertEqual ""  7 (sumDigit '6' 1)),
          TestCase (assertEqual ""  8 (sumDigit '7' 1)),
          TestCase (assertEqual ""  9 (sumDigit '8' 1)),
          TestCase (assertEqual "" 10 (sumDigit '9' 1)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Functions

-- Sacado de teoría PF-02.1.ValoresYExpresiones.pdf
compose :: ((a -> b),(c -> a)) -> c -> b
compose (f,g) = h where h x = f (g x)

digitValue :: Char -> Int
digitValue '0' = 0
digitValue '1' = 1
digitValue '2' = 2
digitValue '3' = 3
digitValue '4' = 4
digitValue '5' = 5
digitValue '6' = 6
digitValue '7' = 7
digitValue '8' = 8
digitValue '9' = 9

addSome :: Int -> (Int -> Int)
addSome x = (+x)

sumDigit :: Char -> Int -> Int
sumDigit c n = compose ((addSome n),digitValue) c
