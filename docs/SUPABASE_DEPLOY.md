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

## 2. Edge Function: `send-email` (Gmail SMTP)

Esta función se encarga de recibir las nuevas notificaciones de la base de datos a través de un Webhook, buscar el email del destinatario, comprobar sus preferencias de correo y enviar una plantilla HTML premium a través de una conexión segura TLS utilizando el servidor SMTP de tu cuenta de Gmail (ideal para pruebas académicas del TFG sin requerir un dominio propio).

### Configuración de Credenciales SMTP en Supabase

Debes registrar el correo de tu cuenta de Gmail y su Contraseña de Aplicación en los secretos de tu proyecto de Supabase.

#### Opción A: Desde el panel web de Supabase (Recomendado y más sencillo)
1. Ve al panel de control de tu proyecto en **Supabase** (https://supabase.com/dashboard).
2. Entra en **Project Settings** (icono de engranaje) -> **Edge Functions**.
3. Añade los siguientes dos secretos:
   * **Secreto 1:**
     - **Name:** `SMTP_USER`
     - **Value:** *Tu dirección de correo de Gmail (por ejemplo: `whatdoidraw.app@gmail.com`).*
   * **Secreto 2:**
     - **Name:** `SMTP_PASS`
     - **Value:** *La contraseña de aplicación de 16 caracteres generada en tu cuenta de Google (sin espacios).*
4. Haz clic en **Save**.

#### Opción B: A través de la CLI de Supabase
Abre tu terminal y ejecuta los siguientes comandos en la raíz del proyecto:
```bash
npx supabase secrets set SMTP_USER="whatdoidraw.app@gmail.com"
npx supabase secrets set SMTP_PASS="tu_contraseña_de_aplicacion_de_16_caracteres"
```

---

### Despliegue de la Edge Function

Para subir y compilar la función `send-email` en Supabase, ejecuta el siguiente comando desde la raíz del proyecto:
```bash
npx supabase functions deploy send-email
```

---

### Configuración del Webhook en Supabase

Para que la función se ejecute automáticamente cada vez que se cree una notificación en la base de datos:

1. En el panel de control de Supabase, ve a **Database** -> **Webhooks**.
2. Haz clic en **Create Webhook**.
3. Configura el webhook de la siguiente manera:
   - **Name:** `send_email_notification`
   - **Table:** `notifications`
   - **Events:** Selecciona únicamente **Insert** (para que se dispare al crear una notificación).
   - **Type of Webhook:** Selecciona **Supabase Edge Function**.
   - **Edge Function:** Selecciona **send-email** de la lista.
   - **Method:** `POST`
4. Haz clic en **Save** (Guardar).
