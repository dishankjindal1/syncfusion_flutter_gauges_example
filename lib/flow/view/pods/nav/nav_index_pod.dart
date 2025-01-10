import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nav_index_pod.g.dart';

@riverpod
class NavIndexPod extends _$NavIndexPod {
  void updateIndex(final int index) => state = index;

  @override
  int build() {
    return 0;
  }
}
