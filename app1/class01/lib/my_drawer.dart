import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'info_page.dart';
import 'main.dart'; // Para el LoginPage
import 'time_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary,),
            child: const Center(
              child: Text("Menú Principal", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Inicio"),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/home') {
                print("Navegando a Inicio...");
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                    settings: const RouteSettings(name: '/home'),
                    ),
                );
              } else {
                print("Ya estás en Inicio, no se hará navegación.");
              }
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Info"),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/info'){
                print("Navegando a Info...");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InfoPage(),
                    settings: const RouteSettings(name: '/info'),
                  ),
                );
              } else {
                print("Ya estás en Info, cancelando recarga.");
              }
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.public),
            title: const Text("Reloj Mundial"),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/clock'){
                print("Navegando a Clock...");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TimePage(),
                    settings: const RouteSettings(name: '/clock'),
                  ),
                );
              } else {
                print("Ya estás en Info, cancelando recarga.");
              }
            },
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text("Salir", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}