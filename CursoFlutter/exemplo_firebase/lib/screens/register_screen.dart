import 'package:flutter/material.dart';
import 'package:exemplo_firebase/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _service = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  'Registro',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cor do texto
                  ),
                ),
                SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white), // Cor do texto
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.white70), // Cor do label
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando não está focado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando está focado
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira um e-mail';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  style: TextStyle(color: Colors.white), // Cor do texto
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.white70), // Cor do label
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando não está focado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando está focado
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Insira uma senha';
                    }
                    return null;
                  },
                  obscureText: true, // Texto escondido para senha
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _confirmedPasswordController,
                  style: TextStyle(color: Colors.white), // Cor do texto
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    labelStyle: TextStyle(color: Colors.white70), // Cor do label
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando não está focado
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Cor da borda quando está focado
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirme sua senha';
                    }
                    return null;
                  },
                  obscureText: true, // Texto escondido para senha
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registrarUsuario();
                    }
                  },
                  child: Text(
                    'Registrar',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16), // Tamanho do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Borda arredondada
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Cor do texto do botão
                    padding: EdgeInsets.symmetric(horizontal: 100, vertical: 16), // Tamanho do botão
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Borda arredondada
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registrarUsuario() async {
    if (_passwordController.text == _confirmedPasswordController.text) {
      try {
        await _service.registerUsuario(
          _emailController.text,
          _confirmedPasswordController.text,
        );
        // Navegação para página de login
        Navigator.pushNamed(context, '/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao registrar: ${e.toString()}',
              style: TextStyle(color: Colors.white), // Cor do texto
            ),
            backgroundColor: Colors.red, // Cor de fundo do SnackBar
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'As senhas não conferem!',
            style: TextStyle(color: Colors.white), // Cor do texto
          ),
          backgroundColor: Colors.red, // Cor de fundo do SnackBar
        ),
      );
      _passwordController.clear();
      _confirmedPasswordController.clear();
    }
  }
}
