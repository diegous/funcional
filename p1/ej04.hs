import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- fib
         1 ~=? fib 0
      ,  1 ~=? fib 1
      ,  2 ~=? fib 2
      ,  3 ~=? fib 3
      ,  5 ~=? fib 4
      ,  8 ~=? fib 5
      , 13 ~=? fib 6
      , 21 ~=? fib 7
      ]
    )

-----------------------------------------------------------------------------------------
-- Functions

fib 0 = 1
fib 1 = 1
fib x = fib (x-1) + fib (x-2)
