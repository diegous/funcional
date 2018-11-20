b) ¿Qué ventajas y desventajas encuentra de Seq respecto a las listas de Haskell ([])?

Una desventaja es que esta representación permite ambiguedades. Es decir, una misma lista se puede representar de muchas formas distintas de Seq. Esto hace que las funciones definidas en el punto anterior sean más compljeas de implementar que para listas.

Una ventaja es que se podría implementar algunos algoritmos más eficientes para la estructura Seq, por ejemplo la búsqueda binaria, ya que las listas solo se pueden recorrer en orden lineal.
