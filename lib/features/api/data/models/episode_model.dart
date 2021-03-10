import 'package:irmao_do_jorel_app/features/api/data/models/link_model.dart';

import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  int id;
  String nome;
  String descricao;
  String sinopse;
  int temporadaId;
  List<dynamic> links;

  EpisodeModel({
    this.id,
    this.nome,
    this.descricao,
    this.sinopse,
    this.temporadaId,
    this.links,
  }) : super(
          id: id,
          nome: nome,
          descricao: descricao,
          sinopse: sinopse,
          temporadaId: temporadaId,
          links: links,
        );

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    sinopse = json['sinopse'];
    temporadaId = json['temporadaId'];
    if (json['links'] != null) {
      links = <LinkModel>[];
      json['links'].forEach(
        (l) {
          links.add(
            new LinkModel.fromJson(l),
          );
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['sinopse'] = this.sinopse;
    data['temporadaId'] = this.temporadaId;
    data['links'] = this.links;
    return data;
  }
}
