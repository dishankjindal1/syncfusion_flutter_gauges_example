import 'dart:convert';

import 'package:crypto/crypto.dart';
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

  String generatePasswordHash(String userName, String userPassword) {
    final combinedString = '$userName:$userPassword';

    // Convert the combined string to bytes and hash it using SHA-512
    final bytes = utf8.encode(combinedString);
    final hash = sha512.convert(bytes);

    // Convert the hash to an uppercase string
    return hash.toString().toUpperCase();
  }
}
