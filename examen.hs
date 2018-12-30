import Test.HUnit

tree_nil = Nil
tree_bin = Bin True Nil Nil

tree_1 = Bin False tree_bin Nil
tree_2 = Bin False tree_bin tree_bin
tree_3 = Bin False tree_bin (Bin False tree_1 tree_1)
tree_4 = Bin False tree_bin tree_3
tree_d = Bin False Nil (Bin True Nil (Bin False Nil (Bin True Nil Nil)))

-- Tests
main = do
  runTestTT
    (
      TestList
      [
       -- longestOs
        0 ~=? longestOs tree_nil
      , 0 ~=? longestOs tree_bin
      , 1 ~=? longestOs tree_1
      , 1 ~=? longestOs tree_2
      , 2 ~=? longestOs tree_3
      , 2 ~=? longestOs tree_4
      , 0 ~=? longestOs tree_d

       -- allBits
      ,  allBits tree_nil ~?= []
      ,  allBits tree_bin ~?= [""]
      ,  allBits tree_1   ~?= ["O"]
      ,  allBits tree_2   ~?= ["O", "I"]
      ,  allBits tree_3   ~?= ["O", "IOO", "IIO"]
      ,  allBits tree_4   ~?= ["O", "IO", "IIOO", "IIIO"]
      ,  allBits tree_d   ~?= ["I", "III"]
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- type Bit = O | I
data BitT = Nil | Bin Bool BitT BitT deriving (Eq, Show)


foldBitT :: a -> (Bool -> a -> a -> a) -> BitT -> a
foldBitT z f Nil           = z
foldBitT z f (Bin b t1 t2) = f b (foldBitT z f t1) (foldBitT z f t2)


-- `fI` sería la función del subárbol izquierdo, idem `fD`
longestOs :: BitT -> Int
longestOs tree = ((foldBitT id f tree 0) - 1) `max` 0
               where f _ fI fD n = let maxI = fI (n + 1)
                                       maxD = fD 0
                                    in maxI `max` maxD


allBits :: BitT -> [[Char]]
allBits tree = foldBitT (const []) f tree []
             where f b fI fD path = let pathsI = fI (path ++ ['O'])
                                        pathsD = fD (path ++ ['I'])
                                     in if b
                                        then [path] ++ pathsI ++ pathsD
                                        else pathsI ++ pathsD
