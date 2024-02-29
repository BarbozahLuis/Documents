import 'package:app_todolist/tarefasModel.dart';
import 'package:flutter/material.dart';

class TarefasController extends ChangeNotifier{
  //Lista de tarefas
  List<Tarefa> _tarefas = [];
  //getter para acessar a lisra de tarefas
  List<Tarefa> get tarefas => _tarefas;

  //Método para adicionar uma nova tarefa à lista
  void adicionarTarefa(String descricao){
    if(descricao != ""){
    _tarefas.add(Tarefa(descricao, false));
    //notifica os ouvintes (widgets) sobre a mudança no estado
    notifyListeners();
  }}
  //método para marcar uma tarefa como concluida com base no índice
  void marcarComoConcluida(int indice){
    if (indice >= 0 && indice < _tarefas.length){
      _tarefas[indice].concluida = true;
      //notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

  //método para marcar uma tarefa como concluida com base no indice
  void excluirTarefa(int indice){
    if (indice >= 0 && indice < _tarefas.length){
      _tarefas.removeAt(indice);
      //notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }

}