import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- seven
        7 ~=? seven "something"

        -- sign
      ,   1  ~=? sign 10
      , (-1) ~=? sign (10-20)
      ,   0  ~=? sign (10-10)

        -- absolute
      , 10 ~=? absolute 10
      , 10 ~=? absolute (-10)
      ,  0 ~=? absolute 0

        -- absolute'
      , 10 ~=? absolute' 10
      , 10 ~=? absolute' (-10)
      , 0  ~=? absolute' 0

        -- and'
      ,  True ~=? and' True True
      , False ~=? and' True False
      , False ~=? and' False True
      , False ~=? and' False False

        -- or'
      ,  True ~=? or' True True
      ,  True ~=? or' True False
      ,  True ~=? or' False True
      , False ~=? or' False False

        -- not'
      ,  True ~=? not' False
      , False ~=? not' True

        -- xor'
      , False ~=? xor' True True
      ,  True ~=? xor' True False
      ,  True ~=? xor' False True
      , False ~=? xor' False False

        -- dividesTo
      ,  True ~=? dividesTo 2 4
      , False ~=? dividesTo 2 3

        -- isMultiple
      ,  True ~=? isMultiple 4 2
      , False ~=? isMultiple 4 3

        -- isCommonDivisor
      ,  True ~=? isCommonDivisor 2 (4, 6)
      , False ~=? isCommonDivisor 2 (4, 7)
      , False ~=? isCommonDivisor 2 (5, 8)
      , False ~=? isCommonDivisor 2 (5, 9)

        -- isCommonMult
      ,  True ~=? isCommonMult 10 (2, 5)
      , False ~=? isCommonMult 10 (2, 3)
      , False ~=? isCommonMult 10 (3, 2)
      , False ~=? isCommonMult 10 (3, 4)

        -- swap
      , (1, 2) ~=? swap (2, 1)
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
