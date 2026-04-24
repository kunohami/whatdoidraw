# Roadmap de Desarrollo 🗺️

Este documento detalla el progreso actual y los planes futuros para **whatdoidraw?**.

## 🚦 Estado General
- **Backend**: 90% (Supabase integrado, Auth nativo configurado).
- **Frontend**: 70% (Lienzo funcional, Feeds en progreso).
- **Diseño**: 80% (Sistema de diseño MVVM establecido).

---

### Iteración 1: MVP y Backend Base ✅
- [x] Configurar Flutter y dependencias (Supabase, Riverpod).
- [x] Implementar autenticación robusta (Email/Password).
- [x] Integración nativa con **Google Sign-In** (Android).
- [x] Crear formulario para publicar un prompt de texto (Idea).
- [x] Feed simple que muestra todas las Ideas.

### Iteración 2: El Motor de Dibujo y Arquitectura MVVM ✅
- [x] Transición total del esqueleto hacia Feature-Driven MVVM.
- [x] Motor de renderizado vectorial de dibujo construido desde cero (sin librerías).
- [x] Hub de Creación centralizado.
- [x] Funcionalidad para guardar y publicar un Doodle libre o enlazado a una Idea.
- [x] Pantalla de Perfil de Usuario con historial y Logout.

### Iteración 3: Feeds y Descubrimiento 🏗️
- [x] Pantallas de descubrimiento completas (Tabs para Ideas, Doodles, Artworks).
- [x] Implementación de listas (`ListView`/`GridView`) para los feeds.
- [ ] Implementar un sistema de Etiquetas (Tags) aplicables a Ideas, Doodles y Artworks.
- [ ] Incorporar Filtros de búsqueda (por "Tags", "Top Ideas", "Recientes").
- [ ] Filtro automático de idioma: Auto-filtrar Ideas utilizando los tags `spanish` o `english` acorde al idioma del usuario.

### Iteración 4: Interacción Social y Artworks
- [ ] Sistema de Bookmarks (Guardar contenido) y visualización en el perfil.
- [ ] Formulario para publicar Artwork final (enlazando url externa).
- [ ] Lógica de filtrado por "popularidad" (Likes).

### Iteración 5: Internacionalización (i18n) y Pulido Final
- [ ] Soporte Bilingüe Nativo (Inglés y Español) en toda la UI.
- [ ] Implementar un Filtro de Profanidad (Profanity Filter) para bloquear contenido ofensivo.
- [ ] Soporte de **Google Sign-In para Web** (Optimización GSI).
- [ ] Integración con **Discord Login** (OAuth2).
- [ ] Notificaciones push para avisar al creador original cuando su contenido se usa.
- [ ] Pruebas de usabilidad y lanzamiento.

---
*Última actualización: 24 de Abril de 2026*
