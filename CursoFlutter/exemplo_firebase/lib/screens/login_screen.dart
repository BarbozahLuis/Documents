import 'package:exemplo_firebase/screens/todolist_screen.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Cor de fundo da tela
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
              'Login',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Cor do texto
              ),
            ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white), // Cor do texto
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey[400]), // Cor do texto de dica
                    prefixIcon: Icon(Icons.email, color: Colors.white), // Ícone do email
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando não está focado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando está focado
                    ),
                  ),
                  validator: (value) {},
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white), // Cor do texto
                  obscureText: true, // Texto escondido para senha
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    hintStyle: TextStyle(color: Colors.grey[400]), // Cor do texto de dica
                    prefixIcon: Icon(Icons.lock, color: Colors.white), // Ícone da senha
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando não está focado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando está focado
                    ),
                  ),
                  validator: (value) {},
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _acessarTodoList();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16), backgroundColor: Colors.green, // Tamanho do botão
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Cor de fundo do botão
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User?> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      return await _auth.loginUsuario(
          _emailController.text, _passwordController.text);
    } else {
      return null;
    }
  }

  Future<void> _acessarTodoList() async {
    User? user = await _loginUser();
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TodolistScreen(user: user)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Usuário ou senha inválidos",
            style: TextStyle(color: Colors.white), // Cor do texto
          ),
          backgroundColor: Colors.red, // Cor de fundo do SnackBar
        ),
      );
      _emailController.clear();
      _passwordController.clear();
    }
  }
}
