module Ej04C
  where

type SL a = ((a -> a -> Bool),[a])

-- buildSL constuye una nueva lista vacı́a con un orden indicado.
buildSL :: (a -> a -> Bool) -> SL a
buildSL f = (f,[])

-- isEmptySL indica si la lista está vacı́a.
isEmptySL :: SL a -> Bool
isEmptySL (f,[]) = True
isEmptySL _      = False

-- insertSL devuelve la lista ordenada a la cual se le inserta el elemento
-- dado como argumento.
insertSL :: a -> SL a -> SL a
insertSL y (f,[]) = (f,[y])
insertSL y (f,(x:xs)) = if f y x
                        then (f,(y:x:xs))
                        else
                          let (_,ys) = insertSL y (f,xs)
                           in (f,x:ys)


-- headSL da el primer elemento de la lista que precede a todos, de acuerdo
-- al orden.
headSL :: SL a -> a
headSL (_,x:_) = x

-- tailSL devuelve la cola de la lista ordenada.
tailSL :: SL a -> SL a
tailSL (f,_:xs) = (f,xs)
