# Sistema de Idiomas y Localización (i18n) 🌐

Este documento detalla cómo está estructurado el sistema de idiomas en **whatdoidraw?**, cómo funciona la gestión del idioma del usuario y las etiquetas (tags), y cómo escalar la aplicación para soportar más idiomas en el futuro.

---

## 1. Localización Nativa de la App (UI)
La aplicación utiliza el paquete oficial `flutter_localizations` junto con `intl` para traducir la interfaz gráfica.

### ¿Cómo funciona el estado del idioma y la persistencia?
El idioma general de la aplicación está controlado por el provider **`AppLocale`** (`locale_provider.dart`), el cual implementa **persistencia a nivel de dispositivo** usando la librería `shared_preferences`.

- **Al iniciar la App**: El notifier accede de forma síncrona a `sharedPreferencesProvider` (inicializado y sobreescrito en el root `ProviderScope` en `main.dart`). Si existe un código de idioma guardado bajo la clave `'app_locale'`, se carga de inmediato. Si no hay registros previos, detecta automáticamente el idioma nativo del dispositivo (si empieza por `es` selecciona Español `es`, de lo contrario usará Inglés `en`).
- **En tiempo real**: Se puede cambiar el idioma desde la pantalla de **Ajustes** (`SettingsScreen`). Cuando el usuario selecciona una nueva opción del menú desplegable:
  1. Se invoca `setLocale(locale)` en el notifier de `appLocaleProvider`.
  2. El nuevo idioma se guarda de forma persistente en local storage con `sharedPreferences.setString('app_locale', locale.languageCode)`.
  3. El estado del provider se actualiza y `MaterialApp` se reconstruye instantáneamente en toda la aplicación con las traducciones correspondientes.

### Pruebas del Sistema de Idiomas
El sistema cuenta con cobertura automatizada completa y robusta:
- **`settings_locale_test.dart`**: Verifica que cambiar el idioma a través del dropdown de Ajustes refresca al instante los textos en pantalla (`Settings` -> `Ajustes`, etc.) inyectando un mock de `SharedPreferences`.
- **`app_persistence_locale_test.dart`**: Prueba unitaria que simula el ciclo de vida de reinicios de la aplicación para certificar que el idioma guardado se recupera correctamente del almacenamiento local en lugar de volver al valor por defecto.
- **`widget_test.dart`**: Prueba de humo general que incluye la inyección del mock para asegurar la correcta instanciación de la App.

Para ejecutar los tests de localización, puedes usar el comando:
```bash
flutter test test/features/settings_locale_test.dart test/features/app_persistence_locale_test.dart
```

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
