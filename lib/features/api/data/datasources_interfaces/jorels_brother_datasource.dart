import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/episode_model.dart';

abstract class IJorelsBrotherDatasource {
  Future<List<CharacterModel>> getCharacters();

  Future<List<EpisodeModel>> getEpisodes();
}
