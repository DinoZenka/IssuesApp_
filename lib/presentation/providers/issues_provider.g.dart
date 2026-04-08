// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dio)
const dioProvider = DioProvider._();

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'a03da399b44b3740dc4fcfc6716203041d66ff01';

@ProviderFor(issueRepository)
const issueRepositoryProvider = IssueRepositoryProvider._();

final class IssueRepositoryProvider
    extends
        $FunctionalProvider<IssueRepository, IssueRepository, IssueRepository>
    with $Provider<IssueRepository> {
  const IssueRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issueRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issueRepositoryHash();

  @$internal
  @override
  $ProviderElement<IssueRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  IssueRepository create(Ref ref) {
    return issueRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IssueRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IssueRepository>(value),
    );
  }
}

String _$issueRepositoryHash() => r'ba47bb29fcf3bcbf5b2026ac125e9df8249d2b72';

@ProviderFor(IssuesNotifier)
const issuesProvider = IssuesNotifierProvider._();

final class IssuesNotifierProvider
    extends $AsyncNotifierProvider<IssuesNotifier, List<Issue>> {
  const IssuesNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issuesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issuesNotifierHash();

  @$internal
  @override
  IssuesNotifier create() => IssuesNotifier();
}

String _$issuesNotifierHash() => r'f2061973d74c7c97410cf1921ef1f2c038ef3c92';

abstract class _$IssuesNotifier extends $AsyncNotifier<List<Issue>> {
  FutureOr<List<Issue>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Issue>>, List<Issue>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Issue>>, List<Issue>>,
              AsyncValue<List<Issue>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(issuesCounts)
const issuesCountsProvider = IssuesCountsProvider._();

final class IssuesCountsProvider
    extends
        $FunctionalProvider<
          AsyncValue<({int closed, int open, int total})>,
          ({int closed, int open, int total}),
          FutureOr<({int closed, int open, int total})>
        >
    with
        $FutureModifier<({int closed, int open, int total})>,
        $FutureProvider<({int closed, int open, int total})> {
  const IssuesCountsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issuesCountsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issuesCountsHash();

  @$internal
  @override
  $FutureProviderElement<({int closed, int open, int total})> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<({int closed, int open, int total})> create(Ref ref) {
    return issuesCounts(ref);
  }
}

String _$issuesCountsHash() => r'ef2f279445f90a89b27d4ee1445352c57bd995ae';
