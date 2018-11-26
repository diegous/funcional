import Ej04B
import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
      [
        -- checkParentheses
        True  ~=? checkParentheses ""
      , False ~=? checkParentheses "("
      , False ~=? checkParentheses ")"
      , False ~=? checkParentheses ")("
      , False ~=? checkParentheses "(()"
      , False ~=? checkParentheses "())"
      , True  ~=? checkParentheses "()"
      , True  ~=? checkParentheses "(())"
      , True  ~=? checkParentheses "((()))"
      , True  ~=? checkParentheses "(()()())"
      , True  ~=? checkParentheses "(()()())()()((()))"
      , False ~=? checkParentheses "(()()())()()((())"
      , True  ~=? checkParentheses "(h(a)bi(a)una(v)ez)(t)r()(u(())z)"
      , False ~=? checkParentheses "ha(b()ia()(u)n)(a)(ve)z(tr(u())z:]"

        -- checkBrackets
      , True  ~=? checkBrackets ""
      , False ~=? checkBrackets "["
      , False ~=? checkBrackets "]"
      , False ~=? checkBrackets "]["
      , False ~=? checkBrackets "[[]"
      , False ~=? checkBrackets "[]]"
      , True  ~=? checkBrackets "[]"
      , True  ~=? checkBrackets "[[]]"
      , True  ~=? checkBrackets "[[[]]]"
      , True  ~=? checkBrackets "[[][][]]"
      , True  ~=? checkBrackets "[[][][]][][][[[]]]"
      , False ~=? checkBrackets "[[][][]][][][[[]]"
      , True  ~=? checkBrackets "[h[a]bi[a]una[v]ez][t]r[][u[[]]z]"
      , False ~=? checkBrackets "ha[b[]ia[][u]n][a][ve]z[tr[u[]]z:)"

        -- generalChecker
      , True  ~=? generalChecker '[' ']' ""
      , False ~=? generalChecker '[' ']' "["
      , False ~=? generalChecker '[' ']' "]"
      , False ~=? generalChecker '[' ']' "]["
      , False ~=? generalChecker '[' ']' "[[]"
      , False ~=? generalChecker '[' ']' "[]]"
      , True  ~=? generalChecker '[' ']' "[]"
      , True  ~=? generalChecker '[' ']' "[[]]"
      , True  ~=? generalChecker '[' ']' "[[[]]]"
      , True  ~=? generalChecker '[' ']' "[[][][]]"
      , True  ~=? generalChecker '[' ']' "[[][][]][][][[[]]]"
      , False ~=? generalChecker '[' ']' "[[][][]][][][[[]]"
      , True  ~=? generalChecker '[' ']' "[h[a]bi[a]una[v]ez][t]r[][u[[]]z]"
      , False ~=? generalChecker '[' ']' "ha[b[]ia[][u]n][a][ve]z[tr[u[]]z:)"
      ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------

-- a) Utilizando el TAD de las pilas definir una función que verifique si
-- una cadena de caracteres cumple la condición de balanceo de paréntesis.
checkParentheses :: [Char] -> Bool
checkParentheses = checkP emptyS

checkP :: (Stack Char) -> [Char] -> Bool
checkP s []     = isEmptyS s
checkP s (c:cs) = if c == '('
                  then checkP (pushS '(' s) cs
                  else
                    if c == ')'
                    then if (isEmptyS s) then False
                         else checkP (popS s) cs
                    else checkP s cs




-- b) Hacer lo mismo verificando el balance de corchetes.
checkBrackets :: [Char] -> Bool
checkBrackets = checkB emptyS

checkB :: (Stack Char) -> [Char] -> Bool
checkB s []     = isEmptyS s
checkB s (c:cs) = if c == '['
                  then checkB (pushS '[' s) cs
                  else
                    if c == ']'
                    then if (isEmptyS s)
                         then False
                         else checkB (popS s) cs
                    else checkB s cs




-- c) Finalmente, dar una solución genérica, en la que de acuerdo a los
-- sı́mbolos de apertura y cierre recibidos, indique si una expresión está
-- balanceada.
generalChecker :: Char -> Char -> ([Char] -> Bool)
generalChecker c1 c2 = checkG c1 c2 emptyS

checkG :: Char -> Char -> (Stack Char) -> [Char] ->  Bool
checkG _  _  s []     = isEmptyS s
checkG c1 c2 s (c:cs) = if c == c1
                        then checkG c1 c2 (pushS c1 s) cs
                        else
                          if c == c2
                          then if (isEmptyS s)
                               then False
                               else checkG c1 c2 (popS s) cs
                          else checkG c1 c2 s cs
