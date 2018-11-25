import Test.HUnit

-- normIff = (Not ((Not Atom) `Or` (Not Atom))) `Or` (Not (Or Atom Atom))
normIff = Or (Not ((Not Atom)       `Or` (Not Atom)))
             (Not ((Not (Not Atom)) `Or` (Not (Not Atom))))

iffFN = OrFN (NotFN ((NotFN AtomFN)       `OrFN` (NotFN AtomFN)))
             (NotFN ((NotFN (NotFN AtomFN)) `OrFN` (NotFN (NotFN AtomFN))))

enunciado = (Implies (Not Atom) (And (Forall "x" Atom) Atom))
normEnunciado =
  Or (Not (Not Atom))
     (Not (Or (Not (Not (Exists "x" (Not Atom)))) (Not Atom)))

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- normalize
        Atom         ~=? normalize Atom
      , Not Atom     ~=? normalize (Not Atom)
      , Or Atom Atom ~=? normalize (Or Atom Atom)

      , (Not (Or (Not Atom) (Not Atom))) ~=? normalize (And Atom Atom)
      , (Or (Not Atom) Atom)             ~=? normalize (Implies Atom Atom)
      , (Not (Exists "x" (Not Atom)))    ~=? normalize (Forall "x" Atom)
      , normIff                          ~=? normalize (Iff Atom Atom)

      , normEnunciado ~=? normalize enunciado


        -- fn2FN
      , AtomFN               ~=? fn2FN Atom
      , (NotFN AtomFN)       ~=? fn2FN (Not Atom)
      , (OrFN AtomFN AtomFN) ~=? fn2FN (Or Atom Atom)


        -- form2FN
      , AtomFN               ~=? form2FN Atom
      , (NotFN AtomFN)       ~=? form2FN (Not Atom)
      , (OrFN AtomFN AtomFN) ~=? form2FN (Or Atom Atom)

      , (NotFN (OrFN (NotFN AtomFN) (NotFN AtomFN))) ~=? form2FN (And Atom Atom)
      , (OrFN (NotFN AtomFN) AtomFN)                 ~=? form2FN (Implies Atom Atom)
      , (NotFN (ExistsFN "x" (NotFN AtomFN)))        ~=? form2FN (Forall "x" Atom)
      , iffFN                                        ~=? form2FN (Iff Atom Atom)
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- a
type Var = String
data Form = Atom                | Not Form
          | Or Form Form        | And Form Form
          | Implies Form Form   | Iff Form Form
          | Forall Var Form     | Exists Var Form
          deriving (Eq, Show)

normalize :: Form -> Form
normalize (And     x y) = Not (Not (normalize x) `Or` Not (normalize y))
normalize (Implies x y) = Or (Not (normalize x)) (normalize y)
normalize (Forall  v x) = Not (Exists v (Not (normalize x)))
normalize (Iff     x y) = let x' = normalize x
                              y' = normalize y
                           in Or (normalize (And x' y'))
                                 (normalize (And (Not x') (Not y')))
normalize x             = x


-- b
data FN = AtomFN      | NotFN FN
        | OrFN FN FN  | ExistsFN Var FN
        deriving (Eq, Show)

fn2FN :: Form -> FN
fn2FN Atom         = AtomFN
fn2FN (Not x)      = NotFN (fn2FN x)
fn2FN (Or x y)     = OrFN (fn2FN x) (fn2FN y)
fn2FN (Exists v x) = ExistsFN v (fn2FN x)

form2FN :: Form -> FN
form2FN = fn2FN . normalize
