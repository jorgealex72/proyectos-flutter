import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Encabezado del menú (como el perfil del usuario)
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_circle, size: 50, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  'Administrador',
                  style: TextStyle(color: Colors.white, fontSize: 18),
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
              // Cerramos el menú y volvemos a la pantalla de login (primera en la pila)
              Navigator.pop(context); // Cierra el drawer
              Navigator.pop(context); // Sale de la VentanaPrincipal al Login
            },
          ),
        ],
      ),
    );
  }
}
