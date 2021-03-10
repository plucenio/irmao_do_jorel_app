import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/character.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/episode.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';

abstract class IJorelsBrotherUsecase {
  Future<Either<IFailure, List<Character>>> getCharacters();

  Future<Either<IFailure, List<Episode>>> getEpisodes();
}

class JorelsBrotherUsecase implements IJorelsBrotherUsecase {
  final IJorelsBrotherRepository repository =
      Modular.get<IJorelsBrotherRepository>();

  @override
  Future<Either<IFailure, List<Character>>> getCharacters() async {
    return await repository.getCharacters();
  }

  @override
  Future<Either<IFailure, List<Episode>>> getEpisodes() async {
    return await repository.getEpisodes();
  }
}
