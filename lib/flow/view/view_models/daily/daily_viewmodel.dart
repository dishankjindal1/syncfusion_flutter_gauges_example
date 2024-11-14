import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/network/network.dart';
import 'package:pulgas_power/di.dart';
import 'package:pulgas_power/flow/domain/entity/daily_data_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'daily_viewmodel.g.dart';

@Riverpod(keepAlive: true)
Future<PPDailyDataEntity> dailyViewModel(Ref ref) async {
  final network = ref.read(networkHandlerProvider);

  final res = await network.get('?a=ADAILY', queryParameters: {
    'k': '${getIt<AuthData>().aKey}',
  });

  final decodedRes = json.decode(res.data) as Map<String, dynamic>;

  final result = <String, dynamic>{
    'solarProduction': num.parse(decodedRes['spr']).toDouble(),
    'renewableHours': num.parse(decodedRes['rhr']).toDouble(),
    'batteryCharge': num.parse(decodedRes['bch']).toDouble(),
    'batteryDischarge': num.parse(decodedRes['bdc']).toDouble(),
    'sunHours': num.parse(decodedRes['shr']).toDouble(),
    'generatorEnergy': num.parse(decodedRes['gen']).toDouble(),
    'generatorHours': num.parse(decodedRes['ghr']).toDouble(),
    'generatorFuel': num.parse(decodedRes['gfl']).toDouble(),
    'consumption': num.parse(decodedRes['con']).toDouble(),
    'co2Saved': num.parse(decodedRes['cos']).toDouble(),
    'co2Produced': num.parse(decodedRes['cop']).toDouble(),
    'reportedAt': DateTime.now().millisecondsSinceEpoch,
  };

  return PPDailyDataModel.fromMap(result);
}
