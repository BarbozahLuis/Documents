import 'package:flutter/material.dart';
import 'package:projeto_apirest/View/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      routes: (context){
        '/home': HomeScreen(),
        '/lista': ListaScreen()
      },
    );
  }
}
