import 'dart:convert';

import 'package:pulgas_power/core/mixin/app_storage_mixin.dart';
import 'package:pulgas_power/flow/data/model/setting_model.dart';
import 'package:pulgas_power/flow/domain/entity/setting_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'setting_viewmodel.g.dart';

@riverpod
class SettingViewModel extends _$SettingViewModel with AppStorageMixin {
  SettingEntity entity = const SettingEntity();

  void update(final SettingEntity update) {
    state = update;
  }

  @override
  SettingEntity build() {
    try {
      final result = readFromMemory<String?>(SettingEntity.key);
      if (result == null) throw Exception();

      final decode = json.decode(result) as Map<String, dynamic>;

      return SettingModel.fromMap(decode);
    } catch (e) {
      return const SettingEntity();
    }
  }
}
