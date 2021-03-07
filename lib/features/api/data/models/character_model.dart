import 'package:irmao_do_jorel_app/features/api/domain/entities/character.dart';

class CharacterModel extends Character {
  int id;
  String nome;
  String imagemUrl;
  String categoria;
  String idade;
  String descricao;
  String frase;
  String biografia;
  String aparencia;
  String personalidade;

  CharacterModel({
    this.id,
    this.nome,
    this.imagemUrl,
    this.categoria,
    this.idade,
    this.descricao,
    this.frase,
    this.biografia,
    this.aparencia,
    this.personalidade,
  }) : super(
          id: id,
          nome: nome,
          imagemUrl: imagemUrl,
          categoria: categoria,
          idade: idade,
          descricao: descricao,
          frase: frase,
          biografia: biografia,
          aparencia: aparencia,
          personalidade: personalidade,
        );

  CharacterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    imagemUrl = json['imagemUrl'];
    categoria = json['categoria'];
    idade = json['idade'];
    descricao = json['descricao'];
    frase = json['frase'];
    biografia = json['biografia'];
    aparencia = json['aparencia'];
    personalidade = json['personalidade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['imagemUrl'] = this.imagemUrl;
    data['categoria'] = this.categoria;
    data['idade'] = this.idade;
    data['descricao'] = this.descricao;
    data['frase'] = this.frase;
    data['biografia'] = this.biografia;
    data['aparencia'] = this.aparencia;
    data['personalidade'] = this.personalidade;
    return data;
  }
}
