import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- iff'
          TestCase (assertEqual "iff'" (iff True True)   (iff' True True)),
          TestCase (assertEqual "iff'" (iff True False)  (iff' True False)),
          TestCase (assertEqual "iff'" (iff False True)  (iff' False True)),
          TestCase (assertEqual "iff'" (iff False False) (iff' False False)),

          -- alpha'
          TestCase (assertEqual "alpha'" (alpha 1 2)      (alpha' 1 2)),
          TestCase (assertEqual "alpha'" (alpha False 42) (alpha' False 42)),


          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-- a)
iff = \x -> \y -> if x then not y else y
iff' True  y = not y
iff' False y = y

-- b)
alpha = \x -> \x -> x
alpha' _ = id
