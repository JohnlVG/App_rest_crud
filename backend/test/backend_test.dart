import 'package:test/test.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart'; // Paquete de JWT

void main() {
  test('Generación de token JWT', () {
    var jwt = JWT({'id': 123, 'username': 'testuser'});

    // Firma el token con una clave secreta
    var secretKey = 'tu_clave_secreta';
    var token = jwt.sign(SecretKey(secretKey));

    // Verifica si el token no es nulo
    expect(token, isNotNull);
  });
}
