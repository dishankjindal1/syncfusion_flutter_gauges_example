import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/data/model/live_data_model.dart';
import 'package:pulgas_power/flow/domain/entity/live_data_entity.dart';
import 'package:pulgas_power/flow/domain/enum/live_enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_data_pod.g.dart';

@riverpod
Future<List<PPLiveDataEntity>> liveData(Ref ref) async {
  final result = [
    for (final i in LiveDataType.values)
      {
        'type': i.name,
        'value': i.startRange + Random().nextInt(i.endRange - i.startRange),
        'stickyPoint': i.name.contains('BATTERY')
            ? i.startRange + Random().nextInt(i.endRange)
            : null
      }
  ];

  await Future.delayed(const Duration(seconds: 2));

  return result.map((e) => PPLiveDataModel.fromMap(e)).toList();
}
