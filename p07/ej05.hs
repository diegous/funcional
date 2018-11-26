import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- takewhile
          TestCase (assertEqual "takewhile" []      (takewhile odd []) ),
          TestCase (assertEqual "takewhile" []      (takewhile odd [2]) ),
          TestCase (assertEqual "takewhile" [1,3,5] (takewhile odd [1,3,5]) ),
          TestCase (assertEqual "takewhile" [1,3,5] (takewhile odd [1,3,5,2,7,9]) ),

          -- dropwhile
          TestCase (assertEqual "dropwhile" []      (dropwhile odd []) ),
          TestCase (assertEqual "dropwhile" []      (dropwhile odd [1,3,5]) ),
          TestCase (assertEqual "dropwhile" [2,7,9] (dropwhile odd [1,3,5,2,7,9]) ),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Definir las funciones takewhile, que devuelve el segmento inicial más largo de una lista
-- de elementos que verifican una condición dada, y dropwhile, que devuelve el segmento
-- de la lista que comienza con el primer elemento que no verifica la condición dada.
takewhile :: (a -> Bool) -> [a] -> [a]
takewhile _ []     = []
takewhile f (x:xs) = if f x
                     then x:(takewhile f xs)
                     else []

dropwhile :: (a -> Bool) -> [a] -> [a]
dropwhile f xs = let n = length (takewhile f xs)
                  in drop n xs
