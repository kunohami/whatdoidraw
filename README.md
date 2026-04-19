# whatdoidraw? (wdid?) 🎨

Aplicación móvil nativa colaborativa diseñada para combatir el bloqueo creativo conectando a usuarios a través del proceso de inspiración. 

A diferencia de un portafolio tradicional o un generador de prompts aleatorio, **wdid?** documenta y visibiliza la evolución de una idea, creando un ciclo de feedback positivo.

## 🏗️ Flujo Principal de la Aplicación

El sistema se basa en 3 tipos de contenido principales que se inspiran mutuamente:

1. **Ideas (Prompts):** Texto simple generado por un usuario. Ej: "Un gato astronauta bebiendo café".
2. **Doodles (Bocetos):** Dibujos creados en el lienzo integrado. Pueden ser diseños completamente libres (sin enlazar a nada) o nacer como respuesta a una Idea previa.
3. **Artworks (Arte Final):** Obras terminadas publicadas en redes sociales. Para compartir un Artwork, el usuario debe seleccionar obligatoriamente una Idea o un Doodle que haya guardado previamente en su colección (Bookmarks). La app aloja una previsualización y enlaza al contenido original.

### 🔀 Flujo de Creación (Pestaña "Crear")
La pestaña de creación de la aplicación funcionará como un centro de distribución que presentará tres opciones principales:
- **Crear Idea:** Abre el formulario de texto.
- **Crear Doodle:** Abre el lienzo en blanco para un dibujo libre.
- **Compartir Artwork:** Redirige a una vista donde el usuario selecciona un contenido de su colección de elementos guardados (Ideas/Doodles de la comunidad) para vincularlo a su publicación externa.

## 🛠️ Stack Tecnológico
- **Frontend:** Flutter (Dart).
- **Backend/Base de Datos:** Supabase (PostgreSQL, Auth).
- **Gestión de Estado:** Riverpod (Notifier/AsyncNotifier).
- **Arquitectura:** MVVM Pragmático (Feature-Driven).

## 📁 Estructura del Proyecto Flutter

El proyecto sigue una organización por funcionalidades (**Features**) para facilitar la escalabilidad sin la sobrecarga de carpetas vacías de Clean Architecture.

```text
lib/
├── core/                       # Integraciones troncales y configuraciones
│   ├── providers/              # Proveedores globales (Supabase, etc.)
│   ├── theme/                  # Paletas de colores y estilos
│   └── constants/              
├── features/                   # División modular del proyecto por funcionalidad
│   └── [feature_name]/         # (ej: auth, feed, content_creation)
│       ├── services/           # Lógica de infraestructura y red (Supabase)
│       ├── viewmodels/         # Notifiers de Riverpod (Estado y Lógica de Negocio)
│       └── views/              # Interfaz de usuario (Screens y Widgets)
├── shared/                     # Código compartido y modelos de dominio
│   ├── models/                 # Modelos de datos únicos (Freezed + JSON)
│   └── widgets/                # UI reutilizable globalmente
└── main.dart                   
```


### Iteración 1: MVP y Backend Base ✅
- [x] Configurar Flutter y dependencias (Supabase, Riverpod).
- [x] Implementar autenticación (Registro/Login).
- [x] Crear formulario para publicar un prompt de texto (Idea).
- [x] Feed simple que muestra todas las Ideas.

### Iteración 2: El Motor de Dibujo y Arquitectura MVVM ✅
- [x] Transición total del esqueleto hacia Feature-Driven MVVM.
- [x] Motor de renderizado vectorial de dibujo construido desde cero (sin librerías).
- [x] Hub de Creación centralizado.
- [x] Funcionalidad para guardar y publicar un Doodle libre o enlazado a una Idea.
- [x] Pantalla de Perfil de Usuario con historial.

### Iteración 3: Feeds y Descubrimiento
- [x] Pantallas de descubrimiento completas (Tabs para Ideas, Doodles, Artworks).
- [x] Implementación de listas (`ListView`/`GridView`) para los feeds.
- [ ] Implementar un sistema de Etiquetas (Tags) aplicables a Ideas, Doodles y Artworks.
- [ ] Incorporar Filtros de búsqueda (por "Tags", "Top Ideas", "Recientes").
- [ ] Filtro automático de idioma: Auto-filtrar Ideas utilizando los tags `spanish` o `english` acorde al idioma del usuario (manteniendo opción de ver ambos).

### Iteración 4: Interacción Social y Artworks
- [ ] Sistema de Bookmarks (Guardar contenido) y visualización en el perfil.
- [ ] Formulario para publicar Artwork final (enlazando url externa).
- [ ] Lógica de filtrado por "popularidad" (Likes).

### Iteración 5: Internacionalización (i18n) y Pulido
- [ ] Soporte Bilingüe Nativo (Inglés y Español) en toda la UI de la aplicación.
- [ ] Implementar un Filtro de Profanidad (Profanity Filter) para bloquear la publicación de Ideas de texto con palabras prohibidas (en inglés y español).
- [ ] Sistema de reportes de usuarios/contenido ofensivo.
- [ ] Notificaciones push para avisar al creador original cuando su contenido se usa.
- [ ] Pruebas de usabilidad.