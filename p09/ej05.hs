import Test.HUnit

gen_exp_1 = Leaf 1
gen_exp_2 = Un (Leaf 2)
gen_exp_3 = BinG gen_exp_1 gen_exp_2

nexp_1 = Num 6
nexp_2 = (Num 2) `Sum` (Num 3)
nexp_3 = (Num 7) `Sub` (Num 4)
nexp_4 = Neg (Num 1)
nexp_5 = (Num 4) `Sum` ((Num 3) `Sub` (Num 2)) `Sub` (Neg (Neg (Num (-5)))) -- 4 + (3 - 2) - -(-5)

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- foldGenExp
          2  ~=? foldGenExp succ (*(-2)) (+) gen_exp_1
      , (-6) ~=? foldGenExp succ (*(-2)) (+) gen_exp_2
      , (-4) ~=? foldGenExp succ (*(-2)) (+) gen_exp_3


        -- foldNExp
      ,   6  ~=? foldNExp id (+) (-) negate nexp_1
      ,   5  ~=? foldNExp id (+) (-) negate nexp_2
      ,   3  ~=? foldNExp id (+) (-) negate nexp_3
      , (-1) ~=? foldNExp id (+) (-) negate nexp_4
      ,  10  ~=? foldNExp id (+) (-) negate nexp_5

      ,  6 ~=? foldNExp id (+) (+) id nexp_1
      ,  5 ~=? foldNExp id (+) (+) id nexp_2
      , 11 ~=? foldNExp id (+) (+) id nexp_3
      ,  1 ~=? foldNExp id (+) (+) id nexp_4
      ,  4 ~=? foldNExp id (+) (+) id nexp_5


        -- foldEither
      , 3 ~=? foldEither negate (*2) (Left' (-3))
      , 8 ~=? foldEither negate (*2) (Right'  4)


        -- foldNat
      , 0 ~=? foldNat 0 succ Zero
      , 1 ~=? foldNat 0 succ (Succ Zero)
      , 7 ~=? foldNat 0 succ (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))

      ,   1 ~=? foldNat 1 (*2) Zero
      ,   2 ~=? foldNat 1 (*2) (Succ Zero)
      , 128 ~=? foldNat 1 (*2) (Succ (Succ (Succ (Succ (Succ (Succ (Succ Zero)))))))
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- 5. Implementar los folds sobre cada uno de los siguientes tipos:
-- a) data GenExp a = Leaf a | Un (GenExp a) | BinG (GenExp a) (GenExp a)
data GenExp a = Leaf a | Un (GenExp a) | BinG (GenExp a) (GenExp a)

foldGenExp :: (a -> b) -> (b -> b) -> (b -> b -> b) -> (GenExp a) -> b
foldGenExp f g h (Leaf a)       = f a
foldGenExp f g h (Un ge)        = g (foldGenExp f g h ge)
foldGenExp f g h (BinG ge1 ge2) = h (foldGenExp f g h ge1) (foldGenExp f g h ge2)


-- b) data NExp = Num Int | Sum NExp NExp | Sub NExp NExp | Neg NExp
data NExp = Num Int | Sum NExp NExp | Sub NExp NExp | Neg NExp

foldNExp :: (Int -> b) -> (b -> b -> b) -> (b -> b -> b) -> (b -> b) -> NExp -> b
foldNExp f g h i (Num n)       = f n
foldNExp f g h i (Sum ne1 ne2) = g (foldNExp f g h i ne1) (foldNExp f g h i ne2)
foldNExp f g h i (Sub ne1 ne2) = h (foldNExp f g h i ne1) (foldNExp f g h i ne2)
foldNExp f g h i (Neg ne)      = i (foldNExp f g h i ne)


-- c) Either a b = Left a | Right b
data Either' a b = Left' a | Right' b

foldEither :: (a -> c) -> (b -> c) -> (Either' a b) -> c
foldEither f g (Left'  a) = f a
foldEither f g (Right' b) = g b


-- d) data Nat = Zero | Succ Nat
data Nat = Zero | Succ Nat

foldNat :: a -> (a -> a) -> Nat -> a
foldNat z f Zero     = z
foldNat z f (Succ n) = f (foldNat z f n)
