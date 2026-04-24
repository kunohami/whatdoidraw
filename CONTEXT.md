# 🤖 KNOWLEDGE BASE & INSTRUCTIONS: whatdoidraw? (wdid?)

## 1. Project Context
**whatdoidraw? (wdid?)** is a native mobile application (Flutter) designed as a collaborative social network to overcome creative blocks. 
The inspiration flow is flexible and based on three interconnected content types:
1. **Idea (Prompt):** Text-based post.
2. **Doodle (Sketch):** Drawing executed within the app. It can be created freely or linked to an Idea ID.
3. **Artwork (Final Art):** Post linking to an externally hosted work (Instagram, Twitter, etc.). Requires the user to select an Idea or Doodle from their "Bookmarks" to establish the source of inspiration.

## 2. Tech Stack
- **Frontend:** Flutter (Dart).
- **Backend/BaaS:** Supabase (PostgreSQL + Auth).
- **State Management:** Riverpod (using `flutter_riverpod` and `riverpod_annotation` for code generation).
- **Architecture:** Pragmatic MVVM (Feature-Driven). Clear separation of concerns between View, ViewModel, and Service.

## 3. 🚨 STRICT AI AGENT RULES (ALWAYS READ) 🚨
1. **NO IMAGE HOSTING FOR APP POSTS:**
   - **Doodles** are drawn on an in-app canvas and strokes are saved as JSON in the `doodle_data` database field. DO NOT generate code to upload PNGs of doodles to Supabase Storage.
   - **Artworks** are hosted externally. We only store the `external_link` and a `preview_url`.
2. **State Management (Robust MVVM):** 
   - ALWAYS use Riverpod (`Notifier` / `AsyncNotifier`) with generators (`@riverpod`).
   - ViewModel state MUST be a `@freezed` object including fields for loading (`isLoading`), errors (`errorMessage`), and the resulting data.
3. **Authentication Abstraction:** 
   - Never depend directly on `SupabaseAuth` inside ViewModels. Always use `authControllerProvider` to abstract identity infrastructure.
4. **Mandatory Testing:** 
   - Every new ViewModel or critical service MUST have a corresponding unit test in the `test/` directory. Use `mocktail` for dependency injection.
5. **Style and Static Analysis:** 
   - Code MUST pass `flutter analyze` without errors or warnings.
   - ALWAYS use package imports (`package:whatdoidraw/...`) instead of relative imports.
   - Follow directive ordering rules and use `final` for local variables.
6. **Database Queries:** 
   - Use the official `supabase_flutter` SDK. Leverage existing SQL relationships when querying data.
7. **Error Handling:** 
   - Centralize error handling in the ViewModel. Catch service exceptions and map them to an `errorMessage` field in the state for declarative consumption by the View.
8. **Centralized Models:** 
   - Always use models located in `lib/shared/models/` for consistency and reusability.
9. **Documentation:** 
   - Document code properly and add didactic explanations. Keep DartDocs up to date.

## 4. Database Reference
The full PostgreSQL relational schema and RLS policies are documented in:
👉 **[docs/DATABASE_SCHEMA.md](docs/DATABASE_SCHEMA.md)**

---
*Last update: April 24, 2026*