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

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- appSeq
          TestCase (assertEqual "appSeq" (Cat Nil (Unit 1))                (appSeq Nil (Unit 1))),
          TestCase (assertEqual "appSeq" (Cat (Cat Nil (Unit 1)) (Unit 2)) (appSeq seq_l_1 (Unit 2))),

          -- conSeq
          TestCase (assertEqual "conSeq" (Cat (Unit 0) Nil)                (conSeq 0 Nil)),
          TestCase (assertEqual "conSeq" (Cat (Unit 0) (Cat Nil (Unit 1))) (conSeq 0 seq_l_1)),

          -- lenSeq
          TestCase (assertEqual "lenSeq" 0 (lenSeq seq_nil)),
          TestCase (assertEqual "lenSeq" 1 (lenSeq seq_unit)),
          TestCase (assertEqual "lenSeq" 1 (lenSeq seq_l_1)),
          TestCase (assertEqual "lenSeq" 2 (lenSeq seq_l_2)),
          TestCase (assertEqual "lenSeq" 4 (lenSeq seq_l_3)),

          -- revSeq
          TestCase (assertEqual "revSeq" (Nil::(Seq Int)) (revSeq seq_nil)),
          TestCase (assertEqual "revSeq" (Unit 1) (revSeq seq_unit)),
          TestCase (assertEqual "revSeq" (Cat (Unit 1) Nil) (revSeq seq_l_1)),
          TestCase (assertEqual "revSeq" (Cat (Unit 2) (Cat (Unit 1) Nil)) (revSeq seq_l_2)),
          TestCase (assertEqual "revSeq" (Cat (Cat (Unit 4) (Unit 3)) (Cat (Unit 2) (Cat (Unit 1) Nil))) (revSeq seq_l_3)),

          -- headSeq
          TestCase (assertEqual "headSeq" (Nil::(Seq Int)) (headSeq seq_nil)),
          TestCase (assertEqual "headSeq" (Unit 1) (headSeq seq_unit)),
          TestCase (assertEqual "headSeq" (Nil) (headSeq seq_l_1)),
          TestCase (assertEqual "headSeq" (Cat Nil (Unit 1)) (headSeq seq_l_2)),
          TestCase (assertEqual "headSeq" (Cat (Cat Nil (Unit 1)) (Unit 2)) (headSeq seq_l_3)),



          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
data Seq a = Nil | Unit a | Cat (Seq a) (Seq a) deriving (Eq, Show)

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
headSeq Nil         = Nil
headSeq (Unit a)    = Unit a
headSeq (Cat s1 s2) = s1


-- tailSeq, que remueve la cabeza de una secuencia.
tailSeq :: (Seq a) -> (Seq a)
tailSeq Nil
tailSeq (Unit )


-- normSeq, que elimina todos los Nils innecesarios de una secuencia. Por ejemplo, normSeq (Cat (Cat Nil (Unit 1)) Nil) = Unit 1



-- eqSeq, que toma dos secuencias y devuelve True sii ambas contienen los mismos valores, en el mismo orden y en la misma cantidad.



-- seq2List, que toma una secuencia y devuelve una lista con los mismos elementos, en el mismo orden.
