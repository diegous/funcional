import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- biciesto
          TestCase (assertEqual ""  True (isLeapYear 1996)),
          TestCase (assertEqual ""  True (isLeapYear 2000)),
          TestCase (assertEqual ""  False (isLeapYear 2003)),
          TestCase (assertEqual ""  False (isLeapYear 1900)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-- Functions

isLeapYear year = let lastDigits = mod year 100
                   in (mod year 400 == 0) || (lastDigits /= 0 && (mod lastDigits 4 == 0))
