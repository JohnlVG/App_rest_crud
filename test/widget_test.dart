// backend/bin/server.dart

import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart';
import 'routes/auth_routes.dart';

void main() async {
  final dotenv = Dotenv()..load();

  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final router = getAuthRoutes(); // Usar las rutas de autenticación

  final handler = const Pipeline().addMiddleware(logRequests()).addHandler(router);

  final server = await io.serve(handler, ip, port);
  print('Servidor escuchando en http://${server.address.host}:${server.port}');
}
