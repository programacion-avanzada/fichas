# Programación Dinámica - Neapolitan (2015)

*Lectura previa a la clase, basada en R. Neapolitan, Foundations of Algorithms, 5.ª edición, Capítulo 3. Todo sale del libro; al final está el recorrido para leerlo después de la clase.*

**Conviene repasar antes:** Fibonacci recursivo e iterativo (Sección 1.2, Algoritmos 1.6 y 1.7); división y conquista y cuándo resulta ineficiente (Capítulo 2, Sección 2.8); el coeficiente binomial (Apéndice A, Sección A.7).

## 1. ¿Para qué programación dinámica?

El algoritmo recursivo para el término $n$-ésimo de Fibonacci (Algoritmo 1.6) calcula una cantidad de términos exponencial en $n$. Pasa porque división y conquista parte la instancia en instancias más chicas y las resuelve a ciegas, una por una.

Eso funciona cuando las instancias chicas no se relacionan, como en Mergesort, donde cada mitad se ordena por su cuenta. En Fibonacci, en cambio, están relacionadas. Para el quinto término hacen falta el cuarto y el tercero, y los dos necesitan el segundo. Como cada llamada trabaja por separado, el segundo se calcula más de una vez, y lo mismo pasa con otros. El resultado es un algoritmo muy ineficiente.

## 2. La idea

La **programación dinámica** (*dynamic programming*) también divide la instancia en otras más chicas, pero recorre el camino al revés: resuelve primero las más chicas, **guarda los resultados** y, cada vez que necesita uno, lo busca en lugar de recalcularlo. Por eso es un enfoque **de abajo hacia arriba** (*bottom-up*), mientras que división y conquista es **de arriba hacia abajo** (*top-down*).

El nombre viene de la teoría de control: ahí "programación" significa usar un arreglo (una tabla) donde se construye la solución. El Fibonacci iterativo (Algoritmo 1.7) ya hacía esto: llena un arreglo `f` con los primeros $n+1$ términos, en orden, y cada uno sale de dos que ya están guardados.

Según el libro, el desarrollo tiene dos pasos:

1. Establecer una **propiedad recursiva** (*recursive property*) que dé la solución de una instancia en función de instancias más chicas.
2. Resolver de abajo hacia arriba: primero las instancias chicas, después las más grandes.

## 3. Un caso completo: el coeficiente binomial

El coeficiente binomial es

$$\binom{n}{k}=\frac{n!}{k!\,(n-k)!}\qquad 0\le k\le n.$$

Calcularlo así no es viable cuando $n$ y $k$ no son chicos, porque $n!$ crece enormemente. Pero vale una propiedad recursiva (Igualdad 3.1) que evita los factoriales:

$$\binom{n}{k}=\begin{cases}\dbinom{n-1}{k-1}+\dbinom{n-1}{k} & 0<k<n\\[8pt] 1 & k=0 \text{ o } k=n\end{cases}$$

Cada coeficiente es la suma de dos coeficientes "de la fila anterior", y los extremos valen 1.

- **Con división y conquista** (Algoritmo 3.1), la función `bin` se llama a sí misma dos veces. Pero `bin(n-1, k-1)` y `bin(n-1, k)` necesitan, cada una por su lado, `bin(n-2, k-1)`: otra vez se resuelve lo mismo muchas veces. Es el caso malo que ya señalaba la Sección 2.8: dos instancias casi tan grandes como la original.
- **Con programación dinámica** (Algoritmo 3.2), se usa un arreglo `B` donde `B[i][j]` guarda $\binom{i}{j}$. El paso 1 es la Igualdad 3.1 escrita en términos de `B`; el paso 2 es llenar las filas en orden, empezando por la fila 0. Ese arreglo es el triángulo de Pascal (Fig. 3.1).

**Un vistazo al Ejemplo 3.1.** Se quiere `B[4][2]`, es decir $\binom{4}{2}$. Como $k = 2$, cada fila se completa solo hasta la columna 2. La fila 2 queda 1, 2, 1, y de ahí la fila 3 es 1, 3, 3: por ejemplo, `B[3][1] = B[2][0] + B[2][1] = 1 + 2 = 3`. Cada casilla encuentra ya guardados los dos valores que necesita. Completar la fila 4 es un buen ejercicio; el resultado está en el libro.

```text
int bin2 (int n, int k) {
  index i, j;  int B[0..n][0..k];
  for (i = 0; i <= n; i++)
    for (j = 0; j <= minimum(i, k); j++)
      if (j == 0 || j == i)  B[i][j] = 1;
      else  B[i][j] = B[i-1][j-1] + B[i-1][j];
  return B[n][k];
}
```

Según el análisis del libro, esta versión hace un trabajo en $\Theta(nk)$, mucho más eficiente que la recursiva. Además, se puede ajustar para usar menos memoria: una vez calculada una fila, la anterior ya no hace falta.

**Cuándo conviene probarla.** Cuando división y conquista resulta ineficiente por resolver varias veces las mismas subinstancias. Si las subinstancias no se relacionan, como en Mergesort, no hay nada para reusar.

## Para llevar a clase

El resto del capítulo aplica la técnica a problemas de optimización. ¿Qué condición tiene que cumplir un problema de optimización para poder resolverlo con programación dinámica, y por qué el de los caminos simples más largos en un grafo no la cumple? (Sección 3.3, Ejemplo 3.4.)

## Después de la clase: el recorrido por el libro

1. **Introducción del capítulo:** por qué falla el Fibonacci recursivo y los dos pasos de la técnica.
2. **Sección 3.1:** el coeficiente binomial; las dos versiones (Algoritmos 3.1 y 3.2), el Ejemplo 3.1 completo, la Fig. 3.1 y el análisis del Algoritmo 3.2.
3. **Sección 3.3:** programación dinámica y optimización; el tercer paso, la condición que pide la pregunta de arriba y el Ejemplo 3.4.
4. **Secciones 3.2 y 3.4 a 3.7:** las aplicaciones, a medida que se vean: caminos más cortos, multiplicación encadenada de matrices, árboles binarios de búsqueda óptimos, el viajante y alineamiento de secuencias.
