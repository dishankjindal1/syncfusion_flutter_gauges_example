import 'package:pulgas_power/flow/domain/entity/live_data_entity.dart';
import 'package:pulgas_power/flow/domain/enum/live_enums.dart';

class PPLiveDataModel extends PPLiveDataEntity {
  const PPLiveDataModel({
    required super.type,
    required super.value,
    required super.reportedAt,
    super.stickyPoint,
  });

  factory PPLiveDataModel.fromMap(Map<String, dynamic> map) {
    return PPLiveDataModel(
      type: LiveDataType.fromString(map['type'] as String),
      value: map['value'] as int,
      stickyPoint:
          map['stickyPoint'] != null ? map['stickyPoint'] as int : null,
      reportedAt: DateTime.now(), //! Needs to be updated
    );
  }
}
