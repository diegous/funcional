import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          TestCase (assertEqual "" (filter odd  [])          (filter' odd  [])),
          TestCase (assertEqual "" (filter odd  [1,2,3,4,5]) (filter' odd  [1,2,3,4,5])),
          TestCase (assertEqual "" (filter (<3) [1,2,3,4,5]) (filter' (<3) [1,2,3,4,5])),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- 4. Definir la función filter en términos de map y concat.

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = concat (map f' xs)
             where f' x = if f x
                          then [x]
                          else []
