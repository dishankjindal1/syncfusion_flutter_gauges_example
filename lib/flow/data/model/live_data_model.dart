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
      available: map['available'] as double,
      solarOuput: map['solarOuput'] as double,
      pcs: map['pcs'] as double,
      generator: map['generator'] as double,
      batteryVoltage: map['batteryVoltage'] as double,
      batteryCurrent: map['batteryCurrent'] as double,
      batteryCharge: map['batteryCharge'] as double,
      batterEnergy: map['batterEnergy'] as double,
      reportedAt: DateTime.fromMillisecondsSinceEpoch(map['reportedAt'] as int),
    );
  }
}
