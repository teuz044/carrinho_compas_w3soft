class Item {
  final String nome;
  final double valor;
  final String imageUrl;

  Item({required this.nome, required this.valor, required this.imageUrl});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      nome: json['nome'],
      valor: json['valor'],
      imageUrl: json['imageUrl'],
    );
  }
}
