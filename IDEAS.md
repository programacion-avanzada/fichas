# Ideas

## Docsify

- Sumar los plugins `search` (útil cuando haya más fichas), `pagination` (links a la ficha anterior y la siguiente) y `copy-code` (botón para copiar los bloques de código). Cada uno se agrega con un `<script>`.
- Completar `repo` en `index.html` con la URL del repositorio, así aparece el ícono de GitHub.
- El plugin casero de KaTeX también procesa el contenido de los bloques de código: un pseudocódigo con `$` se rompería. Hoy no pasa; si pasa, conviene usar `docsify-katex`.
- Los pseudocódigos del libro tienen sintaxis tipo C: etiquetarlos como `c` y cargar `prism-c` los resaltaría. Si no, se usa `text` en todas las fichas.

## Contenido visual y navegación

- Mostrar como tabla markdown el triángulo de Pascal (la tabla `B`) del Ejemplo 3.1, en la ficha de programación dinámica.
- Dibujar los árboles de espacio de estados de branch-and-bound con Mermaid (hay plugin para docsify), aunque sea un árbol chico.
- Agrupar el sidebar por libro o por unidad cuando haya fichas de otros libros.

## Para más adelante

- Un corrector ortográfico en español, como cspell con diccionario `es`.
