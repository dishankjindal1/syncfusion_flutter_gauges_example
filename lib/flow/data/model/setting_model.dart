import 'package:pulgas_power/flow/domain/entity/setting_entity.dart';

class SettingModel extends SettingEntity {
  static const key = 'SettingModel';

  const SettingModel({
    required super.username,
    required super.password,
    required super.remoteIp,
    required super.remotePort,
    required super.liveDataInterval,
    required super.dailyFigureInterval,
    required super.graphFigureInterval,
    required super.logsInterval,
  });

  factory SettingModel.fromMap(final Map<String, dynamic> map) {
    return SettingModel(
      username: map['username'] != null ? map['username'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      remoteIp: map['remoteIp'] != null ? map['remoteIp'] as String : null,
      remotePort:
          map['remotePort'] != null ? map['remotePort'] as String : null,
      liveDataInterval: map['liveDataInterval'] != null
          ? Duration(milliseconds: map['liveDataInterval'] as int)
          : null,
      dailyFigureInterval: map['dailyFigureInterval'] != null
          ? Duration(milliseconds: map['dailyFigureInterval'] as int)
          : null,
      graphFigureInterval: map['graphFigureInterval'] != null
          ? Duration(milliseconds: map['graphFigureInterval'] as int)
          : null,
      logsInterval: map['logsInterval'] != null
          ? Duration(milliseconds: map['logsInterval'] as int)
          : null,
    );
  }
}
