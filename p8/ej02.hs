import Ej04C
import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- sl2list
        []      ~=? sl2list (buildSL (&&))
      , [1]     ~=? (sl2list . insertSL 1) (buildSL (<))
      , [1,2]   ~=? (sl2list . insertSL 2 . insertSL 1) (buildSL (<))
      , [1,2,3] ~=? (sl2list . insertSL 3 . insertSL 2 . insertSL 1) (buildSL (<))
      , [1]     ~=? (sl2list . insertSL 1) (buildSL (>))
      , [2,1]   ~=? (sl2list . insertSL 2 . insertSL 1) (buildSL (>))
      , [3,2,1] ~=? (sl2list . insertSL 3 . insertSL 2 . insertSL 1) (buildSL (>))

        -- list2SL
      , []      ~=? sl2list (list2SL (&&) [])
      , [1]     ~=? sl2list (list2SL (<) [1])
      , [1,2,3] ~=? sl2list (list2SL (<) [3,1,2])
      , [3,2,1] ~=? sl2list (list2SL (>) [3,1,2])

        -- resort
      , []          ~=? (sl2list . resort (<)) (list2SL (&&) [])
      , [1]         ~=? (sl2list . resort (<)) (list2SL (<) [1])
      , [1]         ~=? (sl2list . resort (>)) (list2SL (<) [1])
      , [1,2,3]     ~=? (sl2list . resort (<)) (list2SL (<) [3,1,2])
      , [3,2,1]     ~=? (sl2list . resort (>)) (list2SL (<) [3,1,2])
      , [1,2,3,4,5] ~=? (sl2list . resort (<)) (list2SL (>) [3,5,1,2,4])
      , [5,4,3,2,1] ~=? (sl2list . resort (>)) (list2SL (>) [3,5,1,2,4])

      ,  0 ~=? sizeSL (list2SL (&&) [])
      ,  1 ~=? sizeSL (list2SL (<) [1])
      ,  8 ~=? sizeSL (list2SL (<) [7,4,4,4,5,1,6,8])
      , 12 ~=? sizeSL (list2SL (>) [1,7,4,5,5,4,3,4,5,1,6,8])

        -- sortIntSL
      , []                  ~=? sortIntSL []
      , [1]                 ~=? sortIntSL [1]
      , [1,2]               ~=? sortIntSL [2,1]
      , [1,2,3]             ~=? sortIntSL [2,3,1]
      , [1,2,3,4,5,6,7,8,9] ~=? sortIntSL [6,2,8,5,3,1,9,7,4]

        -- sortBySL (<)
      , []                  ~=? sortBySL (&&) []
      , [1]                 ~=? sortBySL (<) [1]
      , [1,2]               ~=? sortBySL (<) [2,1]
      , [1,2,3]             ~=? sortBySL (<) [2,3,1]
      , [1,2,3,4,5,6,7,8,9] ~=? sortBySL (<) [6,2,8,5,3,1,9,7,4]
      , [1]                 ~=? sortBySL (>) [1]
      , [2,1]               ~=? sortBySL (>) [2,1]
      , [3,2,1]             ~=? sortBySL (>) [2,3,1]
      , [9,8,7,6,5,4,3,2,1] ~=? sortBySL (>) [6,2,8,5,3,1,9,7,4]
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- resort, reordena la lista ordenada a partir de otro orden.
resort :: (a -> a -> Bool) -> SL a -> SL a
resort f l = if isEmptySL l
             then buildSL f
             else insertSL (headSL l) (resort f (tailSL l))


-- sizeSL devuelve el tamaño de la lista ordenada.
sizeSL :: SL a -> Int
sizeSL l = if isEmptySL l
           then 0
           else 1 + sizeSL (tailSL l)


-- list2SL toma un orden y una lista y devuelve una lista ordenada.
list2SL :: (a -> a -> Bool) -> [a] -> SL a
list2SL f []     = buildSL f
list2SL f (x:xs) = insertSL x (list2SL f xs)


-- sl2list toma una lista ordenada y devuelve una lista del tipo definido
-- en Haskell, que está ordenada.
sl2list :: SL a -> [a]
sl2list l = if isEmptySL l
            then []
            else headSL l : sl2list (tailSL l)


-- que dada una lista de enteros, devuelve una en la que los elementos están
-- en orden creciente.
sortIntSL :: [Int] -> [Int]
sortIntSL = sl2list . list2SL (<)


-- que ordena una lista dada a partir de un orden que recibe como argumento.
sortBySL :: (a -> a -> Bool) -> [a] -> [a]
sortBySL f = sl2list . list2SL f

