import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- sort3
        (1,2,3) ~=? sort3 1 2 3
      , (1,2,3) ~=? sort3 1 3 2
      , (1,2,3) ~=? sort3 2 1 3
      , (1,2,3) ~=? sort3 2 3 1
      , (1,2,3) ~=? sort3 3 1 2
      , (1,2,3) ~=? sort3 3 2 1

        -- sort3'
      , (1,2,3) ~=? sort3' 1 2 3
      , (1,2,3) ~=? sort3' 1 3 2
      , (1,2,3) ~=? sort3' 2 1 3
      , (1,2,3) ~=? sort3' 2 3 1
      , (1,2,3) ~=? sort3' 3 1 2
      , (1,2,3) ~=? sort3' 3 2 1
      ]
    )

-----------------------------------------------------------------------------------------
-- Functions

sort3 x y z =
  if x < y
    then
      if y < z
        then (x,y,z)
        else if x < z then (x,z,y) else (z,x,y)

    else
      if x < z
        then (y,x,z)
        else if y < z then (y,z,x) else (z,y,x)

-----------------------------------------------------------------------------------------
sort3' x y z = let minn = (x `min` y) `min` z
                   maxn = (x `max` y) `max` z
               in
               (minn,
                x + y + z - minn - maxn,
                maxn
               )
