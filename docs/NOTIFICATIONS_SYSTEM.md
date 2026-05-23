# Sistema de Notificaciones (In-App y Push)

Este documento explica de forma detallada el funcionamiento, la arquitectura y el flujo de datos del sistema de notificaciones de **whatdoidraw?**, abarcando desde la base de datos hasta la recepción en dispositivos móviles.

---

## 1. Arquitectura General y Flujo de Datos

El sistema de notificaciones está diseñado bajo un modelo reactivo e impulsado por eventos (*event-driven*), garantizando que las notificaciones se procesen en segundo plano sin ralentizar la experiencia de los creadores en la aplicación.

El flujo completo se visualiza en el siguiente diagrama:

```
[Usuario A] (Crea Doodle/Artwork basado en Idea/Doodle del Usuario B)
      │
      ▼
[Base de Datos (Supabase)]
      │
      ├─► [TRIGGER SQL] ──► Inserta en tabla `notifications` (In-App UI)
      │                                 │
      │                                 ▼
      └─────────────────────► [DATABASE WEBHOOK]
                                        │
                                        ▼ (POST Payload)
                             [Supabase Edge Function] (`send-push`)
                                        │
                                        ├─► Lee `fcm_token` y preferencias del Usuario B
                                        ├─► Autentica con Firebase (OAuth2 Service Account)
                                        ▼
                             [Firebase Cloud Messaging (FCM)]
                                        │
                                        ▼ (Push Notification)
                              [Dispositivo Móvil] (SM SM X510 / SM S911B)
                                        │
                                        ▼ (Tap en la Notificación)
                              [Flutter App Deep Linking]
                                        │
                                        ▼
                             [Detail Screen] (Doodle o Artwork)
```

---

## 2. Componentes del Sistema

### A. Base de Datos (Supabase SQL)

#### Tabla `notifications`
Almacena el historial y estado de lectura de cada notificación:
* `id` (UUID, Primary Key): Identificador único.
* `user_id` (UUID, FK a `users`): El destinatario que recibe la notificación.
* `actor_id` (UUID, FK a `users`): El usuario creador que realizó la acción.
* `type` (VARCHAR): Tipo de notificación (`idea_used_for_doodle`, `idea_used_for_artwork`, `doodle_used_for_artwork`).
* `target_id` (UUID): El ID del contenido creado para permitir la navegación.
* `is_read` (BOOLEAN): Estado de lectura (por defecto `false`).
* `created_at` (TIMESTAMP): Fecha y hora de creación.

#### Triggers de Generación Automática
Dos disparadores en PostgreSQL vigilan las inserciones y autogeneran los registros de notificaciones:
1. **`notify_idea_used_on_doodle` (Tabla `doodles`):** Se ejecuta cuando se crea un doodle. Si el doodle está basado en una idea de otro usuario (`idea_id`), inserta una notificación de tipo `idea_used_for_doodle`.
2. **`notify_used_on_artwork` (Tabla `artworks`):** Se ejecuta cuando se crea un artwork. Si se basa en un doodle de otro usuario, genera una notificación de tipo `doodle_used_for_artwork`. Si se basa directamente en una idea de otro usuario, genera una de tipo `idea_used_for_artwork`.

---

### B. Lógica en Flutter (Cliente)

#### Gestión de Permisos y Token FCM (`NotificationsNotifier`)
Las notificaciones push están desactivadas por defecto. El flujo de activación es el siguiente:
1. Al entrar a la campana de notificaciones por primera vez, se evalúa si `has_seen_push_prompt` es `false`.
2. Si es así, se muestra un diálogo modal preguntando si desea activar las notificaciones push.
3. Si acepta:
   * El sistema operativo solicita permisos nativos de notificaciones (especialmente en Android 13+ e iOS).
   * Si se conceden, Firebase Messaging obtiene el `FCM Token` único del dispositivo.
   * Se guarda en la base de datos en la tabla `users` (`fcm_token`, `push_notifications: true` y `has_seen_push_prompt: true`) usando el método `updatePushSettings` de `ProfileService`.
   * Para evitar bloqueos de la interfaz o estados colgantes si Firebase o la red tardan en responder, la llamada nativa tiene un **tiempo de espera máximo (timeout) de 5 segundos**.

