import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- fib
          TestCase (assertEqual ""  1 (fib 0)),
          TestCase (assertEqual ""  1 (fib 1)),
          TestCase (assertEqual ""  2 (fib 2)),
          TestCase (assertEqual ""  3 (fib 3)),
          TestCase (assertEqual ""  5 (fib 4)),
          TestCase (assertEqual ""  8 (fib 5)),
          TestCase (assertEqual "" 13 (fib 6)),
          TestCase (assertEqual "" 21 (fib 7)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-- Functions

fib 0 = 1
fib 1 = 1
fib x = fib (x-1) + fib (x-2)
