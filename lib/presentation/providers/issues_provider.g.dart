// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issues_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

String _$issuesNotifierHash() => r'7a9b9afe8df5e36c1dae32eb06f6630e88ffa385';

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

@ProviderFor(IssuesStatusFilter)
const issuesStatusFilterProvider = IssuesStatusFilterProvider._();

final class IssuesStatusFilterProvider
    extends $NotifierProvider<IssuesStatusFilter, IssueStatus?> {
  const IssuesStatusFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issuesStatusFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issuesStatusFilterHash();

  @$internal
  @override
  IssuesStatusFilter create() => IssuesStatusFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IssueStatus? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IssueStatus?>(value),
    );
  }
}

String _$issuesStatusFilterHash() =>
    r'018475aadb28d943e7c8f26487a963b59d19272a';

abstract class _$IssuesStatusFilter extends $Notifier<IssueStatus?> {
  IssueStatus? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<IssueStatus?, IssueStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IssueStatus?, IssueStatus?>,
              IssueStatus?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(IssuesSearchQuery)
const issuesSearchQueryProvider = IssuesSearchQueryProvider._();

final class IssuesSearchQueryProvider
    extends $NotifierProvider<IssuesSearchQuery, String> {
  const IssuesSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issuesSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issuesSearchQueryHash();

  @$internal
  @override
  IssuesSearchQuery create() => IssuesSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$issuesSearchQueryHash() => r'b271264421f013130ae52c1fe0673e391d6a8f47';

abstract class _$IssuesSearchQuery extends $Notifier<String> {
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
    extends $FunctionalProvider<List<Issue>, List<Issue>, List<Issue>>
    with $Provider<List<Issue>> {
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
  $ProviderElement<List<Issue>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Issue> create(Ref ref) {
    return filteredIssues(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Issue> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Issue>>(value),
    );
  }
}

String _$filteredIssuesHash() => r'b4b274a96ba3bdbc699ebb9ba163e83a0e14b149';

@ProviderFor(issuesCounts)
const issuesCountsProvider = IssuesCountsProvider._();

final class IssuesCountsProvider
    extends
        $FunctionalProvider<
          ({int closed, int open, int total}),
          ({int closed, int open, int total}),
          ({int closed, int open, int total})
        >
    with $Provider<({int closed, int open, int total})> {
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
  $ProviderElement<({int closed, int open, int total})> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ({int closed, int open, int total}) create(Ref ref) {
    return issuesCounts(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({int closed, int open, int total}) value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<({int closed, int open, int total})>(
        value,
      ),
    );
  }
}

String _$issuesCountsHash() => r'fd3fc4e3e3e6c87ff3b33ed949089b7dc2a469ec';
