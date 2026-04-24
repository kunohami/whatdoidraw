# Database Schema (Supabase PostgreSQL) 🗄️

This document contains the complete relational schema for the **whatdoidraw?** project.

## Extensions
```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

## Tables

### Users
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  username VARCHAR UNIQUE NOT NULL,
  avatar_url VARCHAR,
  is_artist BOOLEAN DEFAULT FALSE,
  portfolio_url VARCHAR,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Ideas (Prompts)
```sql
CREATE TABLE ideas (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  tags VARCHAR[],
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Doodles (Sketches)
```sql
CREATE TABLE doodles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID REFERENCES users(id) ON DELETE CASCADE,
  idea_id UUID REFERENCES ideas(id) ON DELETE SET NULL,
  doodle_data JSONB NOT NULL,
  tags VARCHAR[],
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Artworks
```sql
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
```

### Bookmarks
```sql
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
```

### Likes
```sql
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
```

### Reports
```sql
CREATE TABLE reports (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reporter_id UUID REFERENCES users(id) ON DELETE SET NULL,
  reported_item_id UUID NOT NULL,
  item_type VARCHAR CHECK (item_type IN ('idea', 'doodle', 'artwork', 'user')),
  reason TEXT NOT NULL,
  status VARCHAR DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## Row Level Security (RLS) Policies

```sql
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE ideas ENABLE ROW LEVEL SECURITY;
ALTER TABLE doodles ENABLE ROW LEVEL SECURITY;
ALTER TABLE artworks ENABLE ROW LEVEL SECURITY;

-- users
CREATE POLICY "Public profiles" ON users FOR SELECT USING (true);
CREATE POLICY "Update own profile" ON users FOR UPDATE USING (auth.uid() = id);

-- ideas
CREATE POLICY "Public ideas" ON ideas FOR SELECT USING (true);
CREATE POLICY "Create own idea" ON ideas FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Update own idea" ON ideas FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Delete own idea" ON ideas FOR DELETE USING (auth.uid() = user_id);

-- doodles
CREATE POLICY "Public doodles" ON doodles FOR SELECT USING (true);
CREATE POLICY "Create own doodle" ON doodles FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Update own doodle" ON doodles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Delete own doodle" ON doodles FOR DELETE USING (auth.uid() = user_id);

-- artworks
CREATE POLICY "Public artworks" ON artworks FOR SELECT USING (true);
CREATE POLICY "Create own artwork" ON artworks FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Update own artwork" ON artworks FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Delete own artwork" ON artworks FOR DELETE USING (auth.uid() = user_id);
```
