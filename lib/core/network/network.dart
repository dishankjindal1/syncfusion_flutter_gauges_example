import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/core/network/refreh_token_mechanism.dart';
import 'package:pulgas_power/flow/view/view_models/setting/setting_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'network.g.dart';

@riverpod
Dio networkHandler(Ref ref) {
  final remoteIp = ref.watch(settingViewModelProvider).remoteIp;
  final remotePort = ref.watch(settingViewModelProvider).remotePort;

  final dio = Dio(BaseOptions(baseUrl: '$remoteIp:$remotePort/gond/req.php'));
  dio.interceptors.addAll(<Interceptor>[
    RefreshTokenMechanism(dio),
    if (kDebugMode)
      LogInterceptor(
        logPrint: (final data) => debugPrint(data.toString()),
        responseBody: true,
        requestBody: true,
      ),
  ]);
  return dio;
}
