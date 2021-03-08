import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/core/errors/exceptions.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';

class JorelsBrotherRepository implements IJorelsBrotherRepository {
  final IJorelsBrotherDatasource datasource =
      Modular.get<IJorelsBrotherDatasource>();

  @override
  Future<Either<IFailure, List<CharacterModel>>> getCharacters() async {
    try {
      var value = await datasource.getCharacters();
      return Right(value);
    } on DioError catch (e) {
      return Left(DioFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
