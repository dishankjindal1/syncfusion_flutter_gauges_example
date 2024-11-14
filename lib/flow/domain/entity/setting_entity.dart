import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/data/model/setting_model.dart';

class SettingEntity extends Equatable with AppStorageMixin {
  static const key = 'SettingEntity';
  final String remoteIp;
  final String remotePort;
  final Duration liveDataInterval;
  final Duration dailyFigureInterval;
  final Duration graphFigureInterval;
  final Duration logsInterval;

  const SettingEntity({
    this.remoteIp = 'http://gastotal.dyndns.org',
    this.remotePort = '4833',
    this.liveDataInterval = const Duration(seconds: 30),
    this.dailyFigureInterval = const Duration(seconds: 30),
    this.graphFigureInterval = const Duration(seconds: 30),
    this.logsInterval = const Duration(seconds: 30),
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'remoteIp': remoteIp,
      'remotePort': remotePort,
      'liveDataInterval': liveDataInterval.inMilliseconds,
      'dailyFigureInterval': dailyFigureInterval.inMilliseconds,
      'graphFigureInterval': graphFigureInterval.inMilliseconds,
      'logsInterval': logsInterval.inMilliseconds,
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
    String? remoteIp,
    String? remotePort,
    Duration? liveDataInterval,
    Duration? dailyFigureInterval,
    Duration? graphFigureInterval,
    Duration? logsInterval,
  }) {
    return SettingEntity(
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
        remoteIp,
        remotePort,
        liveDataInterval,
        dailyFigureInterval,
        graphFigureInterval,
        logsInterval,
      ];
}
