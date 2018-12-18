import Test.HUnit

main = do
  runTestTT
    (
      TestList
        [
          TestCase (assertEqual "" [1,2,3] (recInsert 2 [1,3]) ),
          TestCase (assertEqual "" [1,2,3] (foldInsert 2 [1,3] [1,3]) ),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )


------------------------------------------------------------
------------------------------------------------------------
------------------------------------------------------------

recr :: b -> (a -> [a] -> b -> b) -> [a] -> b
recr z f []     = z
recr z f (x:xs) = f x xs (recr z f xs)

recInsert :: Int -> [Int] -> [Int]
recInsert x xs = recr [x] (insert x) xs

insert :: Int -> Int -> [Int] -> [Int] -> [Int]
insert x y ys zs = if x<y then (x:y:ys) else (y:zs)

recFunction :: Int -> Int -> ([Int] -> [Int]) -> [Int] -> [Int]
recFunction x q h xs = insert x q (tail xs) (h (tail xs))

foldInsert :: Int -> [Int] -> [Int]
foldInsert x xs = foldr (recFunction x) (\_ -> [x]) xs xs

{-
  foldInsert 2 [1,3] [1,3]
  =           def foldInsert
  foldr (recFunction 2) (\_ -> [2]) [1,3] [1,3]
  =           def foldr
  (recFunction 2) 1 (foldr (recFunction 2) (\_ -> [2]) [3]) [1,3]
  =           def foldr
  (recFunction 2) 1 ((recFunction 2) 3 (foldr (recFunction 2) (\_ -> [2]) [])) [1,3]
  =           def foldr
  (recFunction 2) 1 ((recFunction 2) 3 (\_ -> [2])) [1,3]
  =           saco paréntesis
  recFunction 2 1 (recFunction 2 3 (\_ -> [2])) [1,3]
  =           def recFunction
  insert 2 1 (tail [1,3]) ((recFunction 2 3 (\_ -> [2])) (tail [1,3]))
  =           def tail
  insert 2 1 [3] ((recFunction 2 3 (\_ -> [2])) [3])
  =           def insert
  1:recFunction 2 3 (\_ -> [2]) [3]
  =           def recFunction
  1:insert 2 3 (tail [2]) ((\_ -> [2]) (tail [2]))
  =           def tail
  1:insert 2 3 [] ((\_ -> [2]) [])
  =           función anonima
  1:insert 2 3 [] [2]
  =           def insert
  1:(2:3:[])
  =           sintaxis de listas
  [1,2,3]
-}
