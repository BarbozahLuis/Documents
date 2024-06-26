import 'package:flutter/material.dart';

class Produto{
  //atributos
  String nome;
  double preco;
  String categoria;

  //construtor
  Produto({
    required this.nome,
    required this.preco,
    required this.categoria,
  });
  
  //métodos (fromJson/ toJson)
  Map<String,dynamic> toJson(){
    return {
      'nome': nome,
      'preco': preco,
      'categoria': categoria,
    };
  }
  factory Produto.fromJson(Map<String,dynamic> json){
    return Produto(
      nome: json['nome'],
      preco: json['preco'],
      categoria: json['categoria'],
    );
  }
}

