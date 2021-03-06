import 'package:dartz/dartz.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/episode_model.dart';

abstract class IJorelsBrotherRepository {
  Future<Either<IFailure, List<CharacterModel>>> getCharacters();

  Future<Either<IFailure, List<EpisodeModel>>> getEpisodes();
}
