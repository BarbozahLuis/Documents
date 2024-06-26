class ContatoModel{
  //atributo
  int id;
  String nome;
  String email;
  String telefone;
  String endereco;

  //construtor
  ContatoModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.telefone,
    required this.endereco,
  });

  //mapeamento
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
    };
  }


  factory ContatoModel.fromMap(Map<String, dynamic> map) {
    return ContatoModel(
      id: map['id'],
      nome: map['name'],
      email: map['email'],
      telefone: map['telefone'],
      endereco: map['endereco'],
    );
  }

}