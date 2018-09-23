-- Dada:

hailstone n = if (n<=1)
              then 0
              else if (n `mod` 2 == 0) then (n `div` 2)
                                       else (3*n+1)

-- definir una función hail, que toma un entero n y devuelve el mı́nimo i tal que
-- (hailstone.hailstone.hailstone...(i veces)) n = 0

hail :: Int -> Int
hail n = lastHailstone n 1

lastHailstone :: Int -> Int -> Int
lastHailstone n acc = let result = (hailstone n) in
                      if (result == 0)
                        then acc
                        else lastHailstone result (acc+1)


-- genList :: Int -> [Int]
-- genList 1 = [1]
-- genList n = (genList (n-1)) ++ [n]

-- probé esto
-- map (\x -> (x, hail x)) (genList 20000)
-- y terminaron todos, no se bien qué números no terminarían
