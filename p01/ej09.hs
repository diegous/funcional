import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- biciesto
         True ~=? isLeapYear 1996
      ,  True ~=? isLeapYear 2000
      , False ~=? isLeapYear 2003
      , False ~=? isLeapYear 1900
      ]
    )

-----------------------------------------------------------------------------------------
-- Functions

isLeapYear year = let lastDigits = mod year 100
                   in (mod year 400 == 0) || (lastDigits /= 0 && (mod lastDigits 4 == 0))