#### Recepción y Deep Linking (`MainNavigationScreen`)
Cuando el usuario toca una notificación push en su dispositivo, la aplicación intercepta los metadatos enviados en el payload (`target_id` y `type`) en dos escenarios:
1. **App en segundo plano (Background):** Escuchado mediante el flujo `FirebaseMessaging.onMessageOpenedApp`.
2. **App cerrada (Terminated):** Resuelto en el inicio mediante `FirebaseMessaging.instance.getInitialMessage()`.

En ambos casos, el método `_handleNotificationClick`:
* Lee el `target_id` y el `type`.
* Solicita la información completa del contenido a Supabase de forma asíncrona.
* Abre una ruta de navegación animada hacia la pantalla de detalle correspondiente (`DoodleDetailScreen` o `ArtworkDetailScreen`).

---

### C. Backend (Supabase Edge Function)

#### Deno Edge Function (`send-push`)
Escrita en TypeScript y desplegada en la infraestructura serverless de Supabase:
* Recibe el evento del Webhook de base de datos tras la inserción en la tabla `notifications`.
* Lee de forma segura los datos del receptor (`fcm_token` y si tiene las notificaciones push encendidas) utilizando una clave de servicio administrativa (`SUPABASE_SERVICE_ROLE_KEY`) que elude las reglas RLS.
* Si el usuario receptor tiene las notificaciones apagadas o no cuenta con token, la función aborta de forma limpia y reporta éxito sin enviar nada.
* Si está activa, lee el archivo JSON de credenciales de la cuenta de servicio de Firebase desde la variable de entorno `FIREBASE_SERVICE_ACCOUNT` y genera un Token de acceso OAuth2 de Google temporal a través de `google-auth-library`.
* Envía la notificación estructurada a la API HTTP v1 de FCM con el siguiente formato de carga:
  ```json
  {
    "message": {
      "token": "TOKEN_FCM_DEL_DISPOSITIVO",
      "notification": {
        "title": "whatdoidraw?",
        "body": "@nombre_usuario ha usado tu idea para un doodle"
      },
      "data": {
        "notification_id": "ID_NOTIFICACION",
        "type": "idea_used_for_doodle",
        "target_id": "ID_DEL_DOODLE_CREADO"
      }
    }
  }
  ```

---

## 3. Notificaciones por Correo Electrónico (Resend)

El sistema de notificaciones también envía correos electrónicos automatizados utilizando **Resend** para notificar a los creadores cuando alguien usa sus creaciones (ideas o doodles), siempre que tengan activada la opción en sus Ajustes (`email_notifications: true`).

#### Deno Edge Function (`send-email`)
* Se ejecuta automáticamente a través de un Database Webhook al crearse un registro en la tabla `notifications`.
* **Obtención segura del email:** El UUID del destinatario se utiliza para realizar una consulta administrativa a `auth.users` mediante `supabaseClient.auth.admin.getUserById()`, recuperando de forma segura su dirección de correo electrónico.
* **Comprobación de preferencias:** La función verifica la columna `email_notifications` del usuario en la tabla `users` de Supabase. Si está en `false`, cancela el envío de forma limpia.
* **Generación de plantilla HTML:** Se compila dinámicamente un correo HTML responsivo con una estética premium oscura y morada a tono con la app.
* **Envío vía Resend:** Envía una petición `POST` a la API de Resend (`https://api.resend.com/emails`) utilizando el API key almacenada en los secretos de Supabase (`RESEND_API_KEY`). El remitente predeterminado de pruebas es `whatdoidraw? <onboarding@resend.dev>` (o el dominio personalizado verificado por el usuario).
