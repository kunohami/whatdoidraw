# Roadmap de Desarrollo 🗺️

Este documento detalla el progreso actual y los planes futuros para **whatdoidraw?**.

## 🚦 Estado General
- **Backend**: 90% (Supabase integrado, Auth nativo configurado).
- **Frontend**: 80% (Lienzo funcional, Feeds con búsqueda y paginación implementados).
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

### Iteración 3: Feeds, Descubrimiento y Tags ✅
- [x] Pantallas de descubrimiento completas (Tabs para Ideas, Doodles, Artworks).
- [x] Implementación de listas (`ListView`/`GridView`) para los feeds.
- [x] **Sistema de Tags**: chips visuales en creación (Ideas y Doodles), máx. 5 tags, normalización automática.
- [x] **Filtros de búsqueda**: texto libre en Ideas + filtro por tags en Ideas y Doodles.
- [x] **Paginación**: botón "Ver más" con 15 ideas / 20 doodles por página.
- [x] **Ordenación**: modo cronológico (reciente) y modo aleatorio (shuffle en cliente).
- [ ] Filtro automático de idioma: Auto-filtrar Ideas con tags `spanish` / `english` según el idioma del usuario.

### Iteración 4: Interacción Social y Artworks
- [ ] Sistema de Bookmarks (Guardar contenido) y visualización en el perfil.
- [ ] Formulario para publicar Artwork final (enlazando url externa) con soporte de tags.
- [ ] Lógica de filtrado por "popularidad" (Likes).

### Iteración 5: Internacionalización (i18n) y Pulido Final
- [ ] Soporte Bilingüe Nativo (Inglés y Español) en toda la UI.
- [ ] Implementar un Filtro de Profanidad (Profanity Filter) para bloquear contenido ofensivo.
- [ ] Soporte de **Google Sign-In para Web** (Optimización GSI).
- [ ] Integración con **Discord Login** (OAuth2).
- [ ] Notificaciones push para avisar al creador original cuando su contenido se usa.
- [ ] Tags sugeridos y populares en el formulario de creación.
- [ ] Pruebas de usabilidad y lanzamiento.

---
*Última actualización: 26 de Abril de 2026*
