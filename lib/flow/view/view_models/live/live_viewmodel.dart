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

  return PPLiveDataModel.fromMap(decodedRes);
}
