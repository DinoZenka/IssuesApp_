// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'448adad5717e7b1c0b3ca3ca7e03d0b2116237af';

@ProviderFor(issueLocalDataSource)
const issueLocalDataSourceProvider = IssueLocalDataSourceProvider._();

final class IssueLocalDataSourceProvider
    extends
        $FunctionalProvider<
          IssueLocalDataSource,
          IssueLocalDataSource,
          IssueLocalDataSource
        >
    with $Provider<IssueLocalDataSource> {
  const IssueLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issueLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issueLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<IssueLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IssueLocalDataSource create(Ref ref) {
    return issueLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IssueLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IssueLocalDataSource>(value),
    );
  }
}

String _$issueLocalDataSourceHash() =>
    r'486c2f7455e6e2c8e86771ceec4c47dc31f285d6';

@ProviderFor(issueRemoteDataSource)
const issueRemoteDataSourceProvider = IssueRemoteDataSourceProvider._();

final class IssueRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          IssueRemoteDataSource,
          IssueRemoteDataSource,
          IssueRemoteDataSource
        >
    with $Provider<IssueRemoteDataSource> {
  const IssueRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'issueRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$issueRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<IssueRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IssueRemoteDataSource create(Ref ref) {
    return issueRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IssueRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IssueRemoteDataSource>(value),
    );
  }
}

String _$issueRemoteDataSourceHash() =>
    r'7779add71c273ab32acba2bc764e6954d4d81697';

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
        isAutoDispose: false,
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

String _$issueRepositoryHash() => r'5117588870df9ad5a1648ffb2f6ac4e73f4dc5d1';
