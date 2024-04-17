import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  // Atributo para o email do usuário
  final String email;

  ConfiguracoesPage({required this.email});

  @override
  _ConfiguracoesPageState createState() =>
      _ConfiguracoesPageState(email: email);
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  // Atributos
  late SharedPreferences _prefs;
  bool _darkMode = false;
  final String email;
  List<String> _tarefas = [];

  _ConfiguracoesPageState({required this.email});

  // Métodos
  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _loadTarefas();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = _prefs.getBool('${email}darkMode') ?? false;
    });
  }

  Future<void> _loadTarefas() async {
    final List<String> tarefas = _prefs.getStringList('${email}tarefas') ?? [];
    setState(() {
      _tarefas = tarefas;
    });
  }

  Future<void> _salvarTarefas() async {
    await _prefs.setStringList('${email}tarefas', _tarefas);
  }

  void _adicionarTarefa(String tarefa) {
    setState(() {
      _tarefas.add(tarefa);
    });
    _salvarTarefas();
  }

  void _editarTarefa(int index, String novaTarefa) {
    setState(() {
      _tarefas[index] = novaTarefa;
    });
    _salvarTarefas();
  }

  void _excluirTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
    _salvarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _darkMode ? ThemeData.dark() : ThemeData.light(),
      duration: Duration(milliseconds: 500),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gerenciamento de Tarefas'),
          actions: [
            Switch(
              value: _darkMode,
              onChanged: (value) {
                _mudarDarkMode();
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: _tarefas.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_tarefas[index]),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botão para editar a tarefa
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _mostrarDialogoEditarTarefa(context, index);
                    },
                  ),
                  // Botão para excluir a tarefa
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _excluirTarefa(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _mostrarDialogoAdicionarTarefa(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  void _mostrarDialogoAdicionarTarefa(BuildContext context) {
    TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Tarefa'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Digite a tarefa',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _adicionarTarefa(controller.text);
                Navigator.pop(context);
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarDialogoEditarTarefa(BuildContext context, int index) {
    TextEditingController controller = TextEditingController();
    controller.text = _tarefas[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Digite a tarefa',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _editarTarefa(index, controller.text);
                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _mudarDarkMode() async {
    setState(() {
      _darkMode = !_darkMode;
    });
    await _prefs.setBool('${email}darkMode', _darkMode);
  }
}
