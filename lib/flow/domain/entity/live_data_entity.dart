import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:pulgas_power/flow/domain/enum/live_enums.dart';

class PPLiveDataEntity extends Equatable {
  const PPLiveDataEntity({
    required this.type,
    required this.value,
    required this.reportedAt,
    this.stickyPoint,
  });

  final LiveDataType type;
  final int value;
  final int? stickyPoint;
  final DateTime reportedAt;

  String get valueWithSymbol => '$value ${type.unitType.symbol}';
  String get displayReportedAt =>
      DateFormat('dd-MM-yyyy hh:mm:ss').format(reportedAt);

  Map<String, dynamic> toMap() => {
        'type': type.name,
        'value': value,
        'reportedAt': reportedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        type,
        value,
      ];
}
