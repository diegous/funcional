import Test.HUnit

-- ¿Se pueden representar listas ordenadas mediante tipos algebraicos? Proponga una definición o justifique.
data Lista a = Fin | Nodo a (Lista a) deriving (Eq, Show)

listToLista :: [a] -> (Lista a)
listToLista []     = Fin
listToLista (x:xs) = Nodo x (listToLista xs)

listaToList :: (Lista a) -> [a]
listaToList Fin        = []
listaToList (Nodo a l) = a:(listaToList l)



-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- -- listToLista
          TestCase (assertEqual "listToLista" (Fin::(Lista Int)) (listToLista ([]::[Int]))),
          TestCase (assertEqual "listToLista" (Nodo 1 (Nodo 2 (Nodo 3 Fin))) (listToLista [1,2,3])),

          -- listaToList
          TestCase (assertEqual "listaToList" ([]::[Int]) (listaToList (Fin::(Lista Int)))),
          TestCase (assertEqual "listaToList" [1,2,3] (listaToList (Nodo 1 (Nodo 2 (Nodo 3 Fin))))),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )
