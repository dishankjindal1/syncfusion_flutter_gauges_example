import 'package:jwt_decode/jwt_decode.dart';

class AuthData {
  String? aKey;
  AuthData({
    this.aKey,
  });

  bool get isAuthorized => aKey != null ? Jwt.isExpired(aKey!) : false;

  AuthData copyWith({
    String? aKey,
  }) {
    return AuthData(
      aKey: aKey ?? this.aKey,
    );
  }
}
