import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'screens/login_screen.dart';

void main() {
  if (!kIsWeb) {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), // Note: Fixed .fromSeed to ColorScheme.fromSeed
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Demo Home Page'),
    );
  }
}
