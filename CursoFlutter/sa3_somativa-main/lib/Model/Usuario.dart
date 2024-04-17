class Usuario {
  //atributos
  String nome;
  String email;
  String senha;
  //construtor
  Usuario({required this.nome, 
        required this.email,
        required this.senha});

  // Método para criar um usuário a partir de um mapa
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }

  // Método para converter o usuário em um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }
}
