import 'package:equatable/equatable.dart';

import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';

class PPLogsEntity extends Equatable with AppStorageMixin {
  final List<(String, String, String)> data;
  final String reportedAt;

  const PPLogsEntity({
    required this.data,
    required this.reportedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toList(),
      'lup': reportedAt,
    };
  }

  @override
  List<Object?> get props => [
        ...data,
        reportedAt,
      ];
}
