// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_idea_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controlador encargado de gestionar el estado de creación de una nueva idea.
///
/// Mantiene un estado booleano simple que indica si el proceso de subida
/// (publicación) está en curso para mostrar indicadores de carga en la UI.

@ProviderFor(CreateIdeaController)
final createIdeaControllerProvider = CreateIdeaControllerProvider._();

/// Controlador encargado de gestionar el estado de creación de una nueva idea.
///
/// Mantiene un estado booleano simple que indica si el proceso de subida
/// (publicación) está en curso para mostrar indicadores de carga en la UI.
final class CreateIdeaControllerProvider
    extends $NotifierProvider<CreateIdeaController, bool> {
  /// Controlador encargado de gestionar el estado de creación de una nueva idea.
  ///
  /// Mantiene un estado booleano simple que indica si el proceso de subida
  /// (publicación) está en curso para mostrar indicadores de carga en la UI.
  CreateIdeaControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createIdeaControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createIdeaControllerHash();

  @$internal
  @override
  CreateIdeaController create() => CreateIdeaController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$createIdeaControllerHash() =>
    r'4991c2c5a139e75665e1d14c1babef92249414ad';

/// Controlador encargado de gestionar el estado de creación de una nueva idea.
///
/// Mantiene un estado booleano simple que indica si el proceso de subida
/// (publicación) está en curso para mostrar indicadores de carga en la UI.

abstract class _$CreateIdeaController extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
