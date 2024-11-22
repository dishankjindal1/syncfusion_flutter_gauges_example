import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/network/network.dart';
import 'package:pulgas_power/di.dart';
import 'package:pulgas_power/flow/data/model/daily_data_model.dart';
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

  return PPDailyDataModel.fromMap(decodedRes);
}
