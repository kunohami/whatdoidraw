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
- **Arquitectura:** Feature-Driven MVVM.

## 📁 Estructura del Proyecto Flutter

```text
lib/
├── core/                       # Integraciones troncales y configuraciones
│   ├── providers/              # Proveedores globales (Supabase, etc.)
│   ├── theme/                  # Paletas de colores
│   └── constants/              
├── features/                   # División modular del proyecto
│   └── [feature_name]/         # (ej: auth, feed, content_creation)
│       ├── services/           # Conectividad directa (Supabase, APIs)
│       ├── viewmodels/         # Riverpod Notifiers (Estado reactivo)
│       └── views/              # Interfaz de usuario
│           ├── screens/        # Vistas completas
│           └── widgets/        # Componentes locales
├── shared/                     # Código compartido entre features
│   ├── models/                 # Modelos de datos únicos (Freezed)
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
- [ ] Pantalla de Perfil de Usuario con historial (Pendiente).

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