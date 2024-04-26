import 'dart:convert';
import 'dart:io';

import 'package:projeto_json/Model/produtos_model.dart';

class ProdutoController{
  List<Produto> _produtos = [];

  List<Produto> get produtos{
    return _produtos;
  }

  //salvar produtos no json
  Future<void> salvarJson(Produto produto) async{
    final file = File('products.json');
    final jsonList = produto.map((produto) => produto.toJson()).toList();
    await file.writeAsString(json.encode(jsonList));
  }

  // carregar produtos do json
  Future<List<Produto>> carregarJson() async{
    try{
      final file = File('produtos.json');
      final jsonList = jsonDecode(await file.readAsString());
      _produtos = jsonList.map<Produto>((json) => Produto.fromJson(json)).toList();
    }catch (e) {
      //caso o arquivo nao exista ou ocorra um erro na leitura, nao faz nada
      _produtos = [];
    }
    return produtos;
  }
}