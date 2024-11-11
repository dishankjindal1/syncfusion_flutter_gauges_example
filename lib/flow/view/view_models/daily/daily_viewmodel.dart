import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/domain/entity/daily_data_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'daily_viewmodel.g.dart';

@riverpod
Future<PPDailyDataEntity> dailyViewModel(Ref ref) async {
  await Future.delayed(const Duration(seconds: 2));

  return PPDailyDataEntity(
    solarProduction: 2424,
    renewableHours: 6.1,
    batteryCharge: -1533,
    batteryDischarge: 36,
    sunHours: 4.7,
    generatorEnergy: 1091,
    generatorHours: 8.5,
    generatorFuel: 326,
    consumption: 2104,
    co2Saved: 2.545,
    co2Produced: 0.860,
    reportedAt: DateTime.now(),
  );
}
