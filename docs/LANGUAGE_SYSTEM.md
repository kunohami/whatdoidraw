# Sistema de Idiomas y Localización (i18n) 🌐

Este documento detalla cómo está estructurado el sistema de idiomas en **whatdoidraw?**, cómo funciona la gestión del idioma del usuario y las etiquetas (tags), y cómo escalar la aplicación para soportar más idiomas en el futuro.

---

## 1. Localización Nativa de la App (UI)
La aplicación utiliza el paquete oficial `flutter_localizations` junto con `intl` para traducir la interfaz gráfica.

### ¿Cómo funciona el estado del idioma?
El idioma general de la aplicación está controlado por el provider **`AppLocale`** (`locale_provider.dart`).
- Al iniciar, detecta el idioma predeterminado del dispositivo (por ejemplo, si el sistema está en Español, selecciona `es`, de lo contrario, por defecto es `en`).
- Se puede cambiar en tiempo real desde la pantalla de **Ajustes** (`SettingsScreen`). Cuando el usuario selecciona un nuevo idioma, Riverpod actualiza el estado y `MaterialApp` se reconstruye automáticamente inyectando las nuevas traducciones en los Widgets.

### ¿Cómo añadir un nuevo idioma a la App?
Añadir un idioma adicional (ej. Francés) es un proceso estandarizado:

1. Crea un nuevo archivo en `lib/l10n/` llamado `app_fr.arb`.
2. Copia la estructura JSON de `app_en.arb` y traduce los valores:
   ```json
   {
     "@@locale": "fr",
     "settingsTitle": "Paramètres",
     "languageSetting": "Langue",
     "languageEnglish": "English",
     "languageSpanish": "Español"
   }
   ```
3. Ejecuta en la terminal el comando generador:
   ```bash
   flutter gen-l10n
   ```
4. Actualiza `main.dart` para soportar el nuevo idioma en `supportedLocales`:
   ```dart
   supportedLocales: const [
     Locale('en'),
     Locale('es'),
     Locale('fr'), // <--- Nuevo idioma
   ],
   ```
5. Actualiza la lista desplegable en `SettingsScreen` para que el usuario pueda seleccionarlo.

---

## 2. El Idioma en el Contenido (Ideas)
La base de datos de Supabase clasifica el contenido (Ideas) mediante el campo `language`.

- **Creación (`CreateIdeaScreen`)**: El usuario puede publicar su idea forzando que se etiquete como 'en' o 'es'. Por defecto, el `SegmentedButton` leerá el idioma del dispositivo y propondrá ese.
- **Filtro (`FeedScreen`)**: En la barra de navegación del Feed de Ideas, el botón global de idiomas permite filtrar instantáneamente el feed (cambiando la consulta a Supabase) para ver solo ideas en 'en', en 'es' o 'all'. El valor predeterminado al abrir la app coincide de nuevo con el idioma detectado en el dispositivo.

---

## 3. Idiomas y Etiquetas (Tags)
Las etiquetas de la aplicación **no se traducen automáticamente** ya que dependen del contexto cultural y la escritura de los propios usuarios (folksonomía).
- Si en un futuro se desea unificar, se recomienda realizar el *mapping* de tags genéricos en el backend, o sugerir tags internacionales durante la creación en el frontend.
- **Roadmap futuro**: Está prevista la implementación de una API de traducción automática para que los usuarios puedan pulsar un botón en el Feed y leer las Ideas extranjeras en su propio idioma local sin modificar los registros originales en base de datos.
