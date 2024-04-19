import 'package:flutter/material.dart';
import 'package:sa3_somativa/Model/Usuario.dart'; // Importa a classe Usuario do arquivo de modelo
import '../Controller/BancoDados.dart'; // Importa o arquivo BancoDados.dart do controlador

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState(); // Cria o estado da página de cadastro
}

class _CadastroState extends State<Cadastro> {
  final _formKey = GlobalKey<FormState>(); // Chave global para o formulário
  TextEditingController _nomeController = TextEditingController(); // Controller para o campo de nome
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController(); // Controller para o campo de senha

  // Método para cadastrar um usuário
  Future<void> cadastrarUsuario(BuildContext context) async {
    String name = _nomeController.text; // Obtém o nome do campo de texto
    String email = _emailController.text;
    String password = _senhaController.text; // Obtém a senha do campo de texto

    // Cria um objeto Usuario com os dados inseridos
    Usuario usuario = Usuario(nome: name, email: email, senha: password);

    // Instancia um objeto BancoDadosCrud para interagir com o banco de dados
    BancoDadosCrud bancoDados = BancoDadosCrud();
    try {
      // Verifica se o email já existe antes de cadastrar
      bool emailExists = await bancoDados.existsEmail(email);
      if (emailExists) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Este e-mail já está sendo usado')),
        );
        return; // Encerra a função se o email já existir
      }

      // Tenta criar um novo usuário no banco de dados
      await bancoDados.create(usuario);

      // Exibe uma mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuário cadastrado com sucesso!')),
      );

      // Redireciona para a tela de login após o cadastro bem-sucedido
      Navigator.pop(context);
    } catch (e) {
      // Exibe uma mensagem de erro se ocorrer algum problema durante o cadastro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página de Cadastro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cadastro',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira seu nome';
                    }
                    if (!RegExp(r'^[a-zA-ZÀ-ú-\s]+$').hasMatch(value!)) {
                      return 'Nome inválido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira seu e-mail';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cadastrarUsuario(context);
                    }
                  },
                  child: Text('Cadastrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
