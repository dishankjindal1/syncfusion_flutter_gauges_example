// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$logsViewModelHash() => r'1e1f96cc481fe3c806f1270f75c410cd1e10a6ec';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [logsViewModel].
@ProviderFor(logsViewModel)
const logsViewModelProvider = LogsViewModelFamily();

/// See also [logsViewModel].
class LogsViewModelFamily extends Family<AsyncValue<PPLogsEntity>> {
  /// See also [logsViewModel].
  const LogsViewModelFamily();

  /// See also [logsViewModel].
  LogsViewModelProvider call(
    int pageNumber,
    int pageLimit,
  ) {
    return LogsViewModelProvider(
      pageNumber,
      pageLimit,
    );
  }

  @override
  LogsViewModelProvider getProviderOverride(
    covariant LogsViewModelProvider provider,
  ) {
    return call(
      provider.pageNumber,
      provider.pageLimit,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'logsViewModelProvider';
}

/// See also [logsViewModel].
class LogsViewModelProvider extends FutureProvider<PPLogsEntity> {
  /// See also [logsViewModel].
  LogsViewModelProvider(
    int pageNumber,
    int pageLimit,
  ) : this._internal(
          (ref) => logsViewModel(
            ref as LogsViewModelRef,
            pageNumber,
            pageLimit,
          ),
          from: logsViewModelProvider,
          name: r'logsViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$logsViewModelHash,
          dependencies: LogsViewModelFamily._dependencies,
          allTransitiveDependencies:
              LogsViewModelFamily._allTransitiveDependencies,
          pageNumber: pageNumber,
          pageLimit: pageLimit,
        );

  LogsViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageNumber,
    required this.pageLimit,
  }) : super.internal();

  final int pageNumber;
  final int pageLimit;

  @override
  Override overrideWith(
    FutureOr<PPLogsEntity> Function(LogsViewModelRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LogsViewModelProvider._internal(
        (ref) => create(ref as LogsViewModelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageNumber: pageNumber,
        pageLimit: pageLimit,
      ),
    );
  }

  @override
  FutureProviderElement<PPLogsEntity> createElement() {
    return _LogsViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LogsViewModelProvider &&
        other.pageNumber == pageNumber &&
        other.pageLimit == pageLimit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageNumber.hashCode);
    hash = _SystemHash.combine(hash, pageLimit.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LogsViewModelRef on FutureProviderRef<PPLogsEntity> {
  /// The parameter `pageNumber` of this provider.
  int get pageNumber;

  /// The parameter `pageLimit` of this provider.
  int get pageLimit;
}

class _LogsViewModelProviderElement extends FutureProviderElement<PPLogsEntity>
    with LogsViewModelRef {
  _LogsViewModelProviderElement(super.provider);

  @override
  int get pageNumber => (origin as LogsViewModelProvider).pageNumber;
  @override
  int get pageLimit => (origin as LogsViewModelProvider).pageLimit;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
