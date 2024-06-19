import 'package:exemplo_firebase/controller/todolist_controller.dart';
import 'package:exemplo_firebase/models/todolist.dart';
import 'package:exemplo_firebase/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodolistScreen extends StatefulWidget {
  final User user;
  
  const TodolistScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  final AuthService _service = AuthService();
  final TodolistController _controller = TodolistController();
  final _tituloController = TextEditingController();
  
  // Método para carregar a lista de tarefas
  Future<void> _getList() async {
    try {
      await _controller.fetchList(widget.user.uid);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // Cor de fundo da tela
      appBar: AppBar(
        title: const Text('Lista de tarefas firebase'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _service.logoutUsuario();
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: _getList(),
                  builder: (context, snapshot) {
                    if (_controller.list.isNotEmpty) {
                      return ListView.builder(
                        itemCount: _controller.list.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text(
                                _controller.list[index].titulo,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _showEditDialog(_controller.list[index]);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () async {
                                      await _controller.delete(_controller.list[index].id);
                                      _getList();
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      return const Center(
                        child: Text(
                  'Adicione uma tarefa',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Cor do texto
                  ),
                ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Nova Tarefa"),
                content: TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(hintText: "Digite a tarefa"),
                ),
                actions: [
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 255, 255), backgroundColor: Colors.green, // foreground/text
                    ),
                    child: const Text("Cancelar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 255, 255, 255), backgroundColor: Colors.green, // foreground/text
                    ),
                    child: const Text("Salvar"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Todolist add = Todolist(
                        id: _controller.list.length.toString(),
                        titulo: _tituloController.text,
                        userId: widget.user.uid,
                        timestamp: DateTime.now(),
                      );
                      _controller.add(add);
                      _getList();
                      setState(() {});
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _showEditDialog(Todolist task) {
    _tituloController.text = task.titulo;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Editar Tarefa"),
          content: TextFormField(
            controller: _tituloController,
            decoration: const InputDecoration(hintText: "Digite a tarefa"),
          ),
          actions: [
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // foreground/text
              ),
              child: const Text("Salvar"),
              onPressed: () {
                Navigator.of(context).pop();
                Todolist edit = Todolist(
                  id: task.id,
                  titulo: _tituloController.text,
                  userId: task.userId,
                  timestamp: DateTime.now(),
                );
                _controller.edit(edit);
                _getList();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
}
