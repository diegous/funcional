import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- iff'
        iff  True  True ~=? iff'  True  True
      , iff  True False ~=? iff'  True False
      , iff False  True ~=? iff' False  True
      , iff False False ~=? iff' False False

        -- alpha'
      , alpha 1 2      ~=? alpha' 1 2
      , alpha False 42 ~=? alpha' False 42
      ]
    )

-- a)
iff = \x -> \y -> if x then not y else y
iff' True  y = not y
iff' False y = y

-- b)
alpha = \x -> \x -> x
alpha' _ = id
