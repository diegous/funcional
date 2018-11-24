import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- sumaBinaria
        [Cero] ~=? sumaBinaria [Cero] [Cero] -- 0 + 0 = 0
      , [Uno] ~=? sumaBinaria [Uno] [Cero] -- 1 + 0 = 1
      , [Uno] ~=? sumaBinaria [Cero] [Uno] -- 0 + 1 = 1
      , [Cero, Uno] ~=? sumaBinaria [Uno] [Uno] -- 1 + 1 = 10
      , [Cero, Cero, Cero, Cero, Uno] ~=? sumaBinaria [Uno, Uno, Uno, Uno] [Uno] -- 15 + 1 = 16
      , [Cero, Cero, Cero, Cero, Uno] ~=? sumaBinaria [Uno] [Uno, Uno, Uno, Uno] -- 1 + 15 = 16
      , [Cero, Uno, Cero, Uno, Uno] ~=? sumaBinaria [Uno, Cero, Uno] [Uno, Cero, Uno, Cero, Uno] -- 5 + 21 = 26
      , [Cero, Uno, Cero, Uno, Uno] ~=? sumaBinaria [Uno, Cero, Uno, Cero, Uno] [Uno, Cero, Uno] -- 21 + 5 = 26

        -- dobleBinario
      , [Cero] ~=? dobleBinario [Cero] -- 0 * 2 = 0
      , [Cero, Uno] ~=? dobleBinario [Uno] -- 1 * 2 = 2
      , [Cero, Cero, Uno] ~=? dobleBinario [Cero, Uno] -- 2 * 2 = 4
      , [Cero, Uno, Uno] ~=? dobleBinario [Uno, Uno] -- 3 * 2 = 6
      , [Cero, Cero, Cero, Uno] ~=? dobleBinario [Cero, Cero, Uno] -- 4 * 2 = 8
      , [Cero, Uno, Cero, Uno] ~=? dobleBinario [Uno, Cero, Uno] -- 5 * 2 = 10
      , [Cero, Cero, Uno, Uno] ~=? dobleBinario [Cero, Uno, Uno] -- 6 * 2 = 12

        -- divDosBinario
      , [Cero] ~=? divDosBinario [Cero] -- 0 div 2 = 0
      , [Cero] ~=? divDosBinario [Uno] -- 1 div 2 = 0
      , [Uno] ~=? divDosBinario [Cero, Uno]  -- 2 div 2 = 1
      , [Uno] ~=? divDosBinario [Uno, Uno] -- 3 div 2 = 1
      , [Cero, Uno] ~=? divDosBinario [Cero, Cero, Uno] -- 4 div 2 = 2
      , [Cero, Uno] ~=? divDosBinario [Uno, Cero, Uno] -- 5 div 2 = 2
      , [Uno, Uno] ~=? divDosBinario [Cero, Uno, Uno] -- 6 div 2 = 3

        -- modDosBinario
      , Cero ~=? modDosBinario [Cero] -- 0 mod 2 = 0
      ,  Uno ~=? modDosBinario [Uno] -- 1 mod 2 = 1
      , Cero ~=? modDosBinario [Cero, Uno] -- 2 mod 2 = 0
      ,  Uno ~=? modDosBinario [Uno, Uno] -- 3 mod 2 = 1
      , Cero ~=? modDosBinario [Cero, Cero, Uno] -- 4 mod 2 = 0
      ,  Uno ~=? modDosBinario [Uno, Cero, Uno] -- 5 mod 2 = 1
      , Cero ~=? modDosBinario [Cero, Uno, Uno] -- 6 mod 2 = 0


        ------------------------
        -- sumaBinaria'
      , [Cero] ~=? sumaBinaria' [Cero] [Cero] -- 0 + 0 = 0
      , [Uno] ~=? sumaBinaria' [Uno] [Cero] -- 1 + 0 = 1
      , [Uno] ~=? sumaBinaria' [Cero] [Uno] -- 0 + 1 = 1
      , [Uno, Cero] ~=? sumaBinaria' [Uno] [Uno] -- 1 + 1 = 10
      , [Uno, Cero, Cero, Cero, Cero] ~=? sumaBinaria' [Uno, Uno, Uno, Uno] [Uno] -- 15 + 1 = 16
      , [Uno, Cero, Cero, Cero, Cero] ~=? sumaBinaria' [Uno] [Uno, Uno, Uno, Uno] -- 1 + 15 = 16
      , [Uno, Uno, Cero, Uno, Cero] ~=? sumaBinaria' [Uno, Cero, Uno] [Uno, Cero, Uno, Cero, Uno] -- 5 + 21 = 26
      , [Uno, Uno, Cero, Uno, Cero] ~=? sumaBinaria' [Uno, Cero, Uno, Cero, Uno] [Uno, Cero, Uno] -- 21 + 5 = 26

        -- dobleBinario'
      , [Cero] ~=? dobleBinario' [Cero] -- 0 * 2 = 0
      , [Uno, Cero] ~=? dobleBinario' [Uno] -- 1 * 2 = 2
      , [Uno, Cero, Cero] ~=? dobleBinario' [Uno, Cero] -- 2 * 2 = 4
      , [Uno, Uno, Cero] ~=? dobleBinario' [Uno, Uno] -- 3 * 2 = 6
      , [Uno, Cero, Cero, Cero] ~=? dobleBinario' [Uno, Cero, Cero] -- 4 * 2 = 8
      , [Uno, Cero, Uno, Cero] ~=? dobleBinario' [Uno, Cero, Uno] -- 5 * 2 = 10
      , [Uno, Uno, Cero, Cero] ~=? dobleBinario' [Uno, Uno, Cero] -- 6 * 2 = 12

        -- divDosBinario'
      , [Cero] ~=? divDosBinario' [Cero] -- 0 div 2 = 0
      , [Cero] ~=? divDosBinario' [Uno] -- 1 div 2 = 0
      , [Uno] ~=? divDosBinario' [Uno, Cero]  -- 2 div 2 = 1
      , [Uno] ~=? divDosBinario' [Uno, Uno] -- 3 div 2 = 1
      , [Uno, Cero] ~=? divDosBinario' [Uno, Cero, Cero] -- 4 div 2 = 2
      , [Uno, Cero] ~=? divDosBinario' [Uno, Cero, Uno] -- 5 div 2 = 2
      , [Uno, Uno] ~=? divDosBinario' [Uno, Uno, Cero] -- 6 div 2 = 3

        -- modDosBinario'
      , Cero ~=? modDosBinario' [Cero] -- 0 mod 2 = 0
      ,  Uno ~=? modDosBinario' [Uno] -- 1 mod 2 = 1
      , Cero ~=? modDosBinario' [Uno, Cero] -- 2 mod 2 = 0
      ,  Uno ~=? modDosBinario' [Uno, Uno] -- 3 mod 2 = 1
      , Cero ~=? modDosBinario' [Uno, Cero, Cero] -- 4 mod 2 = 0
      ,  Uno ~=? modDosBinario' [Uno, Cero, Uno] -- 5 mod 2 = 1
      , Cero ~=? modDosBinario' [Uno, Uno, Cero] -- 6 mod 2 = 0
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- a)
data DigBin = Cero | Uno deriving (Eq, Show)

