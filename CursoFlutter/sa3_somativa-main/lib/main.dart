import 'package:flutter/material.dart';
import 'package:sa3_somativa/View/LoginView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SA3- Somativa",
      debugShowCheckedModeBanner: false,
      home: PaginaLogin(),
    
    );
  }
}
