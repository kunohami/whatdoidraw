# Sistema de Tags 🏷️

Este documento describe el diseño, comportamiento y estructura técnica del sistema de etiquetas (tags) de **whatdoidraw?**.

---

## ¿Qué son los tags?

Los tags son etiquetas cortas de texto libre que los usuarios asignan a su contenido (Ideas y Doodles) para categorizarlo y facilitar su descubrimiento. Se muestran como chips visuales tanto en los formularios de creación como en las tarjetas del feed.

---

## Reglas de negocio

| Propiedad | Valor |
|---|---|
| Máximo de tags por item | **5** |
| Longitud mínima | 1 carácter (después de normalizar) |
| Longitud máxima | Sin límite explícito, recomendado < 30 caracteres |
| Caracteres permitidos | Alfanuméricos y guión medio (`a-z`, `0-9`, `-`) |
| Normalización | Minúsculas, sin espacios, sin caracteres especiales |
| Duplicados | Ignorados automáticamente (no se añade un tag que ya existe) |

La normalización se aplica en cliente en el momento en que el tag se confirma, antes de enviarlo a la base de datos.

---

## Cómo se introducen (UI de creación)

El componente clave es `TagInputField` (`lib/shared/widgets/tag_input_field.dart`).

### Comportamiento del `TagInputField`

1. El usuario escribe un texto en el campo de entrada.
2. Al pulsar **espacio**, **coma** (`,`) o **intro** (`↵`), el texto se convierte en un chip visual.
3. Cada chip muestra el tag con el prefijo `#` y un botón `×` para eliminarlo.
4. Cuando se alcanzan los 5 tags, el campo de texto desaparece y aparece el aviso _"Límite de 5 etiquetas alcanzado"_.
5. El componente expone los cambios vía el callback `onTagsChanged(List<String>)`.

### Dónde se usa

| Pantalla | Cuándo aparece |
|---|---|
| `CreateIdeaScreen` | Debajo del campo de texto de la idea, antes del botón "Enviar Idea" |
| `DoodleCanvasScreen` | Dentro del **BottomSheet de publicación** que aparece al pulsar "PUBLICAR" |

> [!NOTE]
> En el canvas de doodle, el `TagInputField` no bloquea el flujo de dibujo. El usuario dibuja primero y, solo al pulsar PUBLICAR, se le presenta el BottomSheet donde puede añadir tags opcionalmente antes de confirmar el envío.

---

## Cómo se almacenan (Base de datos)

Los tags se guardan en columnas de tipo `VARCHAR[]` (array de PostgreSQL) en las siguientes tablas:

```sql
-- En la tabla ideas
tags VARCHAR[]

-- En la tabla doodles
tags VARCHAR[]

-- En la tabla artworks (preparado, no implementado aún)
tags VARCHAR[]
```

Solo se incluyen en el payload de inserción si la lista no está vacía (optimización de escritura):

```dart
// content_creation_service.dart
if (tags.isNotEmpty) 'tags': tags,
```

---

## Cómo se muestran (Feed)

El componente `TagChip` (`lib/shared/widgets/tag_chip.dart`) es la unidad visual de solo-lectura para el feed.

- En `IdeaCard`: los tags aparecen como un `Wrap` de chips debajo del texto de la idea.
- En `DoodleCard`: los tags aparecen como un overlay con gradiente semitransparente en la parte inferior de la miniatura del dibujo (máximo 3 chips visibles para no saturar la tarjeta de la cuadrícula).

Un `TagChip` puede estar en dos estados:
- **Normal**: fondo gris claro, texto gris.
- **Activo**: fondo con el color primario del tema, texto en blanco. Se activa cuando ese tag coincide con un filtro seleccionado en el feed.

Al pulsar un `TagChip` en el feed, se llama al método `toggleTag(tag)` del notifier correspondiente, que filtra el feed completo por ese tag.

---

## Cómo funciona el filtrado y la búsqueda en el Feed

El sistema de feed ha sido rediseñado para soportar paginación, búsqueda y filtros combinados.

