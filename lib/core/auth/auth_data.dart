import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';

// ignore: must_be_immutable
class AuthData extends Equatable with AppStorageMixin {
  static const key = 'AuthData';
  String? aKey;
  AuthData({this.aKey});

  // bool get isAuthorized => aKey != null ? Jwt.isExpired(aKey!) : false;
  bool get isAuthorized => aKey != null ? true : false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aKey': aKey,
    };
  }

  Future<void> save() async =>
      await writeToMemory<String>(key, json.encode(toMap()));

  factory AuthData.fromMap(final Map<String, dynamic> map) {
    return AuthData(
      aKey: map['aKey'] != null ? map['aKey'] as String : null,
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

  AuthData copyWith({
    final String? aKey,
  }) {
    return AuthData(
      aKey: aKey ?? this.aKey,
    );
  }

  @override
  List<Object?> get props => [
        aKey,
      ];
}
