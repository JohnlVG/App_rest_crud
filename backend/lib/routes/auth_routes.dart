import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import '../models/user_model.dart';
import '../utils/auth_utils.dart';

final _router = Router()
  ..post('/register', registerHandler)
  ..post('/login', loginHandler);

// Registro de usuario
Future<Response> registerHandler(Request request) async {
  final payload = await request.readAsString();
  final data = json.decode(payload);

  final username = data['username'];
  final password = data['password'];

  if (username == null || password == null) {
    return Response.badRequest(body: 'Username and password are required');
  }

  final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
  final user = User(username: username, passwordHash: hashedPassword);

  // Guardar el usuario en la base de datos o en memoria
  // (Este es solo un ejemplo, debes agregar lógica para almacenar usuarios)

  return Response.ok(json.encode({'message': 'User registered successfully'}));
}

// Inicio de sesión
Future<Response> loginHandler(Request request) async {
  final payload = await request.readAsString();
  final data = json.decode(payload);

  final username = data['username'];
  final password = data['password'];

  if (username == null || password == null) {
    return Response.badRequest(body: 'Username and password are required');
  }

  // Buscar el usuario en la base de datos
  // (Este es solo un ejemplo, debes agregar lógica para verificar el usuario)

  final storedUser = User(username: 'example', passwordHash: BCrypt.hashpw('password123', BCrypt.gensalt()));

  if (storedUser.username == username && BCrypt.checkpw(password, storedUser.passwordHash)) {
    final jwt = JWT({'username': username});
    final token = jwt.sign(SecretKey('SECRET_KEY'));

    return Response.ok(json.encode({'message': 'Login successful', 'token': token}));
  } else {
    return Response.unauthorized('Invalid credentials');
  }
}

Router get authRouter => _router;
