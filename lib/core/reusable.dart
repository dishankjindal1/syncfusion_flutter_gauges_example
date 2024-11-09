import 'package:flutter/widgets.dart';

class PProuterReuseable {
  static final rightToLeftTransition =
      Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0));

// ignore: unused_element
  static final leftToRightTransition =
      Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0));

  static final bottomToUpTransition =
      Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0));

  static final topToBottomTransition =
      Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0));
}
