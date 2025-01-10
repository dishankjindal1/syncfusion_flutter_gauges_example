import 'package:pulgas_power/flow/domain/entity/setting_entity.dart';

class SettingModel extends SettingEntity {
  const SettingModel({
    required super.remoteIp,
    required super.remotePort,
    required super.liveDataInterval,
    required super.dailyFigureInterval,
    required super.graphFigureInterval,
    required super.logsInterval,
  });

  factory SettingModel.fromMap(final Map<String, dynamic> map) {
    return SettingModel(
      remoteIp: map['remoteIp'] as String,
      remotePort: map['remotePort'] as String,
      liveDataInterval: Duration(milliseconds: map['liveDataInterval'] as int),
      dailyFigureInterval:
          Duration(milliseconds: map['dailyFigureInterval'] as int),
      graphFigureInterval:
          Duration(milliseconds: map['graphFigureInterval'] as int),
      logsInterval: Duration(milliseconds: map['logsInterval'] as int),
    );
  }
}
