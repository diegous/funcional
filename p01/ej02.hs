import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- fa
        fa 1 ~=? fa' 1

        -- greaterThan
      , greaterThan (1,2) ~=? greaterThan'(1,2)
      , greaterThan (2,2) ~=? greaterThan'(2,2)
      , greaterThan (2,3) ~=? greaterThan'(2,3)

        -- fc
      , fc (2,3) ~=? fc'(2,3)
      ]
    )

-----------------------------------------------------------------------------------------
-- Functions

-- a)
fa  x = let (y,z) = (x,x) in y
fa' x = x

-- b)
greaterThan (x,y) = if x > y then True else False
greaterThan' (x,y) = x > y

-- c)
fc  (x,y) = let z = x + y in g (z,y) where g (a,b) = a - b
fc' (x,y) = x
