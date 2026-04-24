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

## 📝 Roadmap de Auth (Próximos Pasos)
1. **Google Web (Iteración 5)**: Pulido de los Authorized JavaScript Origins para producción.
2. **Discord Login**: Implementación vía OAuth2 (Supabase Auth).
3. **Manejo de Errores**: Refinar los mensajes de error para el usuario final (ej: falta de conexión, cancelación de flujo).

---
*Última actualización: 24 de Abril de 2026*
