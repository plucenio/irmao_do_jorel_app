import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/core/erros.dart';
import 'package:irmao_do_jorel_app/features/teste/domain/entities/character.dart';
import 'package:irmao_do_jorel_app/features/teste/domain/repositories_interfaces/jorels_brother_repository.dart';

abstract class IJorelsBrotherUsecase {
  Future<Either<IFailure, List<Character>>> getCharacters();
}

class JorelsBrotherUsecase implements IJorelsBrotherUsecase {
  final IJorelsBrotherRepository repository =
      Modular.get<IJorelsBrotherRepository>();

  @override
  Future<Either<IFailure, List<Character>>> getCharacters() async {
    return await repository.getCharacters();
  }
}
