// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier que maneja el tema visual global de la aplicación.
///
/// Inicialmente detecta el tema guardado en SharedPreferences, o en su defecto
/// el tema oscuro (dark), y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el tema en tiempo real sin reiniciar la app.

@ProviderFor(AppThemeNotifier)
final appThemeProvider = AppThemeNotifierProvider._();

/// Notifier que maneja el tema visual global de la aplicación.
///
/// Inicialmente detecta el tema guardado en SharedPreferences, o en su defecto
/// el tema oscuro (dark), y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el tema en tiempo real sin reiniciar la app.
final class AppThemeNotifierProvider
    extends $NotifierProvider<AppThemeNotifier, AppThemeMode> {
  /// Notifier que maneja el tema visual global de la aplicación.
  ///
  /// Inicialmente detecta el tema guardado en SharedPreferences, o en su defecto
  /// el tema oscuro (dark), y lo expone a MaterialApp.
  /// Permite ser actualizado desde la pantalla de Ajustes para cambiar
  /// el tema en tiempo real sin reiniciar la app.
  AppThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeNotifierHash();

  @$internal
  @override
  AppThemeNotifier create() => AppThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeMode>(value),
    );
  }
}

String _$appThemeNotifierHash() => r'cfbe61be9b9881593e66e8b4b1dd6fc5d7f1700e';

/// Notifier que maneja el tema visual global de la aplicación.
///
/// Inicialmente detecta el tema guardado en SharedPreferences, o en su defecto
/// el tema oscuro (dark), y lo expone a MaterialApp.
/// Permite ser actualizado desde la pantalla de Ajustes para cambiar
/// el tema en tiempo real sin reiniciar la app.

abstract class _$AppThemeNotifier extends $Notifier<AppThemeMode> {
  AppThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AppThemeMode, AppThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppThemeMode, AppThemeMode>,
              AppThemeMode,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
