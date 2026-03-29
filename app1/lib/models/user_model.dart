class UserModel {
  final int? id;
  final String username;
  final String passwordHash; // ¡NUNCA guardes la clave en texto plano!
  final String displayName;

  UserModel({
    this.id,
    required this.username,
    required this.passwordHash,
    required this.displayName,
  });

  // Convierte un Mapa de la DB a un objeto Dart
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      passwordHash: map['password_hash'],
      displayName: map['display_name'],
    );
  }

  // Convierte un objeto Dart a un Mapa para la DB
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password_hash': passwordHash,
      'display_name': displayName,
    };
  }
}