# Guía de Despliegue de Supabase Edge Functions para Notificaciones

Este documento detalla los pasos necesarios para configurar y desplegar las Edge Functions necesarias en Supabase para el sistema de notificaciones (móvil y correo).

> [!NOTE]
> Para que los comandos de la CLI de Supabase funcionen de manera predeterminada, la carpeta de código `supabase/functions/` se mantiene en la raíz del proyecto.

## 1. Edge Function: `send-push` (Firebase Cloud Messaging)

Esta función se encarga de recibir las nuevas notificaciones de la base de datos a través de un Webhook y enviarlas al dispositivo del usuario utilizando la API HTTP v1 de Firebase.

### Configuración de Secretos en Supabase

Antes de desplegar, debes registrar el contenido de tu cuenta de servicio de Firebase como secreto en Supabase.

#### Opción A: Desde el panel web de Supabase (Recomendado y más sencillo)
1. Ve al panel de control de tu proyecto en **Supabase** (https://supabase.com/dashboard).
2. Entra en **Project Settings** (icono de engranaje) -> **Edge Functions**.
3. En la sección **Secrets**, haz clic en **Add Secret**.
4. Rellena los datos:
   - **Name:** `FIREBASE_SERVICE_ACCOUNT`
   - **Value:** *Pega aquí todo el contenido del archivo JSON que descargaste de la cuenta de servicio de Firebase (incluyendo las llaves `{ ... }`).*
5. Haz clic en **Save**.

#### Opción B: A través de la CLI de Supabase
Abre tu terminal y ejecuta el siguiente comando en la raíz del proyecto (reemplaza el contenido por tu JSON):
```bash
npx supabase secrets set FIREBASE_SERVICE_ACCOUNT='{"type": "service_account", ...}'
```

---

### Despliegue de la Edge Function

Para subir y compilar la función en Supabase, ejecuta el siguiente comando desde la raíz del proyecto:
```bash
npx supabase functions deploy send-push
```

---

### Configuración del Webhook en Supabase

Para que la función se ejecute automáticamente cada vez que se cree una notificación en la base de datos:

1. En el panel de control de Supabase, ve a **Database** -> **Webhooks**.
2. Haz clic en **Create Webhook** (o *Enable Webhooks* si es la primera vez).
3. Configura el webhook de la siguiente manera:
   - **Name:** `send_push_notification`
   - **Table:** `notifications`
   - **Events:** Selecciona únicamente **Insert** (para que se dispare al crear una notificación).
   - **Type of Webhook:** Selecciona **Supabase Edge Function**.
   - **Edge Function:** Selecciona **send-push** de la lista.
   - **Method:** `POST`
4. Haz clic en **Save** (Guardar).

---

## 2. Edge Function: `send-email` (Resend) - Próxima Fase

*Esta fase se activará una vez que hayamos completado e integrado las notificaciones por correo electrónico.*
