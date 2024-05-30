class Produtos {
  final int id;
  final String nome;
  final String codigo;

  Produtos(this.id, this.nome, this.codigo);

  //métodos
  //toJson
  List<Map<String,dynamic>> toJson(){
    return [
      {
        'id': id,
        'nome': nome,
        'codigo': codigo
      }
    ];
  }

  //fromJson
  factory Produtos.fromJson(Map<String,dynamic> json){
    return Produtos(
      json['id'],
      json['nome'],
      json['codigo']
    );
  }
}