### Arquitectura del Feed

| Componente | Tipo | Responsabilidad |
|---|---|---|
| `IdeasFeedNotifier` | `@riverpod Notifier` | Estado del feed de Ideas (lista, filtros, paginación) |
| `DoodlesFeedNotifier` | `@riverpod Notifier` | Estado del feed de Doodles |
| `FeedService` | Clase de servicio | Queries a Supabase con filtros y paginación |

> [!IMPORTANT]
> Los feeds ya **no usan streams en tiempo real** (`.stream()`). Se usan queries paginadas estándar (`.select().range()`) para controlar el consumo de consultas a Supabase. Un botón de **Refresh** permite recargar manualmente.

### Parámetros de paginación

```dart
// lib/core/constants/feed_constants.dart
const int kIdeasPageSize   = 15;
const int kDoodlesPageSize = 20;
const int kRandomFetchSize = 60; // Lote para modo aleatorio
```

### Modos de búsqueda por pestaña

| Pestaña | Búsqueda por texto | Filtro por tags |
|---|---|---|
| **Ideas** | ✅ (`ilike` en columna `content`) | ✅ (`contains` en columna `tags`) |
| **Doodles** | ❌ | ✅ (`contains` en columna `tags`) |
| **Artworks** | ❌ (pendiente) | ❌ (pendiente) |

La búsqueda de texto en Ideas usa un **debounce de 400 ms** para no lanzar una query por cada tecla pulsada.

### Modos de ordenación

Se puede alternar con el botón 📅/🔀 de la AppBar del feed:

| Modo | Comportamiento |
|---|---|
| `recent` (por defecto) | `.order('created_at', ascending: false)` + paginación secuencial |
| `random` | Fetch de `kRandomFetchSize` items y `shuffle()` en cliente. El botón "Ver más" se convierte en "Barajar de nuevo" |

### Flujo de interacción con tags en el Feed

```
Usuario pulsa un TagChip en una tarjeta
        ↓
notifier.toggleTag(tag)
        ↓
Si el tag estaba activo → se elimina del filtro
Si el tag no estaba activo → se añade al filtro
        ↓
loadInitial() → query a Supabase con .contains('tags', selectedTags)
        ↓
Feed se actualiza mostrando solo contenido con ese(os) tag(s)
        ↓
Los chips activos aparecen en la barra de filtros bajo la SearchBar
        ↓
Botón "Limpiar" → clearFilters() → vuelve al estado sin filtros
```

---

## Estado del estado (ViewModel)

### `IdeasFeedState`

```dart
class IdeasFeedState {
  final List<IdeaModel> ideas;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;
  final String searchQuery;       // Texto de búsqueda libre
  final List<String> selectedTags; // Tags activos como filtro
  final FeedSortOrder sortOrder;   // recent | random
  final String? errorMessage;
}
```

### `DoodleCanvasState` (ampliado)

```dart
// doodle_canvas_viewmodel.dart
@freezed
abstract class DoodleCanvasState with _$DoodleCanvasState {
  const factory DoodleCanvasState({
    @Default([]) List<StrokeModel> strokes,
    @Default([]) List<String> tags,    // ← NUEVO
    @Default(false) bool isSubmitting,
    String? errorMessage,
  }) = _DoodleCanvasState;
}
```

---

## Pendiente / Próximas mejoras

- [ ] **Artworks**: añadir `TagInputField` al formulario de publicación de Artwork.
- [ ] **Filtro de idioma automático**: usar los tags `spanish` / `english` para auto-filtrar el feed según el idioma del dispositivo.
- [ ] **Tags sugeridos**: mostrar un conjunto de tags predefinidos y populares como sugerencias al usuario.
- [ ] **Búsqueda de Doodles por texto** (descripción libre) si se añade una columna `description` en el futuro.
- [ ] **Paginación real aleatoria**: implementar función RPC de Postgres `ORDER BY RANDOM()` para aleatorio verdadero con paginación.

---

*Última actualización: 26 de Abril de 2026*
