# whatdoidraw? (wdid?) 🎨

**whatdoidraw?** es una aplicación colaborativa diseñada para combatir el bloqueo creativo conectando a usuarios a través del proceso de inspiración y creación.

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=flat&logo=supabase&logoColor=white)](https://supabase.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Características Principales
- **Generación de Ideas**: Publica y descubre prompts creativos con etiquetas.
- **Lienzo de Dibujo Nativo**: Dibuja bocetos (Doodles) directamente en la app sin librerías externas.
- **Ciclo de Inspiración**: Crea dibujos basados en ideas de otros usuarios o comparte tu arte final.
- **Feed Inteligente**: Descubre contenido con búsqueda por texto, filtrado por tags y paginación.
- **Multiplataforma**: Disponible para Android y Web.

## 📖 Documentación
- 🎨 **[Visión General del Proyecto](docs/PROJECT_OVERVIEW.md)**: Flujos de usuario, lógica de contenido y estructura de carpetas.
- 🏷️ **[Sistema de Tags](docs/TAGS_SYSTEM.md)**: Cómo funcionan las etiquetas, la búsqueda y el filtrado del feed.
- 💖 **[Sistema de Likes e Interacción](docs/LIKES_SYSTEM.md)**: Estructura del contador optimista, servicio Supabase y ordenación estable por popularidad.
- 🌐 **[Sistema de Idiomas e i18n](docs/LANGUAGE_SYSTEM.md)**: Localización de pantallas, persistencia local con SharedPreferences y pruebas de idioma.
- 🗄️ **[Esquema de Base de Datos](docs/DATABASE_SCHEMA.md)**: Tablas, relaciones y políticas RLS de Supabase.
- 🗺️ **[Roadmap de Desarrollo](ROADMAP.md)**: Estado actual del proyecto y tareas pendientes.

## 🚀 Inicio Rápido

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/kunohami/whatdoidraw.git
   ```
2. **Instalar dependencias**:
   ```bash
   flutter pub get
   ```
3. **Configurar variables de entorno**: Crea un fichero `.env` en la raíz con tus credenciales de Supabase:
   ```
   SUPABASE_URL=https://tu-proyecto.supabase.co
   SUPABASE_ANON_KEY=tu-anon-key
   ```
4. **Ejecutar la aplicación**:
   ```bash
   flutter run
   ```
