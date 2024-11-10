import 'package:pulgas_power/flow/domain/entity/live_data_entity.dart';

class PPLiveDataModel extends PPLiveDataEntity {
  const PPLiveDataModel({
    required super.available,
    required super.solarOuput,
    required super.pcs,
    required super.generator,
    required super.batteryVoltage,
    required super.batteryCurrent,
    required super.batteryCharge,
    required super.batterEnergy,
    required super.reportedAt,
  });

  factory PPLiveDataModel.fromMap(Map<String, dynamic> map) {
    return PPLiveDataModel(
      available: map['avv'] as double,
      solarOuput: map['soo'] as double,
      pcs: map['pcs'] as double,
      generator: map['gnr'] as double,
      batteryVoltage: map['bvo'] as double,
      batteryCurrent: map['boc'] as double,
      batteryCharge: map['bch'] as double,
      batterEnergy: map['ben'] as double,
      reportedAt: DateTime.fromMillisecondsSinceEpoch(map['lup'] as int),
    );
  }
}
