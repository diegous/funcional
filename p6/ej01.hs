import Test.HUnit

filterComp :: (SetComp Int) -> [Int]
filterComp s = filter (`belongsToComp` s) [0,1,2,3,4]

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- belongsToExt
        False ~=? 1 `belongsToExt` (SetExt [])
      , False ~=? 0 `belongsToExt` (SetExt [1,2,3])
      ,  True ~=? 1 `belongsToExt` (SetExt [1,2,3])
      ,  True ~=? 2 `belongsToExt` (SetExt [1,2,3])
      ,  True ~=? 3 `belongsToExt` (SetExt [1,2,3])
      , False ~=? 4 `belongsToExt` (SetExt [1,2,3])

        -- unionExt
      , SetExt []      ~=? unionExt (SetExt [])      (SetExt ([]::[Int]))
      , SetExt [1]     ~=? unionExt (SetExt [])      (SetExt [1])
      , SetExt [1]     ~=? unionExt (SetExt [1])     (SetExt [])
      , SetExt [1,2]   ~=? unionExt (SetExt [1,2])   (SetExt [2])
      , SetExt [1,2,3] ~=? unionExt (SetExt [1,2])   (SetExt [2,3])
      , SetExt [1,2,3] ~=? unionExt (SetExt [1,2,3]) (SetExt [1,2,3])

        -- inetrsectionExt
      , SetExt []      ~=? inetrsectionExt (SetExt [])      (SetExt ([]::[Int]))
      , SetExt []      ~=? inetrsectionExt (SetExt [])      (SetExt [1])
      , SetExt []      ~=? inetrsectionExt (SetExt [1])     (SetExt [])
      , SetExt [2]     ~=? inetrsectionExt (SetExt [1,2])   (SetExt [2])
      , SetExt [2]     ~=? inetrsectionExt (SetExt [1,2])   (SetExt [2,3])
      , SetExt [1,2,3] ~=? inetrsectionExt (SetExt [1,2,3]) (SetExt [1,2,3])


        -- belongsToComp
      , []          ~=? (filterComp . SetComp) (const False)
      , [1]         ~=? (filterComp . SetComp) (==1)
      , [2,3,4]     ~=? (filterComp . SetComp) (>1)
      , [1,2,3,4]   ~=? (filterComp . SetComp) (>=1)
      , [0,1,2,3,4] ~=? (filterComp . SetComp) (<9)

        -- unionComp
      , []          ~=? filterComp (unionComp (SetComp (<0)) (SetComp (<0)))
      , [0,1,2]     ~=? filterComp (unionComp (SetComp (<3)) (SetComp (<3)))
      , [0,1,4]     ~=? filterComp (unionComp (SetComp (<2)) (SetComp (==4)))
      , [0,1,2]     ~=? filterComp (unionComp (SetComp (<3)) (SetComp (==2)))
      , [0,1,2,3,4] ~=? filterComp (unionComp (SetComp (<2)) (SetComp (<5)))
      , [0,1,2,3,4] ~=? filterComp (unionComp (SetComp (<0)) (SetComp (<5)))
      , [0,1,3,4]   ~=? filterComp (unionComp (SetComp (<2)) (SetComp (>2)))
      , [0,1,2,3,4] ~=? filterComp (unionComp (SetComp (<4)) (SetComp (>0)))

        -- inetrsectionComp
      , []      ~=? filterComp (inetrsectionComp (SetComp (<0)) (SetComp (<0)))
      , [0,1,2] ~=? filterComp (inetrsectionComp (SetComp (<3)) (SetComp (<3)))
      , []      ~=? filterComp (inetrsectionComp (SetComp (<2)) (SetComp (==4)))
      , [2]     ~=? filterComp (inetrsectionComp (SetComp (<3)) (SetComp (==2)))
      , [0,1]   ~=? filterComp (inetrsectionComp (SetComp (<2)) (SetComp (<5)))
      , []      ~=? filterComp (inetrsectionComp (SetComp (<0)) (SetComp (<5)))
      , []      ~=? filterComp (inetrsectionComp (SetComp (<2)) (SetComp (>2)))
      , [1,2,3] ~=? filterComp (inetrsectionComp (SetComp (<4)) (SetComp (>0)))
      ]
    )

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- 1. Definir las operaciones de unión e intersección de dos conjuntos y el
-- pred predicado de pertenencia para conjuntos de elementos de tipo a, los
-- cuales se representan:

-- a) por extensión (como lista de elementos de a)
data SetExt a = SetExt [a] deriving (Eq, Show)

belongsToExt :: Eq a => a -> (SetExt a) -> Bool
belongsToExt x (SetExt xs) = x `elem` xs

unionExt :: Eq a => (SetExt a) -> (SetExt a) -> (SetExt a)
unionExt (SetExt xs) (SetExt ys) = SetExt (xs ++ ys')
                                 where ys' = filter (not . (`elem`xs)) ys

inetrsectionExt :: Eq a => (SetExt a) -> (SetExt a) -> (SetExt a)
inetrsectionExt (SetExt xs) (SetExt ys) = SetExt xs'
                                        where xs' = filter (`elem`ys) xs


-- b) por comprensión (como predicado a ->Bool)
data SetComp a = SetComp (a -> Bool)

belongsToComp :: a -> (SetComp a) -> Bool
belongsToComp x (SetComp f) = f x

unionComp :: (SetComp a) -> (SetComp a) -> (SetComp a)
unionComp (SetComp f) (SetComp g) = SetComp h
                                  where h x = f x || g x

inetrsectionComp :: (SetComp a) -> (SetComp a) -> (SetComp a)
inetrsectionComp (SetComp f) (SetComp g) = SetComp h
                                         where h x = f x && g x
