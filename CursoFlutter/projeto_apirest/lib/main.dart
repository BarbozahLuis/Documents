import 'package:flutter/material.dart';
import 'package:projeto_apirest/Screen/cadastrar_produto_screen.dart';
import 'package:projeto_apirest/Screen/home_screen.dart';
import 'package:projeto_apirest/Screen/listar_produtos_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projeto APIRest JSON',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/listar':(context) => const ListarProdutosScreen(),
        '/cadastrar':(context) => const CadastrarProdutoScreen()
      },
    );
  }
}
