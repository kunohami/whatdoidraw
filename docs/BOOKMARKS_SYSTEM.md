# Sistema de Guardados (Bookmarks) 🔖

El sistema de guardados o *Bookmarks* permite a los usuarios recopilar contenido inspirador (Ideas y Doodles) para utilizarlo posteriormente en su proceso creativo.

## 🎯 Objetivo
El propósito principal de este sistema es fomentar la interacción y evitar la pérdida de contenido que al usuario le pareció interesante. En el flujo final, la creación de un **Artwork** (Arte Final) requerirá obligatoriamente basarse en una Idea o Doodle que el usuario haya guardado previamente en su colección.

## 🗄️ Modelo de Datos (Supabase)

La persistencia se gestiona en la tabla `bookmarks` de PostgreSQL, que actúa como una tabla de relación con múltiples claves foráneas opcionales (pero exclusivas por fila).

```sql
CREATE TABLE bookmarks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  idea_id UUID REFERENCES ideas(id) ON DELETE CASCADE,
  doodle_id UUID REFERENCES doodles(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  
  -- Restricciones de unicidad para evitar duplicados
  CONSTRAINT unique_bookmark_idea UNIQUE (user_id, idea_id),
  CONSTRAINT unique_bookmark_doodle UNIQUE (user_id, doodle_id)
);
```

### Seguridad por Filas (RLS)
El acceso a la tabla está protegido mediante *Row Level Security*. Un usuario solo puede insertar, ver y eliminar sus propios guardados:
- **Select**: `auth.uid() = user_id`
- **Insert**: `auth.uid() = user_id`
- **Delete**: `auth.uid() = user_id`

## 🏗️ Arquitectura en el Cliente (Flutter)

El sistema sigue la arquitectura MVVM impulsada por Riverpod.

### 1. `BookmarkService`
Servicio inyectado mediante `bookmarkServiceProvider`. Se comunica directamente con Supabase para consultar, insertar y borrar registros.
- `getUserBookmarkedIdeas()`
- `getUserBookmarkedDoodles()`
- `toggleIdeaBookmark(ideaId)`
- `toggleDoodleBookmark(doodleId)`

### 2. ViewModels (`bookmark_viewmodel.dart`)
Se utilizan generadores de código de Riverpod (`@riverpod`) para gestionar el estado asíncrono y evitar que la interfaz parpadee.

- **`BookmarkedIdeas`**: Notifier que contiene `AsyncValue<List<IdeaModel>>`.
- **`BookmarkedDoodles`**: Notifier que contiene `AsyncValue<List<DoodleModel>>`.

#### Actualización Optimista (Optimistic UI)
Para garantizar una experiencia fluida, cuando un usuario pulsa el icono de "Guardar", el estado del Notifier se actualiza inmediatamente añadiendo o quitando el elemento de la memoria local. Posteriormente, se envía la petición HTTP a Supabase. Si la petición falla, el Notifier revierte el estado a su versión anterior.

## 🖥️ Interfaz de Usuario (UI)

- **`BookmarksScreen`**: Se accede desde el Hub de creación. Contiene dos pestañas (Ideas y Doodles) que escuchan directamente a los ViewModels mencionados.
- **`IdeaCard` y `DoodleCard`**: Escuchan (`ref.watch`) el estado del ViewModel para saber si el ítem que están renderizando está en la lista de guardados y pintar el icono relleno (`Icons.bookmark`) o vacío (`Icons.bookmark_border`).
