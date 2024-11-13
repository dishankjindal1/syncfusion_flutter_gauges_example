import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulgas_power/flow/domain/entity/logs_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logs_viewmodel.g.dart';

@Riverpod(keepAlive: true)
Future<PPLogsEntity> logsViewModel(
    final Ref ref, final int pageNumber, final int pageLimit) async {
  final result = PPLogsEntity(
    data: List.generate(
      pageLimit,
      (index) => (
        DateTime.now().toIso8601String(),
        'Error ${Random().nextInt(1000)}',
        pageNumber == 0
            ? 'DC Voltage High'
            : 'Generator #${(pageNumber * pageLimit) + index} started'
      ),
    ),
    reportedAt: DateTime.now(),
  );

  await Future.delayed(const Duration(seconds: 2));

  return result;
}
