import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/core/reusable.dart';

// ignore: must_be_immutable
class AuthData extends Equatable with AppStorageMixin {
  static const key = 'AuthData';
  String? aKey;
  String? username;
  String? password;
  AuthData({
    this.aKey,
    this.username,
    this.password,
  });

  // bool get isAuthorized => aKey != null ? Jwt.isExpired(aKey!) : false;
  bool get isAuthorized => aKey != null ? true : false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aKey': aKey,
      'username': username,
      'password': password,
    };
  }

  Future<void> save() async =>
      await writeToMemory<String>(key, json.encode(toMap()));

  factory AuthData.fromMap(final Map<String, dynamic> map) {
    return AuthData(
      aKey: map['aKey'] != null ? map['aKey'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  factory AuthData.fromJson(final Box<dynamic> source) {
    try {
      return AuthData.fromMap(
          json.decode(source.get(key)) as Map<String, dynamic>);
    } catch (e) {
      return AuthData();
    }
  }

  Future<AuthData> shuffleTokens() async {
    final res = await getRef<Dio>()
        .post('https://<remoteip>:<remoteport>/gond/req.php', queryParameters: {
      'a': aKey,
      'u': username,
      'p': password,
    });

    aKey = res.data['ak'];
    return this;
  }

  Future<void> reset() async {
    aKey = null;
    username = null;
    password = null;
    await save();
  }

  copyWith({
    final String? aKey,
    final String? username,
    final String? password,
  }) {
    this.aKey = aKey ?? this.aKey;
    this.username = username ?? this.username;
    this.password =
        PProuterReuseable.generatePasswordHash(username, password) ??
            this.password;
  }

  @override
  List<Object?> get props => [
        aKey,
        username,
        password,
      ];
}
