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

  factory PPLiveDataModel.fromMap(final Map<String, dynamic> map) =>
      PPLiveDataModel(
        available: (map['aav'] as num).toDouble(),
        solarOuput: (map['soo'] as num).toDouble(),
        pcs: (map['pcs'] as num).toDouble(),
        generator: (map['gnr'] as num).toDouble(),
        batteryVoltage: (map['bvo'] as num).toDouble(),
        batteryCurrent: (map['boc'] as num).toDouble(),
        batteryCharge: (map['bch'] as num).toDouble(),
        batterEnergy: (map['ben'] as num).toDouble(),
        reportedAt: map['lup'] as String,
      );
}
