
import 'package:flutter/material.dart';
import 'my_drawer.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Sistema"),
        // backgroundColor: Colors.indigo.shade800, 
        // foregroundColor: Colors.white,
        // elevation: 4,
      ),
      
      // El Drawer es el menú autoocultable
      drawer: const MyDrawer(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "¡Bienvenido al Sistema!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ]
        )
      )
    );
  }
}