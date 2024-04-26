class Produto{
  //atributos

  int id;
  String nome;
  String descricao;
  double preco;
  int quantidade;
  String foto;
  List<String> categorias;

  //contrutor
  Produto({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.quantidade,
    required this.foto,
    required this.categorias,
  });

  //métodos tojson / fromjson
  Map<String, dynamic> toMap() =>{
  'id' : id,
  'nome' : nome,
  'descricao' : descricao,
  'preco' : preco,
  'quantidade' : quantidade,
  'foto' : foto,
  'categorias' : categorias,
  };

  factory Produto.fromJson(Map<String, dynamic> json) => Produto(
    id: json['id'],
    nome: json['nome'],
    descricao: json['descricao'],
    preco: json['preco'],
    quantidade: json['quantidade'],
    foto: json['foto'],
    categorias: json['categorias'],
  );

  map(Function(dynamic produto) param0) {}

}