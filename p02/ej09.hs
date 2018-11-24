-- a) a
-- El único valor q es de tipo a es Bottom
error "hola"

-- b) Int -> a
\x -> if x < 2 then error "1" else error "2"

-- c) a -> b
\_ -> error "hola"

-- d) c -> c
-- solo id ¯\_(ツ)_/¯
