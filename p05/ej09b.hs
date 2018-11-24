impares :: [Int] -> [Int]
impares []     = []
impares (n:ns) = if n `mod` 2 == 1 then n:(impares ns) else impares ns
