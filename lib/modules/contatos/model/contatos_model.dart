class ContatosModel {
  List<ContatosModel> listaContato = [];

  String? id = "";
  String? nome = "";
  String? telefone = "";
  String? endereco = "";
  String? cidade = "";
  String? aniversario = "";
  String? imagem = "";

  ContatosModel(
      {
      this.id,
      this.nome,
      this.telefone,
      this.endereco,
      this.cidade,
      this.aniversario,
      this.imagem}
      );

  ContatosModel.fromJson(Map<String, dynamic> json) {
    id = json['objectId'];
    nome = json['nome'];
    telefone = json['telefone'];
    endereco = json['endereco'];
    cidade = json['cidade'];
    aniversario = json['aniversario'];
    imagem = json['imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['objectId'] = id;
    data['nome'] = nome;
    data['telefone'] = telefone;
    data['endereco'] = endereco;
    data['cidade'] = cidade;
    data['aniversario'] = aniversario;
    data['imagem'] = imagem;

    return data;
  }

  mapFromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      listaContato = <ContatosModel>[];
      json['results'].forEach((v) {
        listaContato.add(ContatosModel.fromJson(v));
      });
    }
    return listaContato;
  }

  Map<String, dynamic> mapToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = listaContato.map((v) => v.toJson()).toList();
    return data;
  }
}
