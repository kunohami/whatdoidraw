// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier que maneja el idioma global de la aplicación.
///
/// Inicialmente detecta el idioma guardado en SharedPreferences, o en su defecto
/// el idioma del sistema, y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el idioma en tiempo real sin reiniciar la app.

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// Notifier que maneja el idioma global de la aplicación.
///
/// Inicialmente detecta el idioma guardado en SharedPreferences, o en su defecto
/// el idioma del sistema, y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el idioma en tiempo real sin reiniciar la app.
final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale> {
  /// Notifier que maneja el idioma global de la aplicación.
  ///
  /// Inicialmente detecta el idioma guardado en SharedPreferences, o en su defecto
  /// el idioma del sistema, y lo expone a MaterialApp.
  /// Permite ser actualizado desde la pantalla de Ajustes para cambiar
  /// el idioma en tiempo real sin reiniciar la app.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$appLocaleHash() => r'4110a8aa961834acd9ab733489ed805d2f761069';

/// Notifier que maneja el idioma global de la aplicación.
///
/// Inicialmente detecta el idioma guardado en SharedPreferences, o en su defecto
/// el idioma del sistema, y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el idioma en tiempo real sin reiniciar la app.

abstract class _$AppLocale extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
