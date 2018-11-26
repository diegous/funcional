import Test.HUnit

tree_1 = Gen 1 []
tree_2 = Gen 2 [tree_1, tree_1]
tree_3 = Gen 3 [tree_1, tree_2, tree_1]
tree_4 = Gen 4 [tree_3, tree_2, tree_3, tree_1]

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- sumGen
         1 ~=? sumGen tree_1
      ,  4 ~=? sumGen tree_2
      ,  9 ~=? sumGen tree_3
      , 27 ~=? sumGen tree_4

        -- sumGen'
      ,  1 ~=? sumGen' tree_1
      ,  4 ~=? sumGen' tree_2
      ,  9 ~=? sumGen' tree_3
      , 27 ~=? sumGen' tree_4
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------


data GenTree a = Gen a [GenTree a]

-- a) Definir la función foldGen :: (a -> [b] -> b) -> GenTree a -> b
foldGen :: (a -> [b] -> b) -> GenTree a -> b
foldGen f (Gen a gs) = f a (map (foldGen f) gs)

sumGen :: (GenTree Int) -> Int
sumGen = foldGen (\x ys -> x + sum ys)

-- b) Definir otra función de fold para árboles generales, con el siguiente tipo:
foldGen' :: (a -> c -> b) -> ([b] -> c) -> GenTree a -> b
foldGen' f g (Gen x gs) = (f x . g) (map (foldGen' f g) gs)

sumGen' :: (GenTree Int) -> Int
sumGen' = foldGen' (\x y -> x + y) sum
