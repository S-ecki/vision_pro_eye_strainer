// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$levelHash() => r'97078ad9aba9d98fdef844f2a25c04c31de544b9';

/// See also [level].
@ProviderFor(level)
final levelProvider = AutoDisposeProvider<int>.internal(
  level,
  name: r'levelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$levelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LevelRef = AutoDisposeProviderRef<int>;
String _$sizeHash() => r'f9fe257d3bb7af1b298ac5441a9eebd0364f37ed';

/// See also [size].
@ProviderFor(size)
final sizeProvider = AutoDisposeProvider<double>.internal(
  size,
  name: r'sizeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SizeRef = AutoDisposeProviderRef<double>;
String _$targetControllerHash() => r'774e1f49972bae9868ef4f136031403ab052c96a';

/// See also [TargetController].
@ProviderFor(TargetController)
final targetControllerProvider =
    AutoDisposeNotifierProvider<TargetController, List<Target>>.internal(
  TargetController.new,
  name: r'targetControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$targetControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TargetController = AutoDisposeNotifier<List<Target>>;
String _$scoreControllerHash() => r'02c27bfe516ba4400b6064e01e24ae1d1bb8d1d4';

/// See also [ScoreController].
@ProviderFor(ScoreController)
final scoreControllerProvider =
    AutoDisposeNotifierProvider<ScoreController, int>.internal(
  ScoreController.new,
  name: r'scoreControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$scoreControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ScoreController = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
