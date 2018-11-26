import Test.HUnit

tree_1 = Gen 1 []
tree_2 = Gen 2 [tree_1, tree_1]
tree_3 = Gen 3 [tree_1, tree_2, tree_2]
tree_4 = Gen 4 [tree_3, tree_2, tree_3, tree_1]

succ_tree_1 = Gen 2 []
succ_tree_2 = Gen 3 [succ_tree_1, succ_tree_1]
succ_tree_3 = Gen 4 [succ_tree_1, succ_tree_2, succ_tree_2]
succ_tree_4 = Gen 5 [succ_tree_3, succ_tree_2, succ_tree_3, succ_tree_1]

mirr_tree_3 = Gen 3 [tree_2, tree_2, tree_1]
mirr_tree_4 = Gen 4 [tree_1, mirr_tree_3, tree_2, mirr_tree_3]

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- mapGen
        succ_tree_1 ~=? mapGen succ tree_1
      , succ_tree_2 ~=? mapGen succ tree_2
      , succ_tree_3 ~=? mapGen succ tree_3
      , succ_tree_4 ~=? mapGen succ tree_4

        -- heightGen
      , 0 ~=? heightGen tree_1
      , 1 ~=? heightGen tree_2
      , 2 ~=? heightGen tree_3
      , 3 ~=? heightGen tree_4

        -- mirrorGen
      , tree_1      ~=? mirrorGen tree_1
      , tree_2      ~=? mirrorGen tree_2
      , mirr_tree_3 ~=? mirrorGen tree_3
      , mirr_tree_4 ~=? mirrorGen tree_4
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------


data GenTree a = Gen a [GenTree a] deriving (Eq, Show)

foldGen :: (a -> [b] -> b) -> GenTree a -> b
foldGen f (Gen a gs) = f a (map (foldGen f) gs)


-- Usando foldGen, defina y dé el tipo de las funciones mapGen, heightGen y mirrorGen.
mapGen :: (a -> b) -> (GenTree a) -> (GenTree b)
mapGen f = foldGen (Gen . f)

heightGen :: (GenTree a) -> Int
heightGen = foldGen (\_ hs -> if hs == [] then 0 else 1 + maximum hs)

mirrorGen :: (GenTree a) -> (GenTree a)
mirrorGen = foldGen (\x gs -> Gen x (reverse gs))
