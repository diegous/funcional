-- a) Bool
True
1 == 2


-- b) (Int, Int)
(1,2)
((3+4), (4-3))


-- c) Char -> Int
fc :: Char -> Int
fc char = 4

fc2 :: Char -> Int
fc x = 2


-- d) (Int, Char) -> Bool
fd1 :: (Int, Char) -> Bool
fd1 x = True

fd2 :: (Int, Char) -> Bool
fd2 x = False


-- e) (Int -> Int) -> Int
fe1 :: (Int -> Int) -> Int
fe1 (x,y) = x

fe2 :: (Int -> Int) -> Int
fe2 (x,y) = y


-- f) (Bool -> Bool, Int)
(not, 1)
(not, 2)


-- g) a -> Bool
fg1 x = True
fg2 x = False


-- h) c -> c
fh1 x = x
fh2 x = let y = x in y
