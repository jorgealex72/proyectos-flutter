import 'package:flutter/material.dart';
import 'menu_lateral.dart'; // Importamos el menú que creamos arriba

class VentanaPrincipal extends StatelessWidget {
  const VentanaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Control'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Aquí llamamos al archivo separado del menú
      drawer: const MenuLateral(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              '¡Bienvenido al Sistema!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text('Acceso concedido exitosamente'),
          ],
        ),
      ),
    );
  }
}
