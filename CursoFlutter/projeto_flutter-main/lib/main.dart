import 'package:flutter/material.dart';

import 'ViewLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: LoginView(), // Definindo LoginView como a tela inicial
    );
  }
}
