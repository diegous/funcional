import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- smaller'
          TestCase (assertEqual "smaller'" 1 (smaller' (1,2,3))),
          TestCase (assertEqual "smaller'" 1 (smaller' (1,3,2))),
          TestCase (assertEqual "smaller'" 1 (smaller' (2,1,3))),
          TestCase (assertEqual "smaller'" 1 (smaller' (2,3,1))),
          TestCase (assertEqual "smaller'" 1 (smaller' (3,1,2))),
          TestCase (assertEqual "smaller'" 1 (smaller' (3,2,1))),

          -- second'
          TestCase (assertEqual "second'" 2 (second' 1 2)),

          -- andThen'
          TestCase (assertEqual "andThen'" True (andThen' True True)),
          TestCase (assertEqual "andThen'" False (andThen' True False)),
          TestCase (assertEqual "andThen'" False (andThen' False True)),
          TestCase (assertEqual "andThen'" False (andThen' False False)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-- a) smaller
smaller' = \(x,y,z) -> if x < y && x < z then x
                                         else
                                           if z < x && z < y then z
                                           else y

-- b) second x = \x -> x
second' = \x y -> y

-- c) andThen
-- acá `val` siempre va a tener q ser un booleano
andThen' = \bool val -> if bool then val else False
