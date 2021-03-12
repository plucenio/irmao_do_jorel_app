import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/core/errors/exceptions.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/episode_model.dart';

class JorelsBrotherDatasource implements IJorelsBrotherDatasource {
  final Dio httpClient = Modular.get<Dio>();

  @override
  Future<List<CharacterModel>> getCharacters() async {
    var url =
        "https://cors-anywhere.herokuapp.com/http://www.irmaodojorelapi.site/api/Personagem";
    var response = await httpClient
        .get(
          url,
          options: Options(
              headers: {'Content-Type': 'application/json; charset=UTF-8'}),
        )
        .timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      if (response.data is List) {
        return (response.data as List)
            .map((e) => CharacterModel.fromJson(e))
            .toList();
      } else {
        throw EmptyResultException();
      }
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }

  @override
  Future<List<EpisodeModel>> getEpisodes() async {
    var url =
        "https://cors-anywhere.herokuapp.com/http://www.irmaodojorelapi.site/api/Episodio";
    var response = await httpClient
        .get(
          url,
          options: Options(
              headers: {'Content-Type': 'application/json; charset=UTF-8'}),
        )
        .timeout(Duration(seconds: 10));
    if (response.statusCode == 200) {
      if (response.data is List) {
        return (response.data as List)
            .map((e) => EpisodeModel.fromJson(e))
            .toList();
      } else {
        throw EmptyResultException();
      }
    } else {
      throw ServerException(response.statusCode.toString());
    }
  }
}
