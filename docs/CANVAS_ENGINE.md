# Motor de Dibujo (Doodle Canvas Engine) 🖌️

El lienzo de dibujo de **whatdoidraw?** es un motor 2D vectorial construido completamente desde cero usando las herramientas nativas de Flutter. No depende de paquetes de terceros (como `signature` o `painter`), lo que nos otorga control total sobre la serialización, el rendimiento y la interacción.

## 🏗️ Arquitectura Básica

El motor se compone de tres piezas fundamentales:
1.  **El Modelo (`StrokeModel`)**: Define cómo se estructura la información de los trazos en memoria y en la base de datos.
2.  **El ViewModel (`DoodleCanvasNotifier`)**: Gestiona la lógica de estado (trazos actuales, color activo, grosor, operaciones de deshacer/limpiar).
3.  **La Vista (`DoodlePainter` y `GestureDetector`)**: Se encarga de capturar las interacciones del usuario y renderizar los modelos en pantalla.

---

## 1. El Modelo de Datos (`StrokeModel`)

Un dibujo no es una imagen estática (como un PNG o JPG), sino una colección matemática de trazos (vectores). 

```dart
class StrokeModel {
  final List<Offset> points; // Lista de coordenadas (x, y)
  final Color color;         // Color del trazo
  final double strokeWidth;  // Grosor de la línea
}
```

**Por qué vectores en lugar de píxeles:**
- Ocupan muchísimo menos espacio en base de datos al guardar (solo coordenadas JSON vs un Blob de imagen).
- Se renderizan de forma nítida a cualquier resolución y nivel de zoom.
- Permite operaciones avanzadas (como *deshacer* trazo a trazo, o en un futuro: borrar vectores individuales, animar la creación del dibujo, etc.).

---

## 2. Captura de Interacciones (`GestureDetector`)

Para que el usuario pueda dibujar, envolvemos el lienzo en un `GestureDetector` configurado específicamente para capturar eventos de arrastre (*Pan*):

*   `onPanStart`: El usuario toca la pantalla. Creamos un nuevo `StrokeModel` vacío con el color y grosor actualmente seleccionados en el ViewModel, y añadimos el primer punto (`Offset`).
*   `onPanUpdate`: El usuario arrastra el dedo. Capturamos la posición local (relativa al lienzo) y añadimos nuevos puntos (`Offset`) al trazo activo.
*   `onPanEnd`: El usuario levanta el dedo. El trazo finaliza.

---

## 3. Renderizado Gráfico (`DoodlePainter`)

Flutter proporciona un `CustomPainter` que interactúa de manera muy directa con el motor gráfico (Skia/Impeller).

El `DoodlePainter` recibe la lista de `StrokeModel` y ejecuta lo siguiente en cada ciclo (frame) de pintado:

1.  Crea un objeto `Paint` configurado con el `color`, `strokeWidth` y `StrokeCap.round` (para que las líneas tengan bordes suaves).
2.  Construye un objeto `Path` iterando sobre la lista de puntos del trazo.
    *   Usa `path.moveTo` para el primer punto.
    *   Usa `path.lineTo` para el resto de puntos.
3.  Llama a `canvas.drawPath(path, paint)` para pintar físicamente la línea en la pantalla.

> **Nota de optimización**: Dado que dibujar puntos sueltos puede generar líneas "dentadas" (angulosas) si el dedo se mueve rápido, el `Path` permite futuras mejoras mediante curvas de Bezier (interpolación cuadrática o cúbica) entre los puntos recolectados.

---

## 4. Zoom y Desplazamiento (`InteractiveViewer`)

Para permitir trabajar en detalle, el lienzo principal de dibujo se envuelve en un `InteractiveViewer`.
Sin embargo, esto crea un conflicto: arrastrar el dedo ¿debería dibujar o desplazar la pantalla (*Pan*)?

**La Solución:**
El lienzo está restringido, y la herramienta principal siempre dibuja. Si el usuario desea hacer Zoom, utiliza el clásico *Pinch-to-zoom* (dos dedos). 

En el modo vista (`DoodleDetailScreen`), donde no existe el `GestureDetector` que intercepta los toques para dibujar, el `InteractiveViewer` asume el control total, permitiendo moverse libremente por el dibujo terminado con un solo dedo.

---

## 5. Serialización (Supabase)

Cuando el usuario publica el Doodle, el `DoodleCanvasNotifier` convierte la lista completa de `StrokeModel` a un formato `JSON`. 

Cada `Offset` de Flutter se traduce a un mapa `{'x': valor, 'y': valor}`, y el color se guarda en su representación hexadecimal (o entero). Este array JSON se envía a la columna `doodle_data` de la base de datos Supabase, garantizando que el almacenamiento sea extremadamente ligero en kilobytes.
