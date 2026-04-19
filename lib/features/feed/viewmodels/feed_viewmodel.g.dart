// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Proveedor reactivo que expone el flujo de ideas para la interfaz de usuario.
///
/// Este ViewModel actúa como un puente entre la UI y el [FeedService].
/// Al usar un `StreamProvider`, la UI se redibujará automáticamente
/// cada vez que el servicio emita una nueva lista de ideas desde Supabase.

@ProviderFor(ideasStream)
final ideasStreamProvider = IdeasStreamProvider._();

/// Proveedor reactivo que expone el flujo de ideas para la interfaz de usuario.
///
/// Este ViewModel actúa como un puente entre la UI y el [FeedService].
/// Al usar un `StreamProvider`, la UI se redibujará automáticamente
/// cada vez que el servicio emita una nueva lista de ideas desde Supabase.

final class IdeasStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IdeaModel>>,
          List<IdeaModel>,
          Stream<List<IdeaModel>>
        >
    with $FutureModifier<List<IdeaModel>>, $StreamProvider<List<IdeaModel>> {
  /// Proveedor reactivo que expone el flujo de ideas para la interfaz de usuario.
  ///
  /// Este ViewModel actúa como un puente entre la UI y el [FeedService].
  /// Al usar un `StreamProvider`, la UI se redibujará automáticamente
  /// cada vez que el servicio emita una nueva lista de ideas desde Supabase.
  IdeasStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ideasStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ideasStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<IdeaModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<IdeaModel>> create(Ref ref) {
    return ideasStream(ref);
  }
}

String _$ideasStreamHash() => r'60f017b5d926df90861fad88f98537aa8e0f122f';

/// Proveedor reactivo que expone el flujo constante de Doodles.

@ProviderFor(doodlesStream)
final doodlesStreamProvider = DoodlesStreamProvider._();

/// Proveedor reactivo que expone el flujo constante de Doodles.

final class DoodlesStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<DoodleModel>>,
          List<DoodleModel>,
          Stream<List<DoodleModel>>
        >
    with
        $FutureModifier<List<DoodleModel>>,
        $StreamProvider<List<DoodleModel>> {
  /// Proveedor reactivo que expone el flujo constante de Doodles.
  DoodlesStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'doodlesStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$doodlesStreamHash();

  @$internal
  @override
  $StreamProviderElement<List<DoodleModel>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<DoodleModel>> create(Ref ref) {
    return doodlesStream(ref);
  }
}

String _$doodlesStreamHash() => r'2e53a06994768e8dc4fa6170619704ce2780b40a';
