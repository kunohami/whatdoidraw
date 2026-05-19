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
- [x] **Filtro de idioma**: Auto-filtrar Ideas según el idioma del usuario y permitir selección en creación.

### Iteración 4: Interacción Social y Artworks ✅
- [x] Sistema de Bookmarks (Guardar contenido) y visualización en el perfil.
- [x] Formulario para publicar Artwork final (enlazando url externa) con soporte de tags y multi-plataforma.
- [x] Lógica de filtrado por "popularidad" (Likes) y visualización de likes.
- [x] Sistema para ver relación con otras ideas o doodles existentes en la app al abrir una idea o doodle.
- [x] Mostrar el nombre del usuario al que pertenece la idea o doodle.
- [ ] Poder ver perfiles de otros usuarios al hacer click en su usuario
- [ ] Buscador de perfiles de usuario en la pestaña de perfil

### Iteración 5: Internacionalización (i18n) y Pulido Final
- [x] Soporte Bilingüe Nativo (Inglés y Español) en toda la UI.
- [ ] Implementar un Profanity Filter para bloquear contenido ofensivo.
- [ ] Soporte de **Google Sign-In para Web** (Optimización GSI).
- [ ] Integración con **Discord Login** (OAuth2).
- [ ] Notificaciones push para avisar al creador original cuando su contenido se usa.
- [ ] Tags sugeridos y populares en el formulario de creación.
- [ ] Traducción automática de Ideas usando una API externa.
- [ ] Pruebas de usabilidad y lanzamiento.
- [ ] Sistema de notificaciones por correo cada vez que alguien haga un artwork final de tu idea o doodle.

---
*Última actualización: 7 de Mayo de 2026*
