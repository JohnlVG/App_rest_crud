import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// Función para verificar si un JWT es válido
bool verifyToken(String token) {
  try {
    final jwt = JWT.verify(token, SecretKey('SECRET_KEY'));
    return true;
  } catch (e) {
    return false;
  }
}
