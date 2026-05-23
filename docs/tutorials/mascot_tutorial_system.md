# Sistema de Tutoriales y Animación Stop-Motion de la Mascota

Este documento detalla el funcionamiento del sistema de tutoriales guiados y la animación de la mascota implementados en la aplicación. Este diseño ha sido concebido para ser altamente interactivo, de alto rendimiento y fácil de ampliar en el futuro.

---

## 1. Animación Stop-Motion Jitter de la Mascota

La mascota de la aplicación posee un efecto animado de "vibración de trazo" o *boiling lines* (líneas hirvientes). Este efecto simula la estética clásica de la animación tradicional dibujada a mano, donde cada fotograma tiene ligeras variaciones de grosor y contorno, incluso cuando el personaje permanece quieto.

### Implementación Técnica (`MascotJitterWidget`)
El widget principal encargado de este efecto reside en `lib/shared/widgets/mascot_jitter_widget.dart`.
Para lograr el efecto stop-motion usando **una sola imagen estática PNG**, el widget aplica transformaciones de matriz 2D aleatorias de forma periódica:

1. **Bucle de tiempo (Timer)**: Ejecuta una actualización de estado a una tasa de refresco clásica de stop-motion: **6 FPS** (cada 160 ms).
2. **Transformaciones matemáticas**:
   - **Rotación**: Una rotación infinitesimal aleatoria entre `-0.015` y `+0.015` radianes.
   - **Traslación**: Desplazamientos imperceptibles en los ejes X e Y entre `-1.5` y `+1.5` píxeles.
   - **Escala**: Una ligera distorsión de escala entre `0.985` y `1.015` para simular estiramiento físico.
3. **Optimización de Rendimiento**:
   - Usa `Transform` con `FilterQuality.medium` para evitar difuminados en las redibujadas rápidas.
   - Cancela y limpia los timers automáticamente en `dispose` para evitar fugas de memoria (*memory leaks*).

### Cómo ampliarlo en el futuro (Múltiples Fotogramas)
El widget está preparado para cambiar el parámetro `imagePath` de forma dinámica. En el futuro, si decides exportar varios fotogramas de Clip Studio Paint (ej. `mascot_talking_1.png`, `mascot_talking_2.png`), solo tienes que actualizar el `imagePath` en cada paso del tutorial.

---

## 2. Bocadillo de Diálogo y Flujo (`TutorialOverlay`)

El sistema de tutoriales se implementa de manera declarativa con el widget `TutorialOverlay` (`lib/shared/widgets/tutorial_overlay.dart`).

### Estética Premium y UX:
- **Oscurecimiento de Fondo**: El fondo de la aplicación se oscurece con un color negro translúcido (`Colors.black.withValues(alpha: 0.75)`) para forzar el foco de atención en las palabras de la mascota.
- **Bocadillo de Diálogo**: Centrado verticalmente, optimizado para albergar explicaciones largas y complejas. Cuenta con una colita triangular que apunta de forma elegante a la mascota de la esquina inferior derecha.
- **Ubicación de la Mascota**: Ubicada de forma no invasiva abajo a la derecha (`Alignment.bottomRight`), con el efecto de jitter stop-motion activo para darle vida.
- **Botón de Cierre "X"**: Ubicado sutilmente arriba a la derecha del overlay para que los usuarios experimentados puedan saltarse la explicación en cualquier momento.

### Métodos de Conveniencia:
El widget proporciona métodos estáticos limpios para lanzar ayudas específicas de forma directa:

```dart
// 1. Mostrar tutorial de bienvenida de login
TutorialOverlay.showGeneral(context, l10n);

// 2. Mostrar ayuda contextual en el Feed según la pestaña activa
TutorialOverlay.showFeedInfo(context, l10n, activeTabIndex);

// 3. Mostrar ayuda en el hub o pantallas de creación
TutorialOverlay.showCreationHubInfo(context, l10n);
TutorialOverlay.showCreateIdeaInfo(context, l10n);
TutorialOverlay.showDoodleCanvasInfo(context, l10n);
```

---

## 3. Integración en Pantallas

### A. Login e Inicio Automático (`MainNavigationScreen`)
- Al iniciar la aplicación y verificar la sesión, la navegación general lee de `SharedPreferences` la clave `hasSeenGeneralTutorial`.
- Si es `false` (usuario nuevo o reinstalación), activa un *post-frame callback* que lanza el tutorial general y guarda el flag a `true` inmediatamente (evitando que aparezca de nuevo en el siguiente inicio).

### B. Repetición desde Ajustes (`SettingsScreen`)
- Se ha añadido una sección de "Ayuda y Soporte" con un botón de play para revivir el tutorial de onboarding general en cualquier momento.

### C. Iconos de Información Contextual
Se han añadido botones de información (`Icons.info_outline`) en los `AppBar` de las siguientes secciones:
1. **Explorar (Feed)**: La mascota explica la pestaña seleccionada actualmente (**Ideas, Doodles o Artworks**), instruyendo qué puede hacer el usuario y qué valor aporta su contribución a la genealogía creativa.
2. **Crear (Creation Hub)**: Explica las ramificaciones creativas disponibles.
3. **Crear Idea**: Explica cómo redactar y etiquetar propuestas para inspirar a otros.
4. **Lienzo de Dibujo (Doodle Canvas)**: Detalla cómo usar las herramientas de dibujo vectorial y qué ocurre con los bocetos al ser publicados.

---

## 4. Gestión de Traducciones (Localización)

Todas las descripciones y diálogos de la mascota están programados utilizando ficheros de recursos estándar de Flutter L10n (`app_es.arb` y `app_en.arb`), asegurando un soporte nativo perfecto tanto en **Español** como en **English**.
