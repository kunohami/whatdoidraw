// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_detail_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IdeaDetailNotifier)
final ideaDetailProvider = IdeaDetailNotifierFamily._();

final class IdeaDetailNotifierProvider
    extends $NotifierProvider<IdeaDetailNotifier, IdeaDetailState> {
  IdeaDetailNotifierProvider._({
    required IdeaDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ideaDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ideaDetailNotifierHash();

  @override
  String toString() {
    return r'ideaDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IdeaDetailNotifier create() => IdeaDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IdeaDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IdeaDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IdeaDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ideaDetailNotifierHash() =>
    r'b49c7155a5d7fedfa0d42ea415e5461803f9d249';

final class IdeaDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          IdeaDetailNotifier,
          IdeaDetailState,
          IdeaDetailState,
          IdeaDetailState,
          String
        > {
  IdeaDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'ideaDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IdeaDetailNotifierProvider call(String ideaId) =>
      IdeaDetailNotifierProvider._(argument: ideaId, from: this);

  @override
  String toString() => r'ideaDetailProvider';
}

abstract class _$IdeaDetailNotifier extends $Notifier<IdeaDetailState> {
  late final _$args = ref.$arg as String;
  String get ideaId => _$args;

  IdeaDetailState build(String ideaId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IdeaDetailState, IdeaDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IdeaDetailState, IdeaDetailState>,
              IdeaDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
