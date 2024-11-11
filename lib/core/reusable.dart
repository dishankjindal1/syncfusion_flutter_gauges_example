import 'dart:convert';

import 'package:crypto/crypto.dart';

class PProuterReuseable {
  String generatePasswordHash(String userName, String userPassword) {
    final combinedString = '$userName:$userPassword';

    // Convert the combined string to bytes and hash it using SHA-512
    final bytes = utf8.encode(combinedString);
    final hash = sha512.convert(bytes);

    // Convert the hash to an uppercase string
    return hash.toString().toUpperCase();
  }
}
