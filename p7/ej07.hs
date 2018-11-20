import Test.HUnit

main = do
  runTestTT
    (
      TestList
        [
          -- insert'
          TestCase (assertEqual "insert'" (insert 3 [])        (insert' 3 []) ),
          TestCase (assertEqual "insert'" (insert 3 [4])       (insert' 3 [4]) ),
          TestCase (assertEqual "insert'" (insert 3 [2])       (insert' 3 [2]) ),
          TestCase (assertEqual "insert'" (insert 3 [1,2,4,5]) (insert' 3 [1,2,4,5]) ),
          TestCase (assertEqual "insert'" (insert 6 [1,2,4,5]) (insert' 6 [1,2,4,5]) ),

          -- evenPos'
          TestCase (assertEqual "evenPos'" (evenPos ([]::[Int]))   (evenPos' []) ),
          TestCase (assertEqual "evenPos'" (evenPos [1])           (evenPos' [1]) ),
          TestCase (assertEqual "evenPos'" (evenPos [1,2])         (evenPos' [1,2]) ),
          TestCase (assertEqual "evenPos'" (evenPos [1,2,3])       (evenPos' [1,2,3]) ),
          TestCase (assertEqual "evenPos'" (evenPos [1,2,3,4,5,6]) (evenPos' [1,2,3,4,5,6]) ),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- ¿Se puede implementar `insert` y `evenPos` usando `foldr`?
insert :: Ord a => a -> [a] -> [a]
insert y []     = []
insert y (x:xs) = if x<y then x:insert y xs else y:x:xs

insert' :: Ord a => a -> [a] -> [a]
insert' x xs = foldr f fin xs xs
             where
               fin = (\_ -> []) -- esto se ejecuta al final si todas las recursiones no finalizaron
               f y h xs = insertion y (tail xs) (h (tail xs))
                 where
                   insertion y xs ys = if x < y then (x:y:xs) else (y:ys)


---------------------------------
---------------------------------
---------------------------------
evenPos :: [a] -> [a]
evenPos []       = []
evenPos [x]      = [x]
evenPos (x:y:xs) = x:evenPos xs

evenPos' :: [a] -> [a]
evenPos' xs = (foldr f fin xs xs) True
            where
              fin xs keep = []
              f x h xs = evens x (tail xs) (h (tail xs))
                where
                  evens x xs ys keep = if keep
                                       then x:ys False
                                       else ys True

