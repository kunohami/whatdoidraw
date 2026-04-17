// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supabase_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(supabaseClient)
final supabaseClientProvider = SupabaseClientProvider._();

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

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
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
  SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'834a58d6ae4b94e36f4e04a10d8a7684b929310e';
