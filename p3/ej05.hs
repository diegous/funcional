import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- twice'
          TestCase (assertEqual "twice'" (twice succ 1) (twice' succ 1)),
          TestCase (assertEqual "twice'" (twice not True) (twice' not True)),

          -- flipp'
          TestCase (assertEqual "flipp'" (flipp (/) 10 2) (flipp' (/) 10 2)),
          TestCase (assertEqual "flipp'" (flipp (||) True False) (flipp' (||) True False)),
          TestCase (assertEqual "flipp'" (flipp (||) False False) (flipp' (||) False False)),

          -- incc'
          -- TestCase (assertEqual "incc'" (incc 10) (incc' 10)),
          -- TestCase (assertEqual "incc'" (incc 0)   (incc' 0)),
          -- TestCase (assertEqual "incc'" (incc -10) (incc' -10)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Functions
-- a) twice f x = f (f x)
twice f x = f (f x)
twice' = \f x -> f (f x)

-- b) flipp f x y = f y x
flipp f x y = f y x
flipp' = \f x y -> f y x

-- c) incc = +1
incc = (+1)
-- incc' = (\_ -> (+1))
-- no se cómo hacer eso
