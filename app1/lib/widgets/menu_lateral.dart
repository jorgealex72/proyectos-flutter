import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/login_screen.dart'; // Importamos la nueva pantalla de login

class MenuLateral extends StatelessWidget {
  final UserModel usuario;
  const MenuLateral({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Encabezado del menú (como el perfil del usuario)
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  usuario.displayName,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  usuario.username,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          // Opción 1: Inicio
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context); // Cierra el menú
            },
          ),
          const Divider(), // Una línea separadora
          // Opción 2: Salir
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text(
              'Salir del Sistema',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Borra toda la pila de pantallas y pone el Login de nuevo
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Demo Home Page')),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
