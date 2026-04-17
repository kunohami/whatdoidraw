import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'supabase_provider.g.dart';

/// Provee una instancia única y global del cliente de Supabase.
///
/// Este proveedor es la piedra angular del acceso a datos. Al usar Riverpod,
/// cualquier parte de la aplicación puede acceder al cliente de base de datos
/// de forma segura y centralizada, facilitando el mantenimiento y las pruebas.
///
/// Por qué usar un Provider para Supabase:
/// 1. **Singleton:** Garantiza que solo exista una conexión abierta.
/// 2. **Reactividad:** Permite que otros componentes se enteren si el cliente cambia.
/// 3. **Testeabilidad:** Facilita el intercambio por un cliente "Mock" en pruebas unitarias.
@riverpod
SupabaseClient supabaseClient(Ref ref) {
  return Supabase.instance.client;
}
