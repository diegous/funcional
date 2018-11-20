import Ej04B
import Test.HUnit


-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- isEmptyS
          TestCase ( True  @=? isEmptyS emptyS ),
          TestCase ( False @=? isEmptyS (pushS 1 emptyS) ),
          TestCase ( True  @=? isEmptyS (popS (pushS 1 emptyS)) ),

          -- pushS
          TestCase ( (Pila [1])     @=? pushS 1 emptyS ),
          TestCase ( (Pila [2,1])   @=? pushS 2 (pushS 1 emptyS) ),
          TestCase ( (Pila [3,2,1]) @=? pushS 3 (pushS 2 (pushS 1 emptyS)) ),

          -- popS
          TestCase ( (Pila [])    @=? popS (Pila [1]) ),
          TestCase ( (Pila [1])   @=? popS (Pila [2,1]) ),
          TestCase ( (Pila [2,1]) @=? popS (Pila [3,2,1]) ),
          TestCase ( (Pila [])    @=? (popS . popS . popS) (Pila [3,2,1]) ),

          -- topS
          TestCase ( 1 @=? topS (Pila [1]) ),
          TestCase ( 2 @=? topS (Pila [2,1]) ),
          TestCase ( 3 @=? topS (Pila [3,2,1]) ),

          -- sizeS
          TestCase ( 1 @=? sizeS (Pila [1]) ),
          TestCase ( 2 @=? sizeS (Pila [2,1]) ),
          TestCase ( 3 @=? sizeS (Pila [3,2,1]) ),

          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )
