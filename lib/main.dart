import 'package:flutter/material.dart';
import 'package:mi_segunda_app/features/home/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Libros y Películas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 101, 194)),
      ),
      home: const HomeScreen(),
    );
  }
}