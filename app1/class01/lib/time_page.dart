import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'my_drawer.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  // Lista de ciudades y sus TimeZones para la API
  final Map<String, String> _ciudades = {
    'Lima': 'America/Lima',
    'Madrid': 'Europe/Madrid',
    'Santo Domingo': 'America/Santo_Domingo',
    'Tokio': 'Asia/Tokyo',
  };

  String? _ciudadSeleccionada;
  String _horaResultado = "Selecciona una ciudad";
  bool _cargando = false;

  Future<void> _obtenerHora(String zona) async {
    setState(() => _cargando = true);
    final url = Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$zona');

    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        final data = json.decode(respuesta.body);
        setState(() {
          // Extraemos la hora y la zona horaria del JSON
          _horaResultado = "${data['time']} \n Zona: ${data['timeZone']}";
        });
      } else {
        setState(() => _horaResultado = "Error al obtener hora");
      }
    } catch (e) {
      setState(() => _horaResultado = "Sin conexión");
    } finally {
      setState(() => _cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reloj Mundial")),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time_filled, size: 80, color: Colors.indigo),
            const SizedBox(height: 30),
            
            // EL COMBOBOX (DropdownButton)
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Selecciona una ciudad",
                border: OutlineInputBorder(),
              ),
              value: _ciudadSeleccionada,
              items: _ciudades.keys.map((String ciudad) {
                return DropdownMenuItem(value: ciudad, child: Text(ciudad));
              }).toList(),
              onChanged: (nuevoValor) {
                setState(() => _ciudadSeleccionada = nuevoValor);
                _obtenerHora(_ciudades[nuevoValor]!);
              },
            ),

            const SizedBox(height: 40),
            
            // MOSTRAR RESULTADO
            _cargando 
              ? const CircularProgressIndicator() 
              : Text(
                  _horaResultado,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
          ],
        ),
      ),
    );
  }
}