import 'package:flutter/material.dart';
import 'ventana_principal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // --- AUDITORES DE DATOS (Controllers) ---
  // Estos objetos capturan lo que se escribe en las cajas de texto
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    // Es buena práctica "liquidar" los controladores al cerrar la pantalla
    // para no malgastar recursos de memoria.
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              // --- ESTA ES LA CLAVE ---
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tu encabezado
                  const Text(
                    'Bienvenido al Sistema de Gestión',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),

                  // 1. Campo de Usuario con bordes más redondeados
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      filled: true, // Le da un color de fondo suave
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ), // Bordes redondeados
                      ),
                      labelText: 'Nombre de usuario',
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // 2. Campo de Password
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 3. Botón Ingresar más estilizado
                  SizedBox(
                    width: double
                        .infinity, // El botón ocupa todo el ancho de los 400px
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        // ... tu lógica de validación
                        // --- LÓGICA DE VALIDACIÓN ---
                        String user = _userController.text;
                        String pass = _passwordController.text;

                        if (user == "admin" && pass == "admin") {
                          // Acceso concedido: Navegamos a la otra pantalla
                          _userController.clear();
                          _passwordController.clear();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VentanaPrincipal(),
                            ),
                          );
                        } else {
                          // Acceso denegado: Mostramos error
                          _passwordController.clear();
                          FocusScope.of(context).requestFocus(FocusNode());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Credenciales incorrectas'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 5, // Un poco de sombra para que resalte
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   label: const Text('Incrementar'),
      //   icon: const Icon(Icons.add),
      // ),
    );
  }
}
