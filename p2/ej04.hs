-- a)
first :: (a,b) -> a
first (x,y) = x

-- b)
second :: (a,b) -> b
second (x,y) = y

-- c)
const :: a -> b -> a
const x y = x

-- d)
-- g :: a -> b
-- f :: b -> c
compose :: (b -> c) -> (a -> b) -> (a -> c)
compose f g = (\x -> f (g x))

-- e)
apply :: (a -> b) -> a -> b
apply f x = f x

-- f)
-- g :: a -> b
-- f :: c -> b -> d
subst :: (a -> b -> c) -> (a -> b) -> a -> c
subst f g x = f x (g x)

-- g)
-- f1 :: a -> b
-- f2 :: b -> a
pairFunc :: (a -> b, b -> a) -> b -> a -> (b, a)
pairFunc (f1,f2) x y = (f1 (f2 x), f2 (f1 y))

main = do
  putStrLn "All types are correct"
