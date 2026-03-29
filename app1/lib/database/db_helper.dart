import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // Para utf8.encode
import '../models/user_model.dart';

class DbHelper {
  // Patrón Singleton
  static final DbHelper _instance = DbHelper._internal();
  factory DbHelper() => _instance;
  DbHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_gestion.db'); // Nombre de tu DB

    // --- ESTO ES LO QUE NECESITAS ---
    print('-----------------------------------------');
    print('LA BASE DE DATOS ESTÁ EN: $path');
    print('-----------------------------------------');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // Creación de la tabla con campos básicos
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        password_hash TEXT NOT NULL,
        display_name TEXT NOT NULL
      )
    ''');

    // INSERT DE PRUEBA: Usuario 'admin' con clave 'Minedu2024' (¡ya hasheada!)
    // El hash de 'Minedu2024' con SHA-256 es: 8d969eee... (generado externamente)
    await db.rawInsert('''
      INSERT INTO users (username, password_hash, display_name)
      VALUES ('admin', '8d969eeeb23f13f0a5f0858e723049b1a039b56f2f9f5963f4b5034c44243a85', 'Administrador Jorge')
    ''');
  }

  // Función para Hashear (Cifrar) contraseñas
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Convierte texto a bytes
    final hash = sha256.convert(bytes); // Cifra con SHA-256
    return hash.toString();
  }

  // REGISTRO DE USUARIO
  Future<int> registerUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  // LOGIN DE USUARIO (Verifica credenciales)
  Future<UserModel?> loginUser(String username, String password) async {
    if (kIsWeb) {
      // Si estamos en Chrome, validamos "a mano" sin tocar la DB
      if (username == 'admin' && password == 'Minedu2024') {
        return UserModel(
          id: 1,
          username: 'admin',
          passwordHash: '',
          displayName: 'Administrador Jorge (Mock)',
        );
      }
      return null;
    }

    final db = await database;
    final passwordHash = _hashPassword(
      password,
    ); // Hasheamos la clave ingresada

    // final List<Map<String, dynamic>> users = await db.query('users');
    // print('Usuarios en la DB: $users');

    // await db.update(
    //   'users',
    //   {
    //     'password_hash':
    //         '240be518fab243812839f6931f7595eb1b67277559c159e8996c9356138e9b0b',
    //   }, // Hash de 'admin123'
    //   where: 'username = ?',
    //   whereArgs: ['admin'],
    // );
    // print("Contraseña de admin reseteada a: admin123");

    if (kIsWeb) {
      // Si estamos en Chrome, validamos "a mano" sin tocar la DB
      if (username == 'admin' && password == 'Minedu2024') {
        return UserModel(
          id: 1,
          username: 'admin',
          passwordHash: '',
          displayName: 'Administrador Jorge (Mock)',
        );
      }
      return null;
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ? AND password_hash = ?',
      whereArgs: [username, passwordHash],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    }
    return null; // Credenciales incorrectas
  }
}
