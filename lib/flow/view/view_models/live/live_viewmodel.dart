import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/network/network.dart';
import 'package:pulgas_power/di.dart';
import 'package:pulgas_power/flow/data/model/live_data_model.dart';
import 'package:pulgas_power/flow/domain/entity/live_data_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_viewmodel.g.dart';

@Riverpod(keepAlive: true)
Future<PPLiveDataEntity> liveViewModel(Ref ref) async {
  final network = ref.read(networkHandlerProvider);

  final res = await network.get('?a=ALIVE', queryParameters: {
    'k': '${getIt<AuthData>().aKey}',
  });

  final decodedRes = json.decode(res.data) as Map<String, dynamic>;

  final result = <String, dynamic>{
    'available': num.parse(decodedRes['aav']).toDouble(),
    'solarOuput': num.parse(decodedRes['soo']).toDouble(),
    'pcs': num.parse(decodedRes['pcs']).toDouble(),
    'generator': num.parse(decodedRes['gnr']).toDouble(),
    'batteryVoltage': num.parse(decodedRes['bvo']).toDouble(),
    'batteryCurrent': num.parse(decodedRes['boc']).toDouble(),
    'batteryCharge': num.parse(decodedRes['bch']).toDouble(),
    'batterEnergy': num.parse(decodedRes['ben']).toDouble(),
    'reportedAt': DateTime.now().millisecondsSinceEpoch,
  };

  return PPLiveDataModel.fromMap(result);
}
