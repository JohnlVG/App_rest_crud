import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:dotenv/dotenv.dart';
import 'package:shelf_cors/shelf_cors.dart';
import '../lib/routes/auth_routes.dart';

void main() async {
  // Cargar las variables de entorno
  dotenv.load();

  // Configurar las rutas del servidor
  final _router = Router()
    ..mount('/auth/', authRouter);  // Rutas para login y register

  final handler = const Pipeline()
      .addMiddleware(corsHeaders())  // Middleware para permitir solicitudes CORS
      .addHandler(_router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Server listening on http://${server.address.host}:${server.port}');
}
