class Episode {
  int id;
  String nome;
  String descricao;
  String sinopse;
  int temporadaId;
  List<dynamic> links;

  Episode({
    this.id,
    this.nome,
    this.descricao,
    this.sinopse,
    this.temporadaId,
    this.links,
  });
}
