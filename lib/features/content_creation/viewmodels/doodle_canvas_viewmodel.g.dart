// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doodle_canvas_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Gestor de la lógica de negocio para el lienzo de dibujo (ViewModel).
///
/// Este Notifier orquestra cómo los trazos físicos se transforman en estado
/// inmutable y cómo se persiste la creación del usuario.

@ProviderFor(DoodleCanvas)
final doodleCanvasProvider = DoodleCanvasProvider._();

/// Gestor de la lógica de negocio para el lienzo de dibujo (ViewModel).
///
/// Este Notifier orquestra cómo los trazos físicos se transforman en estado
/// inmutable y cómo se persiste la creación del usuario.
final class DoodleCanvasProvider
    extends $NotifierProvider<DoodleCanvas, DoodleCanvasState> {
  /// Gestor de la lógica de negocio para el lienzo de dibujo (ViewModel).
  ///
  /// Este Notifier orquestra cómo los trazos físicos se transforman en estado
  /// inmutable y cómo se persiste la creación del usuario.
  DoodleCanvasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doodleCanvasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doodleCanvasHash();

  @$internal
  @override
  DoodleCanvas create() => DoodleCanvas();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DoodleCanvasState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DoodleCanvasState>(value),
    );
  }
}

String _$doodleCanvasHash() => r'a3f3d15f66662e80b50d2214a1507099225f3ce2';

/// Gestor de la lógica de negocio para el lienzo de dibujo (ViewModel).
///
/// Este Notifier orquestra cómo los trazos físicos se transforman en estado
/// inmutable y cómo se persiste la creación del usuario.

abstract class _$DoodleCanvas extends $Notifier<DoodleCanvasState> {
  DoodleCanvasState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DoodleCanvasState, DoodleCanvasState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DoodleCanvasState, DoodleCanvasState>,
              DoodleCanvasState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
