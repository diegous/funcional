import Test.HUnit

data TipTree a = Tip a | Join (TipTree a) (TipTree a) deriving (Eq, Show)

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
    (Join (Tip (-2))
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
        0 ~=? heightTip tree_1
      , 1 ~=? heightTip tree_2
      , 3 ~=? heightTip tree_3
      , 5 ~=? heightTip tree_4

        -- leaves
      , 1 ~=? leaves tree_1
      , 2 ~=? leaves tree_2
      , 4 ~=? leaves tree_3
      , 7 ~=? leaves tree_4

        -- nodes
      , 0 ~=? nodes tree_1
      , 1 ~=? nodes tree_2
      , 3 ~=? nodes tree_3
      , 6 ~=? nodes tree_4

        -- walkover
      , [Tip 1] ~=? walkover tree_1
      , [Tip 1,Tip 2] ~=? walkover tree_2
      , [Tip 1,Tip 2,Tip 3,Tip 4] ~=? walkover tree_3
      , [Tip 1,Tip 2,Tip 3,Tip 4,Tip 5,Tip 6,Tip 7] ~=? walkover tree_4

      --   -- mirrorTip
      , Tip 1                ~=? mirrorTip tree_1
      , Join (Tip 2) (Tip 1) ~=? mirrorTip tree_2
      , tree_3_mirror ~=? mirrorTip tree_3
      , tree_4_mirror ~=? mirrorTip tree_4

        -- mapTip
      , Tip (-2)                   ~=? mapTip (*(-2)) tree_1
      , Join (Tip (-2)) (Tip (-4)) ~=? mapTip (*(-2)) tree_2
      , tree_3_map                 ~=? mapTip (*(-2)) tree_3
      , tree_4_map                 ~=? mapTip (*(-2)) tree_4
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

foldTip :: (a -> b) -> (b -> b -> b) -> TipTree a -> b
foldTip f g (Tip a)      = f a
foldTip f g (Join t1 t2) = g (foldTip f g t1) (foldTip f g t2)


-- heightTip, que devuelve la longitud del camino más largo desde la raíz hasta una hoja.
heightTip :: (TipTree a) -> Int
heightTip = foldTip (const 0) (\h1 h2 -> 1 + (h1 `max` h2))


-- leaves, que calcula el número de hojas.
leaves :: (TipTree a) -> Int
leaves = foldTip (const 1) (\h1 h2 -> h1 + h2)


-- nodes, que calcula en número de nodos que no son hojas.
nodes :: (TipTree a) -> Int
nodes = foldTip (const 0) (\h1 h2 -> 1 + h1 + h2)


-- walkover, que devuelve la lista de las hojas de un árbol, leídas de izquierda a derecha.
walkover :: (TipTree a) -> [TipTree a]
walkover = foldTip ((:[]) . Tip) (++)


-- mirrorTip, que calcula la imagen especular del árbol, o sea, el árbol obtenido intercambiando los subárboles izquierdo y derecho de cada nodo.
mirrorTip :: (TipTree a) -> (TipTree a)
mirrorTip = foldTip Tip (flip Join)


-- mapTip, que toma una función y un árbol, y devuelve el árbol que se obtiene del dado al aplicar la función a cada nodo.
mapTip :: (a -> b) -> (TipTree a) -> (TipTree b)
mapTip f = foldTip (Tip . f) Join
