import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/data/model/live_data_model.dart';
import 'package:pulgas_power/flow/domain/entity/live_data_entity.dart';
import 'package:pulgas_power/flow/domain/enum/live_enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_data_pod.g.dart';

@riverpod
Future<PPLiveDataEntity> liveData(Ref ref) async {
  final result = {
    'avv': LiveDataType.AVAILABLE.startRange +
        Random().nextInt((LiveDataType.AVAILABLE.endRange -
            LiveDataType.AVAILABLE.startRange).toInt()).toDouble(),
    'soo': LiveDataType.SOLAR_OUTPUT.startRange +
        Random().nextInt((LiveDataType.SOLAR_OUTPUT.endRange -
            LiveDataType.SOLAR_OUTPUT.startRange).toInt()),
    'pcs': LiveDataType.PCS.startRange +
        Random()
            .nextInt((LiveDataType.PCS.endRange - LiveDataType.PCS.startRange).toInt()),
    'gnr': LiveDataType.GENERATOR.startRange +
        Random().nextInt((LiveDataType.GENERATOR.endRange -
            LiveDataType.GENERATOR.startRange).toInt()),
    'bvo': LiveDataType.BATTERY_VOLTAGE.startRange +
        Random().nextInt((LiveDataType.BATTERY_VOLTAGE.endRange -
            LiveDataType.BATTERY_VOLTAGE.startRange).toInt()),
    'boc': LiveDataType.BATTERY_CURRENT.startRange +
        Random().nextInt((LiveDataType.BATTERY_CURRENT.endRange -
            LiveDataType.BATTERY_CURRENT.startRange).toInt()),
    'bch': LiveDataType.BATTERY_CHARGE.startRange +
        Random().nextInt((LiveDataType.BATTERY_CHARGE.endRange -
            LiveDataType.BATTERY_CHARGE.startRange).toInt()),
    'ben': LiveDataType.BATTERY_ENERGY.startRange +
        Random().nextInt((LiveDataType.BATTERY_ENERGY.endRange -
            LiveDataType.BATTERY_ENERGY.startRange).toInt()),
    'lup': DateTime.now().millisecondsSinceEpoch,
  };

  await Future.delayed(const Duration(seconds: 2));

  return PPLiveDataModel.fromMap(result);
}
