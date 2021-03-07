import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/teste/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/teste/data/models/character_model.dart';

class JorelsBrotherDatasource implements IJorelsBrotherDatasource {
  final Dio httpClient = Modular.get<Dio>();

  @override
  Future<List<CharacterModel>> getCharacters() async {
    var url = "http://www.irmaodojorelapi.site/api/Personagem";

    var response = await httpClient.get(url);
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}
