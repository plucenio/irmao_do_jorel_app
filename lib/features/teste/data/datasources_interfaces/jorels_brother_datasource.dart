import 'package:irmao_do_jorel_app/features/teste/data/models/character_model.dart';

abstract class IJorelsBrotherDatasource {
  Future<List<CharacterModel>> getCharacters();
}
