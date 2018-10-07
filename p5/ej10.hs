import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- sumaBinaria
          TestCase (assertEqual "sumaBinaria" [Cero] (sumaBinaria [Cero] [Cero])), -- 0 + 0 = 0
          TestCase (assertEqual "sumaBinaria" [Uno] (sumaBinaria [Uno] [Cero])), -- 1 + 0 = 1
          TestCase (assertEqual "sumaBinaria" [Uno] (sumaBinaria [Cero] [Uno])), -- 0 + 1 = 1
          TestCase (assertEqual "sumaBinaria" [Cero, Uno] (sumaBinaria [Uno] [Uno])), -- 1 + 1 = 10
          TestCase (assertEqual "sumaBinaria" [Cero, Cero, Cero, Cero, Uno] (sumaBinaria [Uno, Uno, Uno, Uno] [Uno])), -- 15 + 1 = 16
          TestCase (assertEqual "sumaBinaria" [Cero, Cero, Cero, Cero, Uno] (sumaBinaria [Uno] [Uno, Uno, Uno, Uno])), -- 1 + 15 = 16
          TestCase (assertEqual "sumaBinaria" [Cero, Uno, Cero, Uno, Uno] (sumaBinaria [Uno, Cero, Uno] [Uno, Cero, Uno, Cero, Uno])), -- 5 + 21 = 26
          TestCase (assertEqual "sumaBinaria" [Cero, Uno, Cero, Uno, Uno] (sumaBinaria [Uno, Cero, Uno, Cero, Uno] [Uno, Cero, Uno])), -- 21 + 5 = 26

          -- dobleBinario
          TestCase (assertEqual "dobleBinario" [Cero] (dobleBinario [Cero])), -- 0 * 2 = 0
          TestCase (assertEqual "dobleBinario" [Cero, Uno] (dobleBinario [Uno])), -- 1 * 2 = 2
          TestCase (assertEqual "dobleBinario" [Cero, Cero, Uno] (dobleBinario [Cero, Uno])), -- 2 * 2 = 4
          TestCase (assertEqual "dobleBinario" [Cero, Uno, Uno] (dobleBinario [Uno, Uno])), -- 3 * 2 = 6
          TestCase (assertEqual "dobleBinario" [Cero, Cero, Cero, Uno] (dobleBinario [Cero, Cero, Uno])), -- 4 * 2 = 8
          TestCase (assertEqual "dobleBinario" [Cero, Uno, Cero, Uno] (dobleBinario [Uno, Cero, Uno])), -- 5 * 2 = 10
          TestCase (assertEqual "dobleBinario" [Cero, Cero, Uno, Uno] (dobleBinario [Cero, Uno, Uno])), -- 6 * 2 = 12

          -- divDosBinario
          TestCase (assertEqual "divDosBinario"  [Cero] (divDosBinario [Cero])), -- 0 div 2 = 0
          TestCase (assertEqual "divDosBinario"  [Cero] (divDosBinario [Uno])), -- 1 div 2 = 0
          TestCase (assertEqual "divDosBinario"  [Uno] (divDosBinario [Cero, Uno] )), -- 2 div 2 = 1
          TestCase (assertEqual "divDosBinario"  [Uno] (divDosBinario [Uno, Uno])), -- 3 div 2 = 1
          TestCase (assertEqual "divDosBinario"  [Cero, Uno] (divDosBinario [Cero, Cero, Uno])), -- 4 div 2 = 2
          TestCase (assertEqual "divDosBinario"  [Cero, Uno] (divDosBinario [Uno, Cero, Uno])), -- 5 div 2 = 2
          TestCase (assertEqual "divDosBinario"  [Uno, Uno] (divDosBinario [Cero, Uno, Uno])), -- 6 div 2 = 3

          -- modDosBinario
          TestCase (assertEqual "modDosBinario"  Cero (modDosBinario [Cero])), -- 0 mod 2 = 0
          TestCase (assertEqual "modDosBinario"  Uno  (modDosBinario [Uno])), -- 1 mod 2 = 1
          TestCase (assertEqual "modDosBinario"  Cero (modDosBinario [Cero, Uno])), -- 2 mod 2 = 0
          TestCase (assertEqual "modDosBinario"  Uno  (modDosBinario [Uno, Uno])), -- 3 mod 2 = 1
          TestCase (assertEqual "modDosBinario"  Cero (modDosBinario [Cero, Cero, Uno])), -- 4 mod 2 = 0
          TestCase (assertEqual "modDosBinario"  Uno  (modDosBinario [Uno, Cero, Uno])), -- 5 mod 2 = 1
          TestCase (assertEqual "modDosBinario"  Cero (modDosBinario [Cero, Uno, Uno])), -- 6 mod 2 = 0


          ------------------------
          -- sumaBinaria'
          TestCase (assertEqual "sumaBinaria'" [Cero] (sumaBinaria' [Cero] [Cero])), -- 0 + 0 = 0
          TestCase (assertEqual "sumaBinaria'" [Uno] (sumaBinaria' [Uno] [Cero])), -- 1 + 0 = 1
          TestCase (assertEqual "sumaBinaria'" [Uno] (sumaBinaria' [Cero] [Uno])), -- 0 + 1 = 1
          TestCase (assertEqual "sumaBinaria'" [Uno, Cero] (sumaBinaria' [Uno] [Uno])), -- 1 + 1 = 10
          TestCase (assertEqual "sumaBinaria'" [Uno, Cero, Cero, Cero, Cero] (sumaBinaria' [Uno, Uno, Uno, Uno] [Uno])), -- 15 + 1 = 16
          TestCase (assertEqual "sumaBinaria'" [Uno, Cero, Cero, Cero, Cero] (sumaBinaria' [Uno] [Uno, Uno, Uno, Uno])), -- 1 + 15 = 16
          TestCase (assertEqual "sumaBinaria'" [Uno, Uno, Cero, Uno, Cero] (sumaBinaria' [Uno, Cero, Uno] [Uno, Cero, Uno, Cero, Uno])), -- 5 + 21 = 26
          TestCase (assertEqual "sumaBinaria'" [Uno, Uno, Cero, Uno, Cero] (sumaBinaria' [Uno, Cero, Uno, Cero, Uno] [Uno, Cero, Uno])), -- 21 + 5 = 26

          -- dobleBinario'
          TestCase (assertEqual "dobleBinario'" [Cero] (dobleBinario' [Cero])), -- 0 * 2 = 0
          TestCase (assertEqual "dobleBinario'" [Uno, Cero] (dobleBinario' [Uno])), -- 1 * 2 = 2
          TestCase (assertEqual "dobleBinario'" [Uno, Cero, Cero] (dobleBinario' [Uno, Cero])), -- 2 * 2 = 4
          TestCase (assertEqual "dobleBinario'" [Uno, Uno, Cero] (dobleBinario' [Uno, Uno])), -- 3 * 2 = 6
          TestCase (assertEqual "dobleBinario'" [Uno, Cero, Cero, Cero] (dobleBinario' [Uno, Cero, Cero])), -- 4 * 2 = 8
          TestCase (assertEqual "dobleBinario'" [Uno, Cero, Uno, Cero] (dobleBinario' [Uno, Cero, Uno])), -- 5 * 2 = 10
          TestCase (assertEqual "dobleBinario'" [Uno, Uno, Cero, Cero] (dobleBinario' [Uno, Uno, Cero])), -- 6 * 2 = 12

          -- divDosBinario'
          TestCase (assertEqual "divDosBinario'"  [Cero] (divDosBinario' [Cero])), -- 0 div 2 = 0
          TestCase (assertEqual "divDosBinario'"  [Cero] (divDosBinario' [Uno])), -- 1 div 2 = 0
          TestCase (assertEqual "divDosBinario'"  [Uno] (divDosBinario' [Uno, Cero] )), -- 2 div 2 = 1
          TestCase (assertEqual "divDosBinario'"  [Uno] (divDosBinario' [Uno, Uno])), -- 3 div 2 = 1
          TestCase (assertEqual "divDosBinario'"  [Uno, Cero] (divDosBinario' [Uno, Cero, Cero])), -- 4 div 2 = 2
          TestCase (assertEqual "divDosBinario'"  [Uno, Cero] (divDosBinario' [Uno, Cero, Uno])), -- 5 div 2 = 2
          TestCase (assertEqual "divDosBinario'"  [Uno, Uno] (divDosBinario' [Uno, Uno, Cero])), -- 6 div 2 = 3

          -- modDosBinario'
          TestCase (assertEqual "modDosBinario'"  Cero (modDosBinario' [Cero])), -- 0 mod 2 = 0
          TestCase (assertEqual "modDosBinario'"  Uno  (modDosBinario' [Uno])), -- 1 mod 2 = 1
          TestCase (assertEqual "modDosBinario'"  Cero (modDosBinario' [Uno, Cero])), -- 2 mod 2 = 0
          TestCase (assertEqual "modDosBinario'"  Uno  (modDosBinario' [Uno, Uno])), -- 3 mod 2 = 1
          TestCase (assertEqual "modDosBinario'"  Cero (modDosBinario' [Uno, Cero, Cero])), -- 4 mod 2 = 0
          TestCase (assertEqual "modDosBinario'"  Uno  (modDosBinario' [Uno, Cero, Uno])), -- 5 mod 2 = 1
          TestCase (assertEqual "modDosBinario'"  Cero (modDosBinario' [Uno, Uno, Cero])), -- 6 mod 2 = 0


          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
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
