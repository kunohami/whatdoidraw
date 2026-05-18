# Sistema de Likes e Interacción Popular (Likes System) 💖

Este documento detalla la arquitectura, el flujo de datos y la interfaz de usuario implementados para soportar el sistema de **Likes** y la ordenación por popularidad de los feeds de Ideas, Doodles y Artworks en **whatdoidraw?**.

---

## 1. Diseño Base de Datos y Denormalización

Para evitar consultas relacionales extremadamente costosas ($N+1$) al listar feeds paginados, el sistema de likes implementa una **estrategia de denormalización con contadores locales** en las tablas principales de Supabase (`ideas`, `doodles`, `artworks`).

### Tablas e Índices
- **`likes`**: Tabla intermedia que asocia `user_id` con el elemento que recibe el like (`idea_id`, `doodle_id`, `artwork_id`). 
- **Restricciones de Unicidad**: Garantizan mediante constraints que un usuario solo pueda dar un único like a cada elemento individual.
- **Triggers en PostgreSQL**: Funciones automáticas (`update_likes_count()`) que incrementan o decrementan de forma atómica y segura el contador `likes_count` de la idea/doodle/artwork cuando un registro es insertado o eliminado en `likes`.

> [!NOTE]
> Para ver el código DDL y los Triggers de SQL exactos en Supabase, consulta [DATABASE_SCHEMA.md](file:///c:/Users/wissp/AndroidStudioProjects/whatdoidraw/docs/DATABASE_SCHEMA.md).

---

## 2. Arquitectura de Código (MVVM)

El sistema de likes se ha integrado de forma desacoplada siguiendo el patrón MVVM de la aplicación:

### Servicios (`lib/features/interaction/data/services/like_service.dart`)
Proporciona llamadas directas a Supabase para interactuar con la tabla `likes`:
- **`likeItem`**: Inserta una fila en la tabla de likes.
- **`unlikeItem`**: Elimina la fila correspondiente de la tabla de likes.
- **`isLiked`**: Comprueba de manera asíncrona si un usuario específico ya le ha dado like a un post en particular.

### Modelos y ViewModel (`lib/features/interaction/viewmodels/like_viewmodel.dart`)
Utiliza **Riverpod Generator** para implementar una lógica de **Optimistic UI (UI Optimista)**:
- Cuando el usuario pulsa en el botón del corazón, el `LikeNotifier` actualiza de forma instantánea el estado local del cliente (marcando el elemento como gustado e incrementando en `+1` el contador de likes en memoria).
- Inmediatamente después, dispara la petición a Supabase en segundo plano.
- Si la petición falla (por pérdida de conexión u otro error), el Notifier detecta el fallo, revierte de inmediato el contador a su estado original (`-1`) e informa del error para mantener la integridad de los datos visuales.

---

## 3. Integración en la Interfaz (UI)

Las tarjetas de los tres feeds principales han sido modificadas para incluir interacción en vivo:

1. **`IdeaCard`**, **`DoodleCard`** y **`ArtworkCard`**:
   - Escuchan el proveedor de estado `likeViewModel` para renderizar el icono de corazón relleno/vacío de manera dinámica.
   - El contador se incrementa o decrementa de forma fluida directamente al pulsar.
   - Utilizan micro-animaciones al alternar estados para mejorar la experiencia de usuario.

---

## 4. Ordenación por Popularidad en Feeds

Los feeds de la pestaña de Descubrimiento ahora cuentan con la opción de ordenación **"Más populares"** (o **"Most Popular"** en inglés):

- **Filtro del Feed (`FeedScreen`)**: La pestaña de filtros cuenta con un selector desplegable localizado para conmutar la ordenación.
- **Stable Sort (Ordenación Estable)**: Al ordenar por popularidad, la consulta a Supabase ordena primero por `likes_count` (descendente) y, como criterio de desempate secundario, por `created_at` (descendente). Esto asegura una ordenación estable que previene que los elementos cambien de posición de forma inconsistente durante la carga de páginas subsiguientes (paginación infinita).

---

## 5. Pruebas y Validación

El funcionamiento del sistema de likes y su ordenación ha sido verificado mediante tests integrales, garantizando:
- La correcta actualización del estado en la base de datos distribuida en Supabase.
- La consistencia del filtro "Más populares" ante diferentes volúmenes de interacciones concurrentes.
