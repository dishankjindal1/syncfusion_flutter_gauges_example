import 'package:pulgas_power/flow/domain/entity/daily_data_entity.dart';

class PPDailyDataModel extends PPDailyDataEntity {
  const PPDailyDataModel({
    required super.solarProduction,
    required super.renewableHours,
    required super.batteryCharge,
    required super.batteryDischarge,
    required super.sunHours,
    required super.generatorEnergy,
    required super.generatorHours,
    required super.generatorFuel,
    required super.consumption,
    required super.co2Saved,
    required super.co2Produced,
    required super.reportedAt,
  });

  factory PPDailyDataModel.fromMap(final Map<String, dynamic> map) =>
      PPDailyDataModel(
        solarProduction: (map['spr'] as num).toDouble(),
        renewableHours: (map['rhr'] as num).toDouble(),
        batteryCharge: (map['bch'] as num).toDouble(),
        batteryDischarge: (map['bdc'] as num).toDouble(),
        sunHours: (map['shr'] as num).toDouble(),
        generatorEnergy: (map['gen'] as num).toDouble(),
        generatorHours: (map['ghr'] as num).toDouble(),
        generatorFuel: (map['gfl'] as num).toDouble(),
        consumption: (map['con'] as num).toDouble(),
        co2Saved: (map['cos'] as num).toDouble(),
        co2Produced: (map['cop'] as num).toDouble(),
        reportedAt: map['lup'] as String,
      );
}
