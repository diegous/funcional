import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- seven
          TestCase (assertEqual "seven" 7 (seven "something")),

          -- sign
          TestCase (assertEqual "sign" 1    (sign 10)),
          TestCase (assertEqual "sign" (-1) (sign (10-20))),
          TestCase (assertEqual "sign" 0    (sign (10-10))),

          -- absolute
          TestCase (assertEqual "absolute" 10 (absolute 10)),
          TestCase (assertEqual "absolute" 10 (absolute (-10))),
          TestCase (assertEqual "absolute" 0  (absolute 0)),

          -- absolute'
          TestCase (assertEqual "absolute'" 10 (absolute' 10)),
          TestCase (assertEqual "absolute'" 10 (absolute' (-10))),
          TestCase (assertEqual "absolute'" 0  (absolute' 0)),

          -- and'
          TestCase (assertEqual "and'" True  (and' True True)),
          TestCase (assertEqual "and'" False (and' True False)),
          TestCase (assertEqual "and'" False (and' False True)),
          TestCase (assertEqual "and'" False (and' False False)),

          -- or'
          TestCase (assertEqual "or'" True  (or' True True)),
          TestCase (assertEqual "or'" True  (or' True False)),
          TestCase (assertEqual "or'" True  (or' False True)),
          TestCase (assertEqual "or'" False (or' False False)),

          -- not'
          TestCase (assertEqual "not'" True  (not' False)),
          TestCase (assertEqual "not'" False (not' True)),

          -- xor'
          TestCase (assertEqual "xor'" False (xor' True True)),
          TestCase (assertEqual "xor'" True  (xor' True False)),
          TestCase (assertEqual "xor'" True  (xor' False True)),
          TestCase (assertEqual "xor'" False (xor' False False)),

          -- dividesTo
          TestCase (assertEqual "dividesTo" True  (dividesTo 2 4)),
          TestCase (assertEqual "dividesTo" False (dividesTo 2 3)),

          -- isMultiple
          TestCase (assertEqual "isMultiple" True  (isMultiple 4 2)),
          TestCase (assertEqual "isMultiple" False (isMultiple 4 3)),

          -- isCommonDivisor
          TestCase (assertEqual "isCommonDivisor" True  (isCommonDivisor 2 (4, 6))),
          TestCase (assertEqual "isCommonDivisor" False (isCommonDivisor 2 (4, 7))),
          TestCase (assertEqual "isCommonDivisor" False (isCommonDivisor 2 (5, 8))),
          TestCase (assertEqual "isCommonDivisor" False (isCommonDivisor 2 (5, 9))),

          -- isCommonMult
          TestCase (assertEqual "isCommonMult" True  (isCommonMult 10 (2, 5))),
          TestCase (assertEqual "isCommonMult" False (isCommonMult 10 (2, 3))),
          TestCase (assertEqual "isCommonMult" False (isCommonMult 10 (3, 2))),
          TestCase (assertEqual "isCommonMult" False (isCommonMult 10 (3, 4))),

          -- swap
          TestCase (assertEqual "isCommonMult" (1, 2) (swap (2, 1))),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Functions

seven :: c -> Int
seven x = 7


sign :: Int -> Int
sign x | x == 0 = 0
       | otherwise = div x (abs x)


absolute :: Int -> Int
absolute  x = x * (sign x)


absolute' :: Int -> Int
absolute' x | x < 0 = x * (-1)
            | otherwise = x


and' :: Bool -> Bool -> Bool
and' True True = True
and' _    _    = False


or' :: Bool -> Bool -> Bool
or' False False = False
or' _     _     = True


not' :: Bool -> Bool
not' False = True
not' True  = False


xor' :: Bool -> Bool -> Bool
xor' x y = not' (x == y)

dividesTo :: Int -> Int -> Bool
dividesTo x y = (mod y x) == 0


isMultiple :: Int -> Int -> Bool
isMultiple x y = dividesTo y x


isCommonDivisor :: Int -> (Int, Int) -> Bool
isCommonDivisor divisor (n1, n2) = (dividesTo divisor n1) && (dividesTo divisor n2)


isCommonMult :: Int -> (Int, Int) -> Bool
isCommonMult mult (n1, n2) = (dividesTo n1 mult) && (dividesTo n2 mult)


swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)
