import Test.HUnit

seq_nil = Nil
seq_unit = (Unit 1)
seq_l_1 = (Cat Nil (Unit 1))
seq_l_2 = (Cat (Cat Nil (Unit 1))
               (Unit 2))

seq_l_3 = (Cat
            (Cat (Cat Nil (Unit 1))
                 (Unit 2))
            (Cat (Unit 3) (Unit 4))
          )

seq_l_4 = (Cat
            (Cat (Cat Nil Nil)
                 Nil)
            (Cat Nil (Unit 1))
          )

seq_l_5 = (Cat
            (Cat (Cat Nil Nil)
                 Nil)
            (Cat Nil (Unit 1))
          )

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- appSeq
        (Cat Nil (Unit 1))                ~=? appSeq Nil (Unit 1)
      , (Cat (Cat Nil (Unit 1)) (Unit 2)) ~=? appSeq seq_l_1 (Unit 2)

        -- conSeq
      , Cat (Unit 0) Nil                ~=? conSeq 0 Nil
      , Cat (Unit 0) (Cat Nil (Unit 1)) ~=? conSeq 0 seq_l_1

        -- lenSeq
      , 0 ~=? lenSeq seq_nil
      , 1 ~=? lenSeq seq_unit
      , 1 ~=? lenSeq seq_l_1
      , 2 ~=? lenSeq seq_l_2
      , 4 ~=? lenSeq seq_l_3

        -- revSeq
      , (Nil::(Seq Int)) ~=? revSeq seq_nil
      , Unit 1 ~=? revSeq seq_unit
      , Cat (Unit 1) Nil ~=? revSeq seq_l_1
      , Cat (Unit 2) (Cat (Unit 1) Nil) ~=? revSeq seq_l_2
      , Cat (Cat (Unit 4) (Unit 3)) (Cat (Unit 2) (Cat (Unit 1) Nil)) ~=? revSeq seq_l_3

        -- headSeq
      , Unit 1 ~=? headSeq seq_unit
      , Unit 1 ~=? headSeq seq_l_2
      , Unit 1 ~=? headSeq seq_l_3
      , Unit 1 ~=? headSeq seq_l_4

        -- normSeq
      , seq_unit ~=? normSeq seq_unit
      , Unit 1 ~=? normSeq (Cat (Cat Nil (Unit 1)) Nil)
      , Unit 1 ~=? normSeq (Cat (Cat (Unit 1) Nil) Nil)
      , Cat (Unit 1) (Unit 2) ~=? normSeq (Cat (Unit 1) (Unit 2))
      , Cat (Unit 1) (Unit 2) ~=? normSeq (Cat (Cat Nil (Unit 1)) (Unit 2))

        -- tailSeq
      , (Unit 2) ~=? tailSeq (Cat (Unit 1) (Unit 2))
      , Nil ~=? tailSeq seq_l_1
      , Cat Nil (Unit 2) ~=? tailSeq seq_l_2
      , Cat (Cat Nil (Unit 2)) (Cat (Unit 3) (Unit 4)) ~=? tailSeq seq_l_3
      , Cat (Cat (Cat Nil Nil) Nil) Nil ~=? tailSeq seq_l_4

        -- eqSeq
      , True  ~=? eqSeq (Nil::(Seq Int)) Nil
      , True  ~=? eqSeq seq_unit seq_unit
      , True  ~=? eqSeq seq_l_1 seq_l_1
      , True  ~=? eqSeq seq_l_2 seq_l_2
      , True  ~=? eqSeq seq_l_3 seq_l_3
      , True  ~=? eqSeq seq_l_4 seq_l_4
      , False ~=? eqSeq seq_unit seq_nil
      , False ~=? eqSeq (Cat (Unit 1) Nil) (Cat Nil (Unit 1))

        -- seq2List
      , ([]::[Int]) ~=? seq2List seq_nil
      , [1]       ~=? seq2List seq_unit
      , [1,2]     ~=? seq2List seq_l_2
      , [1,2,3,4] ~=? seq2List seq_l_3
      , [1]       ~=? seq2List seq_l_4
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
data Seq a = Nil | Unit a | Cat (Seq a) (Seq a) deriving (Eq, Show)

-- isEmpty, que toma una secuencia y devuelve true si todos sus elementos son Nil
isEmpty :: (Seq a) -> Bool
isEmpty (Nil)       = True
isEmpty (Unit a)    = False
isEmpty (Cat s1 s2) = (isEmpty s1) && (isEmpty s2)


-- appSeq, que toma dos secuencias y devuelve su concatenación.
appSeq :: (Seq a) -> (Seq a) -> (Seq a)
appSeq s1 s2 = Cat s1 s2


-- conSeq, que toma un elemento y una secuencia y devuelve la secuencia que tiene al elemento dado como cabeza y a la secuencia dada como cola.
conSeq :: a -> (Seq a) -> (Seq a)
conSeq a s = Cat (Unit a) s


-- lenSeq, que calcula la cantidad de elementos de una secuencia.
lenSeq :: (Seq a) -> Int
lenSeq Nil         = 0
lenSeq (Unit a)    = 1
lenSeq (Cat s1 s2) = (lenSeq s1) + (lenSeq s2)


-- revSeq, que toma una secuencia e invierte sus elementos.
revSeq :: (Seq a) -> (Seq a)
revSeq Nil         = Nil
revSeq (Unit a)    = Unit a
revSeq (Cat s1 s2) = Cat (revSeq s2) (revSeq s1)


-- headSeq, que toma una secuencia y devuelve su primer elemento (es decir el de más a la izquierda).
headSeq :: (Seq a) -> (Seq a)
headSeq (Unit a)    = Unit a
headSeq (Cat s1 s2) = if isEmpty s1 then headSeq s2
                                    else headSeq s1


-- tailSeq, que remueve la cabeza de una secuencia.
tailSeq :: (Seq a) -> (Seq a)
tailSeq (Cat (Unit x) s)   = s
tailSeq (Cat Nil (Unit x)) = Nil
tailSeq (Cat Nil s)        = Cat Nil (tailSeq s)
tailSeq (Cat s1 s2)        = if isEmpty s1 then Cat s1 (tailSeq s2)
                                           else Cat (tailSeq s1) s2


-- normSeq, que elimina todos los Nils innecesarios de una secuencia. Por ejemplo, normSeq (Cat (Cat Nil (Unit 1)) Nil) = Unit 1
normSeq :: (Seq a) -> (Seq a)
normSeq (Unit a)    = Unit a
normSeq (Cat Nil s) = normSeq s
normSeq (Cat s Nil) = normSeq s
normSeq (Cat s1 s2) = Cat (normSeq s1) (normSeq s2)


-- eqSeq, que toma dos secuencias y devuelve True sii ambas contienen los mismos valores, en el mismo orden y en la misma cantidad.
eqSeq :: Eq a => (Seq a) -> (Seq a) -> Bool
eqSeq Nil         Nil         = True
eqSeq (Unit x)    (Unit y)    = x == y
eqSeq (Cat s1 s2) (Cat s3 s4) = (eqSeq s1 s3) && (eqSeq s2 s4)
eqSeq _           _           = False


-- seq2List, que toma una secuencia y devuelve una lista con los mismos elementos, en el mismo orden.
seq2List :: (Seq a) -> [a]
seq2List Nil         = []
seq2List (Unit x)    = [x]
seq2List (Cat s1 s2) = (seq2List s1) ++ (seq2List s2)
