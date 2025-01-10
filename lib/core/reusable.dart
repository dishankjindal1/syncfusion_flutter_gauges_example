import 'dart:convert';

import 'package:crypto/crypto.dart';

class PProuterReuseable {
  static String? generatePasswordHash(
    final String? userName,
    final String? password,
  ) {
    if (userName == null || password == null) return null;

    final combinedString = '$userName:$password';

    // Convert the combined string to bytes and hash it using SHA-512
    final bytes = utf8.encode(combinedString);
    final hash = sha512.convert(bytes);

    // Convert the hash to an uppercase string
    return hash.toString().toUpperCase();
  }
}
