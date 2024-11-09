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

  factory PPDailyDataModel.fromMap(Map<String, dynamic> map) =>
      PPDailyDataModel(
        solarProduction: map['solarProduction'] as double,
        renewableHours: map['renewableHours'] as double,
        batteryCharge: map['batteryCharge'] as double,
        batteryDischarge: map['batteryDischarge'] as double,
        sunHours: map['sunHours'] as double,
        generatorEnergy: map['generatorEnergy'] as double,
        generatorHours: map['generatorHours'] as double,
        generatorFuel: map['generatorFuel'] as double,
        consumption: map['consumption'] as double,
        co2Saved: map['co2Saved'] as double,
        co2Produced: map['co2Produced'] as double,
        reportedAt:
            DateTime.fromMillisecondsSinceEpoch(map['reportedAt'] as int),
      );
}
