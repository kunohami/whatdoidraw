# Configuración de Autenticación 🔐

Este documento detalla la implementación del sistema de autenticación en **whatdoidraw?**, cubriendo Email/Password y la integración con Google Sign-In.

## 🚀 Estado Actual
- **Email/Password**: Funcional en todas las plataformas (Supabase Auth).
- **Google Sign-In (Android)**: Funcional (Nativo).
- **Google Sign-In (Web)**: Configurado (requiere optimización final de orígenes de JavaScript).

## 🛠️ Setup Técnico

### 1. Supabase (Backend)
Se utiliza `supabase_flutter` para la gestión de sesiones.
- **Provider**: Google habilitado.
- **Client ID**: Se utiliza el ID de cliente Web (`...-u6a4...`) como `serverClientId` para permitir el intercambio de tokens seguro entre Android y Supabase.

### 2. Android (Nativo)
- **Plugin**: `google_sign_in` v7.2.0+.
- **Configuración**: Archivo `android/app/google-services.json` integrado.
- **Gradle**: Plugin `com.google.gms.google-services` activado en `build.gradle.kts`.
- **SHA-1**: El certificado de depuración (debug) debe estar registrado en la consola de Firebase/Google Cloud.

### 3. Web (Google Identity Services)
- **Librería**: Se utiliza el nuevo estándar GSI (Google Identity Services).
- **Botón**: Implementación del botón oficial mediante `renderButton()` para cumplir con las políticas de marca de Google.
- **Requisito Crítico**: Las pruebas locales deben realizarse en `http://localhost` (no `127.0.0.1`) con un puerto autorizado.

## 🔒 Recuperación de Contraseña & Deep Linking (Recuperación)

Se ha implementado el flujo completo de recuperación de contraseña de forma segura y declarativa.

### 🛠️ Flujo de Trabajo
1. **Solicitud de Recuperación**: Desde la pantalla `AuthScreen` en modo "¿Olvidaste tu contraseña?", el usuario ingresa su correo y se llama a `AuthController.sendPasswordResetEmail(email)`.
2. **Deep Linking (Esquema Personalizado)**: Supabase envía un correo electrónico al usuario que contiene un enlace de reinicio. Este enlace está configurado para redirigir a `io.supabase.whatdoidraw://reset-password/`.
3. **Manejo del Enlace (Deep Link)**:
   - **Android**: Configurado en `AndroidManifest.xml` con un `<intent-filter>` para el esquema `io.supabase.whatdoidraw` y host `reset-password`.
   - **iOS**: Configurado en `Info.plist` bajo `CFBundleURLTypes` con el esquema `io.supabase.whatdoidraw`.
4. **Restablecimiento Interactivo (`ResetPasswordDialog`)**:
   - `AuthGate` (convertido en `ConsumerStatefulWidget`) escucha activamente la corriente `onAuthStateChange`.
   - Al detectar `AuthChangeEvent.passwordRecovery`, la app abre automáticamente el `ResetPasswordDialog` (usando `addPostFrameCallback` para garantizar estabilidad visual).
   - El diálogo solicita la nueva contraseña, valida su longitud y coincidencia, y llama a `AuthController.updatePassword(newPassword)`.
   - Si el usuario cancela el diálogo, se realiza un `signOut` para evitar dejar la sesión en un estado de recuperación intermedio no deseado.

## 📝 Roadmap de Auth (Próximos Pasos)
1. **Google Web (Iteración 5)**: Pulido de los Authorized JavaScript Origins para producción.
2. **Discord Login**: Implementación vía OAuth2 (Supabase Auth).
3. **Manejo de Errores**: Refinar los mensajes de error para el usuario final (ej: falta de conexión, cancelación de flujo).

---
*Última actualización: 23 de Mayo de 2026*
