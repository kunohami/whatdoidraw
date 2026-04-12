```markdown
# 🤖 KNOWLEDGE BASE & AI INSTRUCTIONS: whatdoidraw? (wdid?)

## 1. Contexto del Proyecto
**whatdoidraw? (wdid?)** es una aplicación móvil nativa (Flutter) diseñada como una red social colaborativa para superar el bloqueo creativo. 
El flujo de inspiración es flexible y se basa en tres tipos de contenido interconectados:
1. **Idea (Prompt):** Publicación de texto.
2. **Doodle (Boceto):** Dibujo ejecutado en la app. Puede crearse de forma libre e independiente, o estar vinculado al ID de una Idea.
3. **Artwork (Arte Final):** Publicación que enlaza una obra alojada externamente. Requiere que el usuario seleccione una Idea o Doodle de su sección de "Guardados" (Bookmarks) para establecer el origen de la inspiración. El flujo de creación principal (Pestaña Crear) debe ofrecer opciones diferenciadas para iniciar cualquiera de los tres formatos.

## 2. Stack Tecnológico
- **Frontend:** Flutter (Dart).
- **Backend/BaaS:** Supabase (PostgreSQL + Auth).
- **Gestión de Estado:** Riverpod (usando los paquetes `flutter_riverpod` y `riverpod_annotation` para la generación de código).
- **Arquitectura:** Feature-first (agrupado por funcionalidades: auth, feed, profile, creation).

## 3. 🚨 REGLAS ESTRICTAS PARA EL AGENTE DE IA (LEER SIEMPRE) 🚨
1. **NO ALOJAMOS IMÁGENES DE PUBLICACIONES EN LA APP:**
   - Los **Doodles** se dibujan en un lienzo en la app y sus trazos se guardan como JSON en el campo de la base de datos `doodle_data`. NO generes código para subir PNGs de doodles a Supabase Storage.
   - Los **Artworks** finales están alojados externamente (Instagram, Twitter, etc.). Solo guardamos el `external_link` y un `preview_url`.
2. **Gestión de Estado:** Usa SIEMPRE Riverpod para la lógica de negocio y llamadas a backend. Usa `AsyncNotifier` o `FutureProvider` según corresponda para manejar estados de carga y error.
3. **Consultas a Base de Datos:** Usa el SDK oficial `supabase_flutter`. Aprovecha que las relaciones ya están definidas en SQL al consultar datos.
4. **Manejo de Errores:** Siempre incluye bloques `try-catch` al interactuar con Supabase y expón los errores al usuario mediante la UI (SnackBar/Toast).
5. **Enfoque Educativo:** Documenta exhaustivamente cada parte compleja del código desarrollado usando bloques de comentarios explicativos con el formato `// [DOC]: explicación...`. El objetivo es que el usuario aprenda las entrañas de Flutter, cómo Riverpod interopera con Supabase, y el diseño de interfaces mientras avanza el proyecto.

## 4. Referencia de Base de Datos (PostgreSQL en Supabase)

### Esquema Relacional (Tablas)
```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username VARCHAR UNIQUE NOT NULL,
  avatar_url VARCHAR,
  is_artist BOOLEAN DEFAULT FALSE,
  portfolio_url VARCHAR,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE ideas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  tags VARCHAR[],
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE doodles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  idea_id UUID REFERENCES ideas(id) ON DELETE SET NULL,
  doodle_data JSONB NOT NULL,
  tags VARCHAR[],
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE artworks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  doodle_id UUID REFERENCES doodles(id) ON DELETE SET NULL,
  preview_url VARCHAR,
  external_link VARCHAR NOT NULL,
  tags VARCHAR[],
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE bookmarks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  idea_id UUID REFERENCES ideas(id) ON DELETE CASCADE,
  doodle_id UUID REFERENCES doodles(id) ON DELETE CASCADE,
  artwork_id UUID REFERENCES artworks(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT unique_bookmark_idea UNIQUE (user_id, idea_id),
  CONSTRAINT unique_bookmark_doodle UNIQUE (user_id, doodle_id),
  CONSTRAINT unique_bookmark_artwork UNIQUE (user_id, artwork_id)
);

CREATE TABLE likes (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  idea_id UUID REFERENCES ideas(id) ON DELETE CASCADE,
  doodle_id UUID REFERENCES doodles(id) ON DELETE CASCADE,
  artwork_id UUID REFERENCES artworks(id) ON DELETE CASCADE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  CONSTRAINT unique_like_idea UNIQUE (user_id, idea_id),
  CONSTRAINT unique_like_doodle UNIQUE (user_id, doodle_id),
  CONSTRAINT unique_like_artwork UNIQUE (user_id, artwork_id)
);

CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reporter_id UUID REFERENCES users(id) ON DELETE SET NULL,
  reported_item_id UUID NOT NULL,
  item_type VARCHAR CHECK (item_type IN ('idea', 'doodle', 'artwork', 'user')),
  reason TEXT NOT NULL,
  status VARCHAR DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE ideas ENABLE ROW LEVEL SECURITY;
ALTER TABLE doodles ENABLE ROW LEVEL SECURITY;
ALTER TABLE artworks ENABLE ROW LEVEL SECURITY;

-- users
CREATE POLICY "Perfiles publicos" ON users FOR SELECT USING (true);
CREATE POLICY "Actualizar perfil propio" ON users FOR UPDATE USING (auth.uid() = id);

-- ideas
CREATE POLICY "Ideas publicas" ON ideas FOR SELECT USING (true);
CREATE POLICY "Crear idea propia" ON ideas FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Actualizar idea propia" ON ideas FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Borrar idea propia" ON ideas FOR DELETE USING (auth.uid() = user_id);

-- doodles
CREATE POLICY "Doodles publicos" ON doodles FOR SELECT USING (true);
CREATE POLICY "Crear doodle propio" ON doodles FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Actualizar doodle propio" ON doodles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Borrar doodle propio" ON doodles FOR DELETE USING (auth.uid() = user_id);

-- artworks
CREATE POLICY "Artworks publicos" ON artworks FOR SELECT USING (true);
CREATE POLICY "Crear artwork propio" ON artworks FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Actualizar artwork propio" ON artworks FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Borrar artwork propio" ON artworks FOR DELETE USING (auth.uid() = user_id);