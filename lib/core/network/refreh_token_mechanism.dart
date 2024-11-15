import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pulgas_power/core/auth/auth_data.dart';
import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';

@immutable
class RefreshTokenMechanism extends QueuedInterceptor with AppStorageMixin {
  RefreshTokenMechanism(this._dio);

  final Dio _dio;

  @override
  Future<void> onError(
    final DioException err,
    final ErrorInterceptorHandler handler,
  ) async {
    try {
      final authData = getRef<AuthData>();
      if (err.response?.data['Result'] == '-1') {
        /// Shuffle the tokens
        final cred = await authData.shuffleTokens();

        /// Replace the old token with the new token
        err.requestOptions.queryParameters
          ..remove('k')
          ..addAll({'k': '${cred.aKey}'});

        return handler.resolve(await _dio.fetch(err.requestOptions));
      }
      return handler.next(err);
    } catch (e) {
      return handler.next(err);
    }
  }
}
