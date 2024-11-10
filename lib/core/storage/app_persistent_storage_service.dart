import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPersistentStorageService {
  AppPersistentStorageService(
    this._appDirectory,
    this._appCacheDirectory,
  );
  final Directory _appCacheDirectory;
  final Directory _appDirectory;
  late final Box<dynamic> appStorage;

  String get appDirectoryPath => _appDirectory.path;
  String get appCacheDirectoryPath =>
      Platform.isIOS ? _appDirectory.path : _appCacheDirectory.path;

  Future<void> initalize() async {
    const appSecureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock,
      ),
    );
    Hive.init(_appDirectory.path);

    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool(const String.fromEnvironment('FIRST_RUN')) ?? true) {
      await appSecureStorage.deleteAll();

      prefs.setBool(const String.fromEnvironment('FIRST_RUN'), false);
    }

    if ((await appSecureStorage.read(
            key: const String.fromEnvironment('APP_SECURE_KEY'))) ==
        null) {
      await appSecureStorage.write(
        key: const String.fromEnvironment('APP_SECURE_KEY'),
        value: base64Encode(Hive.generateSecureKey()),
      );
    }

    final HiveAesCipher hiveCipher = HiveAesCipher(
      base64Decode((await appSecureStorage.read(
          key: const String.fromEnvironment('APP_SECURE_KEY')))!),
    );

    final box = await Hive.openBox(
      const String.fromEnvironment('APP_LOCAL_STORAGE'),
      encryptionCipher: hiveCipher,
    );

    appStorage = box;
  }
}
