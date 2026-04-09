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

String _$issueRepositoryHash() => r'2786db189a5600982e97ab815dae8505cbca9fac';

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

String _$issuesNotifierHash() => r'48010ce7ee3b4e973793e219de2fba3812819c18';

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

@ProviderFor(SearchQuery)
const searchQueryProvider = SearchQueryProvider._();

final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  const SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'1ca1ea226c52264e3fb16ff14ad993ca6bec64a2';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(filteredIssues)
const filteredIssuesProvider = FilteredIssuesProvider._();

final class FilteredIssuesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Issue>>,
          List<Issue>,
          FutureOr<List<Issue>>
        >
    with $FutureModifier<List<Issue>>, $FutureProvider<List<Issue>> {
  const FilteredIssuesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredIssuesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredIssuesHash();

  @$internal
  @override
  $FutureProviderElement<List<Issue>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Issue>> create(Ref ref) {
    return filteredIssues(ref);
  }
}

String _$filteredIssuesHash() => r'1d465c2898b382bce4221dc8bb5425d54178097c';

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
