import 'package:flutter/material.dart';
import 'package:lista_compra/ComprasModel.dart';


class ComprasController extends ChangeNotifier {
  //lista de compra
  List<Compra> _compras = [];
  //getter para acessar a lista de compras
  List<Compra> get compras => _compras;

  //método para adicionar uma nova compra à lista
  void adicionarCompra(String descricao) {
  if (descricao.isNotEmpty) {
    // Verifica se a descrição já existe na lista
    bool jaExiste = _compras.any((compra) => compra.descricao == descricao);
    if (!jaExiste) {
      _compras.add(Compra(descricao, false));
      // Notifica os ouvintes (widgets) sobre a mudança no estado 
      notifyListeners();
    }
  }
}



  //método para marcar uma tarefa como concluida com base no índice
  void marcarComoConcluida(int indice){
    if (indice >= 0 && indice < _compras.length){
      _compras[indice].concluida = !_compras[indice].concluida ;
      //notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }
  //método para marcar uma tarefa como concluida com base no indice
  void excluirCompra(int indice){
    if (indice >= 0 && indice < _compras.length){
      _compras.removeAt(indice);
      //notifica os ouvintes sobre a mudança no estado
      notifyListeners();
    }
  }
  
}