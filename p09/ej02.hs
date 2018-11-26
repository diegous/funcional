import Test.HUnit

tree_1 = Empty
tree_2 = Bin 1 Empty Empty
tree_3 = (Bin 1 Empty
                (Bin 2 Empty
                      (Bin 3 Empty Empty)
                )
         )

tree_3_mirror =
  (Bin 1
    (Bin 2
      (Bin 3 Empty Empty)
      Empty
    )
    Empty
  )

tree_4 = (Bin 1
            Empty
            (Bin 2
              Empty
              (Bin 3
                (Bin 4 Empty Empty)
                (Bin 5
                  Empty
                  (Bin 6 Empty Empty)
                )
              )
            )
          )

tree_4_mirror =
          (Bin 1
            (Bin 2
              (Bin 3
                (Bin 5
                  (Bin 6 Empty Empty)
                  Empty
                )
                (Bin 4 Empty Empty)
              )
              Empty
            )
            Empty
          )


tree_3_map =
        (Bin (-2)
          Empty
          (Bin (-4)
            Empty
            (Bin (-6) Empty Empty)
          )
        )



tree_4_map = (Bin (-2)
                Empty
                (Bin (-4)
                  Empty
                  (Bin (-6)
                    (Bin (-8) Empty Empty)
                    (Bin (-10)
                      Empty
                      (Bin (-12) Empty Empty)
                    )
                  )
                )
              )


-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- heightBin
        0 ~=? heightBin tree_1
      , 1 ~=? heightBin tree_2
      , 3 ~=? heightBin tree_3
      , 5 ~=? heightBin tree_4

        -- heightBin'
      , 0 ~=? heightBin' tree_1
      , 1 ~=? heightBin' tree_2
      , 3 ~=? heightBin' tree_3
      , 5 ~=? heightBin' tree_4


        -- nodesBin
      , 0 ~=? nodesBin tree_1
      , 1 ~=? nodesBin tree_2
      , 3 ~=? nodesBin tree_3
      , 6 ~=? nodesBin tree_4

        -- nodesBin'
      , 0 ~=? nodesBin' tree_1
      , 1 ~=? nodesBin' tree_2
      , 3 ~=? nodesBin' tree_3
      , 6 ~=? nodesBin' tree_4


        -- mapBin
      , Empty                ~=? mapBin (*(-2)) tree_1
      , Bin (-2) Empty Empty ~=? mapBin (*(-2)) tree_2
      , tree_3_map           ~=? mapBin (*(-2)) tree_3
      , tree_4_map           ~=? mapBin (*(-2)) tree_4

        -- mapBin'
      , Empty                ~=? mapBin' (*(-2)) tree_1
      , Bin (-2) Empty Empty ~=? mapBin' (*(-2)) tree_2
      , tree_3_map           ~=? mapBin' (*(-2)) tree_3
      , tree_4_map           ~=? mapBin' (*(-2)) tree_4


      -- mirrorBin
      , (Empty::BinTree Int) ~=? mirrorBin tree_1
      , Bin 1 Empty Empty    ~=? mirrorBin tree_2
      , tree_3_mirror        ~=? mirrorBin tree_3
      , tree_4_mirror        ~=? mirrorBin tree_4

      -- mirrorBin'
      , (Empty::BinTree Int) ~=? mirrorBin' tree_1
      , Bin 1 Empty Empty    ~=? mirrorBin' tree_2
      , tree_3_mirror        ~=? mirrorBin' tree_3
      , tree_4_mirror        ~=? mirrorBin' tree_4
      ]
    )

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

data BinTree a = Empty | Bin a (BinTree a) (BinTree a) deriving (Eq, Show)

-- a) Definir las funciones nodesBin y heightBin, que calculan la cantidad de
-- nodos y la altura del árbol binario respectivamente
heightBin :: (BinTree a) -> Int
heightBin Empty         = 0
heightBin (Bin x t1 t2) = 1 + (heightBin t1) `max` (heightBin t2)

nodesBin :: (BinTree a) -> Int
nodesBin Empty         = 0
nodesBin (Bin _ t1 t2) = 1 + (nodesBin t1) + (nodesBin t2)


-- b) definir las funciones mapBin y mirrorBin.
mapBin :: (a -> b) -> (BinTree a) -> (BinTree b)
mapBin f Empty         = Empty
mapBin f (Bin x t1 t2) = Bin (f x) (mapBin f t1) (mapBin f t2)

mirrorBin :: (BinTree a) -> (BinTree a)
mirrorBin Empty         = Empty
mirrorBin (Bin x t1 t2) = Bin x (mirrorBin t2) (mirrorBin t1)


-- c) definir la función foldBin :: (a -> b -> b -> b) -> b -> BinTree a -> b
foldBin :: b -> (a -> b -> b -> b) -> (BinTree a) -> b
foldBin z f Empty         = z
foldBin z f (Bin x t1 t2) = f x (foldBin z f t1) (foldBin z f t2)


-- d) usando foldBin, definir las funciones mapBin, heightBin y mirrorBin.
heightBin' :: (BinTree a) -> Int
heightBin' = foldBin 0 f
           where f _ b1 b2 = 1 + b1 `max` b2

nodesBin' :: (BinTree a) -> Int
nodesBin' = foldBin 0 f
          where f _ n1 n2 = 1 + n1 + n2

mapBin' :: (a -> b) -> (BinTree a) -> (BinTree b)
mapBin' f = foldBin Empty (Bin . f)

mirrorBin' :: (BinTree a) -> (BinTree a)
mirrorBin' = foldBin Empty (flip . Bin)
