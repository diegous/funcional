import Test.HUnit

-- Tests
main = do
  runTestTT
    (
      TestList
        [
          -- ColorPrimario & ColorSecundario
          -- mezclar
          TestCase (assertEqual "mezclar" Naranja (mezclar Rojo Amarillo)),
          TestCase (assertEqual "mezclar" Naranja (mezclar Amarillo Rojo)),
          TestCase (assertEqual "mezclar" Violeta (mezclar Rojo Azul    )),
          TestCase (assertEqual "mezclar" Violeta (mezclar Azul Rojo    )),
          TestCase (assertEqual "mezclar" Verde   (mezclar Amarillo Azul)),
          TestCase (assertEqual "mezclar" Verde   (mezclar Azul Amarillo)),


          -- Punto
          -- distancia
          TestCase (assertEqual "distancia" 5  (distancia (Punto2D 0 0) (Punto2D 3 4))),
          TestCase (assertEqual "distancia" 13 (distancia (Punto2D 5 7) (Punto2D 10 19))),

          -- -- xcoord
          TestCase (assertEqual "xcoord" 5 (xcoord (Punto2D 5 3))),
          TestCase (assertEqual "xcoord" 5 (xcoord (Punto3D 5 3 1))),

          -- -- ycoord
          TestCase (assertEqual "ycoord" 3 (ycoord (Punto2D 5 3))),
          TestCase (assertEqual "ycoord" 3 (ycoord (Punto3D 5 3 1))),

          -- -- suma
          TestCase (assertEqual "suma" (Punto2D 5 3) (suma (Punto2D 5 3) (Punto2D 0 0))),
          TestCase (assertEqual "suma" (Punto2D 0 0) (suma (Punto2D (-5.0) (-3.0)) (Punto2D 5 3))),


          -- Figura
          -- area
          TestCase (assertEqual "area" 8  (area (Rectangulo (Punto2D 0 0) 2 4))),

          -- perimetro
          TestCase (assertEqual "perimetro" 8  (perimetro (Rectangulo (Punto2D 0 0) 1 3))),

          -- mover
          TestCase (assertEqual "mover" (Circulo    (Punto2D 2 3) 3)   (mover (Circulo    (Punto2D 0 0) 3)   (Punto2D 2 3))),
          TestCase (assertEqual "mover" (Rectangulo (Punto2D 2 3) 1 3) (mover (Rectangulo (Punto2D 0 0) 1 3) (Punto2D 2 3))),


          -- last tests to avoid trailing comma
          TestCase (assertEqual "closing" 0  0)
        ]
    )

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Functions

data ColorPrimario = Rojo | Amarillo | Azul
data ColorSecundario = Naranja | Violeta | Verde deriving (Eq, Show)
-- el `deriving (Show, Eq)` es porque los test necesitan que el `data` tenga `Eq` para poder
-- compararlos, y `Show` para poder mostrar los errores, sería equivalente a hacer esto

-- instance Eq ColorSecundario where
--   (==) Naranja Naranja = True
--   (==) Violeta Violeta = True
--   (==) Verde Verde     = True
--   (==) _ _             = False

-- instance Show ColorSecundario where
--   show Naranja = "Naranja"
--   show Violeta = "Violeta"
--   show Verde   = "Verde"

mezclar :: ColorPrimario -> ColorPrimario -> ColorSecundario
mezclar Rojo Amarillo = Naranja
mezclar Amarillo Rojo = Naranja
mezclar Rojo Azul     = Violeta
mezclar Azul Rojo     = Violeta
mezclar Amarillo Azul = Verde
mezclar Azul Amarillo = Verde




------------------------------
--------- PUNTO --------------
------------------------------
data Punto = Punto2D Float Float        -- x, y
           | Punto3D Float Float Float -- y, y z
           deriving (Eq, Show)

distancia :: Punto -> Punto -> Float
distancia (Punto2D x1 y1) (Punto2D x2 y2) = sqrt ((x1 - x2) ** 2 + (y1 - y2) ** 2)

xcoord :: Punto -> Float
xcoord (Punto2D x _) = x
xcoord (Punto3D x _ _) = x

ycoord :: Punto -> Float
ycoord (Punto2D _ y) = y
ycoord (Punto3D _ y _) = y

suma :: Punto -> Punto -> Punto
suma (Punto2D x1 y1)    (Punto2D x2 y2)    = Punto2D (x1+x2) (y1+y2)
suma (Punto3D x1 y1 z1) (Punto3D x2 y2 z2) = Punto3D (x1+x2) (y1+y2) (z1+z2)




------------------------------
--------- FIGURA -------------
------------------------------
data Figura = Circulo    { coord :: Punto, radio :: Float }
            | Rectangulo { coord :: Punto, base :: Float, altura :: Float}
            deriving (Eq, Show)

area :: Figura -> Float
area (Circulo p r)      = pi * (r ** 2)
area (Rectangulo p b h) = b * h

perimetro :: Figura -> Float
perimetro (Circulo p r)      = pi * r
perimetro (Rectangulo p b h) = (b + h) * 2

mover :: Figura -> Punto -> Figura
mover (Circulo p r)      p2 = (Circulo p2 r)
mover (Rectangulo p b h) p2 = (Rectangulo p2 b h)




------------------------------
--------- PERSONA ------------
------------------------------
data Persona =
    Desempleado String Int String String String               -- nombre, edad, dni, dir, tel
  | Trabajador  String Int String String String String String -- nombre, edad, dni, dir, tel, dirTrabajo, telTrabajo
  deriving Show
