import 'dart:convert';

import 'package:exemplo_json2/Model/livros_Model.dart';
import 'package:flutter/services.dart';

class LivroController {
    List<Livro> livros = [];
    
    Future<List<Livro>> loadLivros() async {
      final data = await rootBundle.loadString("assets/livros.json");
      final listLivros = json.decode(data).toString() as List<dynamic>;
      livros.clear();
      livros.addAll(listLivros.map((e) => Livro.fromJson(e)));


      return livros;
    }

}