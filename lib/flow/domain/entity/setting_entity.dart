import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/data/model/setting_model.dart';

class SettingEntity extends Equatable with AppStorageMixin {
  static const key = 'SettingEntity';
  final String? username;
  final String? password;
  final String? remoteIp;
  final String? remotePort;
  final Duration? liveDataInterval;
  final Duration? dailyFigureInterval;
  final Duration? graphFigureInterval;
  final Duration? logsInterval;

  const SettingEntity({
    this.username,
    this.password,
    this.remoteIp,
    this.remotePort,
    this.liveDataInterval,
    this.dailyFigureInterval,
    this.graphFigureInterval,
    this.logsInterval,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'remoteIp': remoteIp,
      'remotePort': remotePort,
      'liveDataInterval': liveDataInterval?.inMilliseconds,
      'dailyFigureInterval': dailyFigureInterval?.inMilliseconds,
      'graphFigureInterval': graphFigureInterval?.inMilliseconds,
      'logsInterval': logsInterval?.inMilliseconds,
    };
  }

  String toJson() => json.encode(toMap());

  factory SettingEntity.fromJson(final Box<dynamic> source) {
    try {
      return SettingModel.fromMap(
          json.decode(source.get(key)) as Map<String, dynamic>);
    } catch (e) {
      return const SettingEntity();
    }
  }

  Future<void> save() async =>
      await writeToMemory<String>(key, json.encode(toMap()));

  SettingEntity copyWith({
    String? username,
    String? password,
    String? remoteIp,
    String? remotePort,
    Duration? liveDataInterval,
    Duration? dailyFigureInterval,
    Duration? graphFigureInterval,
    Duration? logsInterval,
  }) {
    return SettingEntity(
      username: username ?? this.username,
      password: password ?? this.password,
      remoteIp: remoteIp ?? this.remoteIp,
      remotePort: remotePort ?? this.remotePort,
      liveDataInterval: liveDataInterval ?? this.liveDataInterval,
      dailyFigureInterval: dailyFigureInterval ?? this.dailyFigureInterval,
      graphFigureInterval: graphFigureInterval ?? this.graphFigureInterval,
      logsInterval: logsInterval ?? this.logsInterval,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        remoteIp,
        remotePort,
        liveDataInterval,
        dailyFigureInterval,
        graphFigureInterval,
        logsInterval,
      ];
}