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
- **Gestión de Estado:** Riverpod.
- **Arquitectura:** Feature-first.

## 📁 Estructura del Proyecto Flutter

```text
lib/
│
├── core/                   # Configuraciones globales y utilidades
│   ├── constants/          # Colores, tamaños, estilos de texto
│   ├── theme/              # Configuración del ThemeData
│   └── utils/              # Funciones de ayuda 
│
├── shared/                 # Componentes UI reutilizables
│   ├── widgets/            # Botones, avatares, modales
│   └── models/             # Clases base
│
├── features/               # Módulos principales de la aplicación
│   ├── auth/               # Pantallas y lógica de Login/Registro
│   ├── feed/               # Listas de descubrimiento
│   ├── content_creation/   # Formularios de Ideas y el Canvas para Doodles
│   ├── profile/            # Perfil de usuario y bookmarks
│   └── interaction/        # Lógica de Likes, Bookmarks y Reportes
│
└── main.dart               # Punto de entrada de la aplicación
```


### Iteración 1: MVP y Backend Base ✅
- [x] Configurar Flutter y dependencias (Supabase, Riverpod).
- [x] Implementar autenticación (Registro/Login).
- [x] Crear formulario para publicar un prompt de texto (Idea).
- [x] Feed simple que muestra todas las Ideas.

### Iteración 2: Perfiles y Lienzo de Dibujo 🔄 [EN PROGRESO]
- [ ] Pantalla de Perfil de Usuario con historial.
- [/] Implementación del `DrawingView` (lienzo con librería scribble).
- [ ] Funcionalidad para guardar y publicar un Doodle vinculado a una Idea.

### Iteración 3: Feeds y Descubrimiento
- [ ] Pantallas de descubrimiento completas (Tabs para Ideas, Doodles, Artworks).
- [ ] Implementación de listas (`ListView`/`GridView`) para los feeds.
- [ ] Filtros ("Top Ideas", "Random", "Recientes").

### Iteración 4: Interacción Social y Artworks
- [ ] Sistema de Bookmarks (Guardar contenido) y visualización en el perfil.
- [ ] Formulario para publicar Artwork final (enlazando url externa).
- [ ] Lógica de filtrado por "popularidad" (Likes).

### Iteración 5: Pulido y Notificaciones
- [ ] Sistema de reportes de usuarios/contenido.
- [ ] (Opcional) Notificaciones push para avisar al creador original cuando su contenido se usa.
- [ ] Pruebas de usabilidad.