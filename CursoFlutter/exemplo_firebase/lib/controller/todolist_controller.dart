import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/todolist.dart';

class TodolistController {
  // Atributo list
  List<Todolist> _list = [];
  List<Todolist> get list => _list;

  // Conectar ao Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Método para adicionar uma nova tarefa
  Future<void> add(Todolist todolist) async {
    await _firestore.collection('todolist').add(todolist.toMap());
  }

  // Método para deletar uma tarefa existente
  Future<void> delete(String id) async {
    await _firestore.collection('todolist').doc(id).delete();
  }

  // Método para buscar a lista de tarefas de um usuário específico
  Future<List<Todolist>> fetchList(String userId) async {
    final QuerySnapshot result = await _firestore
        .collection('todolist')
        .where('userid', isEqualTo: userId)
        .get();
    List<dynamic> convert = result.docs as List;
    _list = convert.map((doc) => Todolist.fromMap(doc.data(), doc.id)).toList();
    return _list;
  }

  // Método para editar uma tarefa existente
  Future<void> edit(Todolist updatedTask) async {
    try {
      await _firestore
          .collection('todolist')
          .doc(updatedTask.id) // Referência ao documento da tarefa no Firestore
          .update(updatedTask.toMap()); // Atualiza os dados da tarefa
    } catch (e) {
      print('Erro ao atualizar tarefa: $e');
      throw Exception('Erro ao atualizar tarefa');
    }
  }
}
