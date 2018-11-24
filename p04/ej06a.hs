-- implementar mcd que calcule el máximo comun divisor
-- entre dos enteros con el algoritmo de Euclides

-- Este es el primer algoritmo q hice a partir del enunciado
-- mcd a b = let q = a `div` b
--               r = a `mod` b
--           in if r == 0
--              then b
--              else mcd b r

-- Este es el anterior pasado en limpio
mcd :: Int -> Int -> Int
mcd a 0 = a
mcd a b = mcd b (a `mod` b)
