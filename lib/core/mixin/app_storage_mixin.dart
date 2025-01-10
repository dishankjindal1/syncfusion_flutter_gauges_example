import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulgas_power/core/storage/app_persistent_storage_service.dart';
import 'package:pulgas_power/di.dart';

mixin class AppStorageMixin {
  /// read app storage
  Box<dynamic> get _getAppStorage =>
      getIt<AppPersistentStorageService>().appStorage;

  /// read [T] from Service Locator [getIt]
  T getRef<T extends Object>() => getIt<T>();

  /// read
  T readFromMemory<T>(final String key) => _getAppStorage.get(key) as T;

  /// read
  Stream<T> watchFromMemory<T>(final String key) =>
      _getAppStorage.watch(key: key).map((final BoxEvent x) => x.value as T);

  /// write
  Future<void> writeToMemory<T>(final String key, final T value) async =>
      _getAppStorage.put(key, value);

  /// remove
  Future<void> removeFromMemory(final String key) async =>
      _getAppStorage.delete(key);
}
