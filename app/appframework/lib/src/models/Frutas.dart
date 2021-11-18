class Frutas {
  // ignore: non_constant_identifier_names
  int idfruta;
  String nome;
  double preco;
  String imagem;

  Frutas({
    // ignore: non_constant_identifier_names
    this.idfruta,
    this.nome,
    this.preco,
    this.imagem,
  });

  Frutas.fromJson(Map<String, dynamic> json) {
    idfruta = json['idfruta'];
    nome = json['nome'];
    preco = json['preco'];
    imagem = json['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idfruta'] = this.idfruta;
    data['nome'] = this.nome;
    data['preco'] = this.preco;
    data['imagem'] = this.imagem;

    return data;
  }
}
