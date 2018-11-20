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
        (Fin::(Lista Int)) ~=? listToLista ([]::[Int])
      , Nodo 1 (Nodo 2 (Nodo 3 Fin)) ~=? listToLista [1,2,3]

      --   -- listaToList
      , ([]::[Int]) ~=? listaToList (Fin::(Lista Int))
      , [1,2,3] ~=? listaToList (Nodo 1 (Nodo 2 (Nodo 3 Fin)))
      ]
    )
