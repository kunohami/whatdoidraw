# Visión General del Proyecto 🎨

**whatdoidraw? (wdid?)** es una aplicación colaborativa diseñada para combatir el bloqueo creativo conectando a usuarios a través del proceso de inspiración. 

A diferencia de un portafolio tradicional o un generador de prompts aleatorio, **wdid?** documenta y visibiliza la evolución de una idea, creando un ciclo de feedback positivo.

## 🏗️ Lógica de Contenido

El sistema se basa en 3 tipos de contenido principales que se inspiran mutuamente:

1. **Ideas (Prompts):** Texto simple generado por un usuario. Ej: "Un gato astronauta bebiendo café".
2. **Doodles (Bocetos):** Dibujos creados en el lienzo integrado. Pueden ser diseños completamente libres o nacer como respuesta a una Idea previa.
3. **Artworks (Arte Final):** Obras terminadas publicadas en redes sociales. Para compartir un Artwork, el usuario debe seleccionar obligatoriamente una Idea o un Doodle que haya guardado previamente en su colección. La app aloja una previsualización y enlaza al contenido original.

### 🔀 Flujo de Uso
La aplicación tiene un Hub central de creación y un sistema de descubrimiento social:
- **Descubrir:** Navegar por los Feeds de Ideas y Doodles.
- **Guardar (Bookmarks):** Los usuarios pueden guardar Ideas y Doodles en su colección personal para usarlos de inspiración más tarde.
- **Interactuar (Likes):** Los usuarios pueden dar like a las Ideas, Doodles y Artworks, y ordenar los feeds por popularidad para descubrir las creaciones más destacadas.
- **Crear Idea:** Formulario de texto.
- **Crear Doodle:** Lienzo de dibujo libre, opcionalmente basado en una Idea.
- **Compartir Artwork:** Formulario final que asocia un enlace externo con una Idea o Doodle guardado previamente.

## 🛠️ Stack Tecnológico
- **Frontend:** Flutter (Dart).
- **Backend:** Supabase (PostgreSQL, Auth, Storage).
- **Estado:** Riverpod (Arquitectura reactiva).
- **Arquitectura:** MVVM Pragmático (Feature-Driven).

## 📁 Arquitectura del Código

El proyecto sigue una organización por funcionalidades (**Features**):

```text
lib/
├── core/                       # Integraciones troncales y configuraciones
│   ├── providers/              # Proveedores globales (Supabase, etc.)
│   ├── theme/                  # Sistema de diseño (colores, tipografía)
│   └── constants/              
├── features/                   # Módulos por funcionalidad
│   └── [feature_name]/         
│       ├── services/           # Infraestructura (Supabase)
│       ├── viewmodels/         # Riverpod Notifiers (Lógica de negocio)
│       └── views/              # UI (Screens y Widgets)
├── shared/                     # Código compartido y modelos
│   ├── models/                 # Modelos de dominio (Freezed)
│   └── widgets/                # UI reutilizable
└── main.dart                   
```

---
*Para ver el estado de las tareas, consulta el [ROADMAP.md](../ROADMAP.md).*
