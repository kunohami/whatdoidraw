# Gestión de Backend y Base de Datos

El backend de `whatdoidraw?` es 100% Serverless, impulsado por **Supabase** (BaaS corriendo sobre un motor nativo PostgreSQL).

## La Filosofía del Sistema (Costos 0€)
Como red colaborativa Open Source con alta demanda de subidas, se han configurado políticas estrictas para evitar el colapso del sistema de almacenamiento `Supabase Storage`:
1. **NO SE ALOJAN ARCHIVOS PNG/JPG PESADOS:** 
   El sistema está diseñado genéticamente para ser de texto.
2. Los textos de inspiración (Ideas) se guardan como cadenas abstractas.
3. **El Motor de Dibujo (Doodles)** exporta los trazos libres de los usuarios como una matriz matemática vectorial, almacenada directamente en las tablas bajo un campo ligero `JSONB`. Un dibujo pesado solo ocupará un par de KBs de texto crudo, permitiendo que la App lo renderice nativamente descargando el JSON en vez de una imagen 4K.
4. **Artworks (Arte externo):** Las obras maestras digitales finales nunca se suben a la app. Es necesario que el usuario aloje su arte en redes convencionales (Instagram, Twitter, Behance) y pegar el Hyperlink en la plataforma para indexarlo localmente mediante la tabla `artworks`.

## Tablas y Esquemas en PostgreSQL

- **`users`**: Autenticación gestionada por `auth.users` desencadenando perfiles públicos.
- **`ideas`**: Contiene la chispa creativa (`content` TEXT).
- **`doodles`**: Dibujos abstractos en la nube (`doodle_data` -> JSONB). Posee una `idea_id` foránea si el dibujo fue invocado e inspirado respondiendo al prompt de un compañero.
- **`artworks`**: Contiene un `external_link`. Puede poseer id foránea a un Doodle previo o Idea.
- **`bookmarks` & `likes`**: Controlan la socialización de la aplicación y nutren estadísticamente a los algoritmos de la pantalla Perfil y Feed.

## Seguridad (Row Level Security - RLS)
La barrera de seguridad de Supabase está sellada en el servidor. Cada lectura u operación es interceptada; usuarios no confirmados no pueden incrustar valores y toda actualización o sobreescritura de Doodles o Ideas está severamente restringida validando `auth.uid() = user_id`.
