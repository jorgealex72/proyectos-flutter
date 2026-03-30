import 'package:flutter/material.dart';
import '../widgets/menu_lateral.dart';
import '../models/user_model.dart';

class VentanaPrincipal extends StatelessWidget {
  final UserModel usuario;
  const VentanaPrincipal({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel de Control'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // Aquí llamamos al archivo separado del menú
      drawer: MenuLateral(usuario: usuario),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 80, color: Colors.green),
            SizedBox(height: 20),
            Text(
              '¡Bienvenido al Sistema! ${usuario.displayName}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            Text('Acceso concedido exitosamente'),
          ],
        ),
      ),
    );
  }
}
