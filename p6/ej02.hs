import Test.HUnit

tree_1 = (Tip 1)
tree_2 = (Join (Tip 1) (Tip 2))
tree_3 = (Join (Tip 1)
               (Join (Tip 2)
                     (Join (Tip 3) (Tip 4))
               )
         )

tree_3_mirror =
         (Join (Join (Join (Tip 4) (Tip 3))
                     (Tip 2)
               )
               (Tip 1)
         )

tree_4 = (Join  (Tip 1)
                (Join (Tip 2)
                      (Join
                        (Join (Tip 3) (Tip 4))
                        (Join (Tip 5)
                              (Join (Tip 6) (Tip 7))
                        )
                      )
                )
         )

tree_4_mirror =
         (Join
                (Join
                      (Join
                        (Join
                              (Join (Tip 7) (Tip 6))
                              (Tip 5)
                        )
                        (Join (Tip 4) (Tip 3))
                      )
                      (Tip 2)
                )
                (Tip 1)
         )


tree_3_map =
        (Join (Tip (-2))
               (Join (Tip (-4))
                     (Join (Tip (-6)) (Tip (-8)))
               )
         )



tree_4_map =
         (Join  (Tip (-2))
                (Join (Tip (-4))
                      (Join
                        (Join (Tip (-6)) (Tip (-8)))
                        (Join (Tip (-10))
                              (Join (Tip (-12)) (Tip (-14)))
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
          -- heightTip
          TestCase (assertEqual "heightTip" 0 (heightTip tree_1)),
          TestCase (assertEqual "heightTip" 1 (heightTip tree_2)),
          TestCase (assertEqual "heightTip" 3 (heightTip tree_3)),
          TestCase (assertEqual "heightTip" 5 (heightTip tree_4)),

          -- leaves
          TestCase (assertEqual "leaves" 1 (leaves tree_1)),
          TestCase (assertEqual "leaves" 2 (leaves tree_2)),
          TestCase (assertEqual "leaves" 4 (leaves tree_3)),
          TestCase (assertEqual "leaves" 7 (leaves tree_4)),

          -- nodes
          TestCase (assertEqual "nodes" 0 (nodes tree_1)),
          TestCase (assertEqual "nodes" 1 (nodes tree_2)),
          TestCase (assertEqual "nodes" 3 (nodes tree_3)),
          TestCase (assertEqual "nodes" 6 (nodes tree_4)),

          -- walkover
          TestCase (assertEqual "walkover" [Tip 1] (walkover tree_1)),
          TestCase (assertEqual "walkover" [Tip 1,Tip 2] (walkover tree_2)),
          TestCase (assertEqual "walkover" [Tip 1,Tip 2,Tip 3,Tip 4] (walkover tree_3)),
          TestCase (assertEqual "walkover" [Tip 1,Tip 2,Tip 3,Tip 4,Tip 5,Tip 6,Tip 7] (walkover tree_4)),

          -- mirrorTip
          TestCase (assertEqual "mirrorTip" (Tip 1) (mirrorTip tree_1)),
          TestCase (assertEqual "mirrorTip" (Join (Tip 2) (Tip 1)) (mirrorTip tree_2)),
          TestCase (assertEqual "mirrorTip" tree_3_mirror (mirrorTip tree_3)),
          TestCase (assertEqual "mirrorTip" tree_4_mirror (mirrorTip tree_4)),

          -- mapTip
          TestCase (assertEqual "mapTip" (Tip (-2)) (mapTip (*(-2)) tree_1)),
          TestCase (assertEqual "mapTip" (Join (Tip (-2)) (Tip (-4))) (mapTip (*(-2)) tree_2)),
          TestCase (assertEqual "mapTip" tree_3_map (mapTip (*(-2)) tree_3)),
          TestCase (assertEqual "mapTip" tree_4_map (mapTip (*(-2)) tree_4)),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
data TipTree a = Tip a | Join (TipTree a) (TipTree a) deriving (Eq, Show)


-- heightTip, que devuelve la longitud del camino más largo desde la raíz hasta una hoja.
heightTip :: (TipTree a) -> Int
heightTip (Tip a)      = 0
heightTip (Join t1 t2) = 1 + (heightTip t1) `max` (heightTip t2)


-- leaves, que calcula el número de hojas.
leaves :: (TipTree a) -> Int
leaves (Tip a)      = 1
leaves (Join t1 t2) = (leaves t1) + (leaves t2)


-- nodes, que calcula en número de nodos que no son hojas.
nodes :: (TipTree a) -> Int
nodes (Tip a)      = 0
nodes (Join t1 t2) = 1 + (nodes t1) + (nodes t2)


-- walkover, que devuelve la lista de las hojas de un árbol, leídas de izquierda a derecha.
walkover :: (TipTree a) -> [(TipTree a)]
walkover (Tip a)      = [Tip a]
walkover (Join t1 t2) = (walkover t1) ++ (walkover t2)


-- mirrorTip, que calcula la imagen especular del árbol, o sea, el árbol obtenido intercambiando los subárboles izquierdo y derecho de cada nodo.
mirrorTip :: (TipTree a) -> (TipTree a)
mirrorTip (Tip a)      = (Tip a)
mirrorTip (Join t1 t2) = Join (mirrorTip t2) (mirrorTip t1)


-- mapTip, que toma una función y un árbol, y devuelve el árbol que se obtiene del dado al aplicar la función a cada nodo.
mapTip :: (a -> b) -> (TipTree a) -> (TipTree b)
mapTip f (Tip a)      = Tip (f a)
mapTip f (Join t1 t2) = Join (mapTip f t1) (mapTip f t2)
