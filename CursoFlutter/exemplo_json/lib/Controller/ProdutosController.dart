import 'dart:convert';

import 'package:exemplo_json/Model/ProdutoModel.dart';
import 'package:flutter/services.dart';

class ProdutoController{
  //atributos
 final List<Produto> _produtos = [];

 List<Produto>get produtos => _produtos;

  // Método para carregar produtos do arquivo JSON
  Future<void> loadProdutos() async {

    // Carrega o conteúdo do arquivo JSON da pasta assets
    final data = await rootBundle.loadString('assets/produtos.json');

    // Decodifica o conteúdo JSON em uma lista dinâmica
    final jsonList = json.decode(data) as List<dynamic>;
    _produtos.clear();
    
    // Converte os objetos JSON em instâncias de Produto e adiciona à lista de produtos
    _produtos.addAll(jsonList.map((e) => Produto.fromJson(e)));
  }

  adicionarProduto() {}

}

