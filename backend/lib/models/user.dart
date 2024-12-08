class User {
  final String username;
  final String passwordHash;

  User({required this.username, required this.passwordHash});

  // Para convertir un objeto User a un mapa JSON (para la base de datos o respuestas HTTP)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'passwordHash': passwordHash,
    };
  }

  // Crear un usuario desde un mapa JSON (cuando recibimos datos de una solicitud)
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      passwordHash: json['passwordHash'],
    );
  }
}
