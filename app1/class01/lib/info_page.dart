import 'package:flutter/material.dart';
import 'my_drawer.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Información del Programador"),
        // backgroundColor: Colors.indigo.shade800,
        // foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Esto cierra la página de Info y vuelve al Inicio
          },
        ),
      ),

      // AQUÍ AGREGAMOS EL MENÚ
      drawer: const MyDrawer(),

      body: Center( 
        child: SingleChildScrollView( // Por si la pantalla es pequeña
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                _infoItem("Nombre", "Jorge Sánchez"),
                _infoItem("Rol", "Desarrollador Flutter"),
                _infoItem("Proyecto", "Control de Acceso v1.0"),
                const Divider(),
                const SizedBox(height: 10),
                const Text(
                  "Notas de desarrollo:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const Text("Aplicación reestructurada para mayor orden y escalabilidad."),
              ],
            ),
          ),
        )
      )
    );
  }

  Widget _infoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centra el texto de la fila
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}