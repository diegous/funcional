import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- smaller'
        1 ~=? smaller' (1,2,3)
      , 1 ~=? smaller' (1,3,2)
      , 1 ~=? smaller' (2,1,3)
      , 1 ~=? smaller' (2,3,1)
      , 1 ~=? smaller' (3,1,2)
      , 1 ~=? smaller' (3,2,1)

        -- second'
      , 2 ~=? second' 1 2

        -- andThen'
      ,  True ~=? andThen' True True
      , False ~=? andThen' True False
      , False ~=? andThen' False True
      , False ~=? andThen' False False
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
