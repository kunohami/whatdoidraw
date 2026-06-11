# Setup Guide

## Prerequisites

* Flutter 3.11+
* A [Supabase](https://supabase.com) project

## Steps

1. **Clone the repository**:
   ```bash
   git clone https://github.com/kunohami/whatdoidraw.git
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**: Create a `.env` file at the project root with your Supabase credentials:
   ```env
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_ANON_KEY=your-anon-key
   ```

4. **Generate dynamic code** (Riverpod & Freezed):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**:
   ```bash
   flutter run
   ```