suma :: DigBin -> DigBin -> DigBin
suma Cero Cero = Cero
suma Cero Uno  = Uno
suma Uno  Cero = Uno
suma Uno  Uno  = Cero

doble :: DigBin -> DigBin
doble Cero = Cero
doble Uno  = Cero


-- b)
type NumBin = [DigBin]

sumaBinaria :: NumBin -> NumBin -> NumBin
sumaBinaria [] n2 = n2
sumaBinaria n1 [] = n1
sumaBinaria (Cero:ns1) (Cero:ns2) = Cero : (sumaBinaria ns1 ns2)
sumaBinaria (Cero:ns1) (Uno:ns2)  = Uno  : (sumaBinaria ns1 ns2)
sumaBinaria (Uno:ns1)  (Cero:ns2) = Uno  : (sumaBinaria ns1 ns2)
sumaBinaria (Uno:ns1)  (Uno:ns2)  = Cero : (sumaBinaria (sumaBinaria ns1 ns2) [Uno])

dobleBinario :: NumBin -> NumBin
dobleBinario [] = error "no es una cadena válida"
dobleBinario ns = sumaBinaria ns ns

divDosBinario :: NumBin -> NumBin
divDosBinario []     = error "no es una cadena válida"
divDosBinario [d]    = [Cero]
divDosBinario (d:ds) = ds

modDosBinario :: NumBin -> DigBin
modDosBinario []     = error "no es una cadena válida"
modDosBinario (d:ds) = d


-- c)
sumaBinaria' :: NumBin -> NumBin -> NumBin
sumaBinaria' n1 n2 = reverse (sumaBinaria (reverse n1) (reverse n2))

dobleBinario' :: NumBin -> NumBin
dobleBinario' ns = let sn = reverse ns in reverse (sumaBinaria sn sn)

divDosBinario' :: NumBin -> NumBin
divDosBinario' ds = reverse (divDosBinario (reverse ds))

modDosBinario' :: NumBin -> DigBin
modDosBinario' ds = modDosBinario (reverse ds)
