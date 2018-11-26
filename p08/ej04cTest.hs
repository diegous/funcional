import Ej04C
import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- isEmptySL
        True  ~=? isEmptySL (buildSL (&&))
      , True  ~=? isEmptySL (buildSL (&&))
      , False ~=? isEmptySL (insertSL 1 (buildSL (<)))

        -- headSL
      , 1 ~=? headSL (insertSL 1 (buildSL (<)))
      , 1 ~=? headSL (insertSL 2 (insertSL 1 (buildSL (<))))
      , 1 ~=? headSL (insertSL 1 (insertSL 2 (buildSL (<))))
      , 2 ~=? headSL (insertSL 2 (insertSL 1 (buildSL (>))))
      , 2 ~=? headSL (insertSL 1 (insertSL 2 (buildSL (>))))

        -- tailSL
      , True  ~=? (isEmptySL . tailSL . insertSL 1) (buildSL (<))
      , False ~=? (isEmptySL . tailSL . insertSL 2 . insertSL 1) (buildSL (<))
      , True  ~=? isEmptySL (tailSL (tailSL (insertSL 1 (insertSL 2 (buildSL (<))))))
      , 2     ~=? headSL (tailSL (insertSL 2 (insertSL 1 (buildSL (<)))))
      , 2     ~=? headSL (tailSL (insertSL 1 (insertSL 2 (buildSL (<)))))

        -- insertSL
      , 1 ~=? (headSL . insertSL 1) (buildSL (<))
      , 1 ~=? (headSL . insertSL 1 . insertSL 2) (buildSL (<))
      , 1 ~=? (headSL . insertSL 2 . insertSL 1) (buildSL (<))
      , 1 ~=? (headSL . insertSL 1 . insertSL 2 . insertSL 3) (buildSL (<))
      , 1 ~=? (headSL . insertSL 1 . insertSL 3 . insertSL 2) (buildSL (<))
      , 1 ~=? (headSL . insertSL 2 . insertSL 1 . insertSL 3) (buildSL (<))
      , 1 ~=? (headSL . insertSL 2 . insertSL 3 . insertSL 1) (buildSL (<))
      , 1 ~=? (headSL . insertSL 3 . insertSL 1 . insertSL 2) (buildSL (<))
      , 1 ~=? (headSL . insertSL 3 . insertSL 2 . insertSL 1) (buildSL (<))

      , 1 ~=? (headSL . insertSL 1) (buildSL (>))
      , 2 ~=? (headSL . insertSL 1 . insertSL 2) (buildSL (>))
      , 2 ~=? (headSL . insertSL 2 . insertSL 1) (buildSL (>))
      , 3 ~=? (headSL . insertSL 1 . insertSL 2 . insertSL 3) (buildSL (>))
      , 3 ~=? (headSL . insertSL 1 . insertSL 3 . insertSL 2) (buildSL (>))
      , 3 ~=? (headSL . insertSL 2 . insertSL 1 . insertSL 3) (buildSL (>))
      , 3 ~=? (headSL . insertSL 2 . insertSL 3 . insertSL 1) (buildSL (>))
      , 3 ~=? (headSL . insertSL 3 . insertSL 1 . insertSL 2) (buildSL (>))
      , 3 ~=? (headSL . insertSL 3 . insertSL 2 . insertSL 1) (buildSL (>))
      ]
    )
