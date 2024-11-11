import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nav_viewmodel.g.dart';

@riverpod
class NavViewModel extends _$NavViewModel {
  void updateIndex(final int index) => state = index;

  @override
  int build() {
    return 0;
  }
}
