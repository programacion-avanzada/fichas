# Branch-and-Bound - Neapolitan (2015)

*Lectura previa a la clase, basada en R. Neapolitan, Foundations of Algorithms, 5.ª edición, Capítulo 6. Todo sale del libro; al final está el recorrido para leerlo después de la clase.*

**Conviene repasar antes:** backtracking para la mochila 0-1 (Sección 5.7), qué es una cola de prioridad (Sección 4.4.2) y el problema del viajante (Sección 3.6).

## 1. ¿Para qué otra técnica más?

El capítulo arranca con un personaje ya conocido: el ladrón de la mochila 0-1. Tiene dos algoritmos, programación dinámica (Sección 4.5) y backtracking (Sección 5.7), pero los dos son exponenciales en el peor caso, así que para su instancia podrían tardar años. En la Sección 6.2 vuelve Nancy, la vendedora del problema del viajante. Resolvió 20 ciudades con programación dinámica, pero con 40 ciudades tardaría más de seis años, así que se conformó con encontrar *cualquier* tour, que puede ser muy malo.

Branch-and-bound les ofrece otra opción: en el peor caso sigue siendo exponencial, pero en muchas instancias grandes puede ser muy eficiente.

## 2. La idea: una cota en cada nodo

Igual que en backtracking, se recorre un árbol de espacio de estados. Hay dos diferencias: branch-and-bound se usa solo para problemas de **optimización** y no ata a un orden de recorrido.

En cada nodo se calcula un número, la **cota** (*bound*). La cota es un tope: si se está maximizando, ninguna solución que se obtenga bajando desde ese nodo puede superarla. No quiere decir que ese valor se alcance. Si la cota no supera la mejor solución encontrada hasta el momento, seguir por ahí no tiene sentido: el nodo es **no prometedor** (*nonpromising*).

El backtracking de la mochila (Sección 5.7) ya hacía esto. Lo nuevo es usar la cota también para elegir qué nodo expandir: comparar las cotas de los nodos prometedores y seguir por el que tenga la mejor.

## 3. Tres formas de recorrer el árbol

- **En profundidad** (*depth-first*): es el recorrido del backtracking del Capítulo 5, que sigue un orden fijo de antemano.
- **En anchura** (*breadth-first*): se visita el árbol nivel por nivel, usando una **cola**. La trampa: se decide si expandir un nodo al visitarlo, pero sus hijos se revisan después, cuando quizás ya se encontró una solución mejor, y entonces se revisan en vano.
- **Primero-el-mejor** (*best-first*): siempre se expande el nodo prometedor con la **mejor cota**, usando una **cola de prioridad**. Y al sacar cada nodo, se vuelve a mirar si sigue siendo prometedor.

**Un vistazo al Ejemplo 6.2.** La mochila tiene capacidad $W = 16$ y cuatro ítems. La raíz tiene cota \$115. De sus dos hijos, incluir el primer ítem da cota \$115 y no incluirlo da \$82. Primero-el-mejor sigue por el de \$115. Más adelante encuentra una solución de \$90, y en ese momento el nodo de \$82, que esperaba en la cola, deja de ser prometedor sin que nadie lo expanda. En total revisa 11 nodos, contra 17 en anchura y 13 en profundidad.

¿Siempre funciona tan bien? No: en el mismo ejemplo, un nodo que parecía mejor no llevaba al óptimo, y en algunas instancias se genera casi todo el árbol.

**El esquema general de primero-el-mejor (Sección 6.1.2):**

```text
initialize(PQ); v = root of T; best = value(v); insert(PQ, v);
while (!empty(PQ))
  remove(PQ, v);                      // sale el nodo con mejor cota
  if (bound(v) is better than best)   // ¿todavía es prometedor?
    for (each child u of v)
      if (value(u) is better than best) best = value(u);
      if (bound(u) is better than best) insert(PQ, u);
```

## 4. Cómo se calcula la cota en la mochila

Los ítems están ordenados por ganancia por unidad de peso, $p_i/w_i$. Desde el nodo, se agregan ítems completos mientras entren y, del primero que no entra (el ítem $k$), se suma solo la fracción que cabe:

$$\textit{bound} = \left(\textit{profit} + \sum_{j=i+1}^{k-1} p_j\right) + (W - \textit{totweight}) \cdot \frac{p_k}{w_k}$$

Acá $i$ es el nivel del nodo y *totweight* es su peso más el de los ítems completos agregados. Así se obtiene un valor que ninguna solución que pase por ese nodo puede superar. Si $\textit{bound} \le \textit{maxprofit}$, el nodo se poda. Y si el nodo ya se pasó del peso ($\textit{weight} \ge W$), también es no prometedor: su cota se fija en 0.

## 5. Cuando se minimiza: el viajante

Ahora se busca el tour más corto, así que la cota es un **mínimo posible**. Un nodo vale la pena si su cota es menor que el mejor tour encontrado (*minlength*).

¿De dónde sale ese mínimo? Todo tour sale de cada vértice exactamente una vez, y salir de un vértice cuesta, como mínimo, su arista más barata. Si se suman esos mínimos, la longitud de cualquier tour no puede ser menor. En el grafo de la Fig. 6.4, la cota de la raíz da 4 + 7 + 4 + 2 + 4 = 21. Eso no significa que exista un tour de 21, sino que ninguno es más corto. Con esta cota, el Ejemplo 6.3 revisa 17 nodos de los 41 del árbol.

Hay otras cotas posibles, pero calcular varias no siempre compensa: lo que importa es la eficiencia total, no solo visitar menos nodos.

## Después de la clase: el recorrido por el libro

1. **Introducción del capítulo:** la definición completa.
2. **Sección 6.1.1:** anchura con poda; Ejemplo 6.1, Fig. 6.2 y Algoritmo 6.1.
3. **Sección 6.1.2:** primero-el-mejor; el Ejemplo 6.2 completo, Fig. 6.3 y Algoritmo 6.2.
4. **Sección 6.2:** el viajante; cómo se calcula la cota en nodos internos, Ejemplo 6.3, Fig. 6.6 y Algoritmo 6.3.

---
*Referencias por número de sección, ejemplo, figura y algoritmo.*
