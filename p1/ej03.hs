import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- power4'
          TestCase (assertEqual "power4'" (power4 2)    (power4' 2)),
          TestCase (assertEqual "power4'" (power4 0)    (power4' 0)),
          TestCase (assertEqual "power4'" (power4 (-2)) (power4' (-2))),

          -- power4''
          TestCase (assertEqual "power4''" (power4 2)    (power4'' 2)),
          TestCase (assertEqual "power4''" (power4 0)    (power4'' 0)),
          TestCase (assertEqual "power4''" (power4 (-2)) (power4'' (-2))),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-- Functions

power4 x = let sqr y = y * y
            in sqr (sqr x)

power4' x = x ** 4

power4'' x = x * x * x * x
