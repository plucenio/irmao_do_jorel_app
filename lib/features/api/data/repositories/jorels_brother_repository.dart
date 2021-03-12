import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/core/errors/exceptions.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/episode_model.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';

class JorelsBrotherRepository implements IJorelsBrotherRepository {
  final IJorelsBrotherDatasource datasource =
      Modular.get<IJorelsBrotherDatasource>();

  @override
  Future<Either<IFailure, List<CharacterModel>>> getCharacters() async {
    try {
      var value = await datasource.getCharacters();
      if (value == null) {
        value = <CharacterModel>[];
      }
      return Right(value);
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE && e.response.statusCode == 403) {
        return Left(
          DioFailureWithSolution(
            "${e.response.statusCode.toString()} - ${e.response.statusMessage}",
            solution: "Para resolver o problema solicite permissão neste link:",
            link: "https://cors-anywhere.herokuapp.com/corsdemo",
          ),
        );
      } else if (e.response != null) {
        return Left(
          DioFailure(
            "${e.response.statusCode} - ${e.response.statusMessage}",
          ),
        );
      } else {
        return Left(
          DioFailure(
            "${e.message}",
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on TimeoutException {
      return Left(TimeoutFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<IFailure, List<EpisodeModel>>> getEpisodes() async {
    try {
      var value = await datasource.getEpisodes();
      if (value == null) {
        value = <EpisodeModel>[];
      }
      return Right(value);
    } on DioError catch (e) {
      if (e.type == DioErrorType.RESPONSE && e.response?.statusCode == 403) {
        return Left(
          DioFailureWithSolution(
            "${e.response.statusCode.toString()} - ${e.response.statusMessage}",
            solution: "Para resolver o problema solicite permissão neste link:",
            link: "https://cors-anywhere.herokuapp.com/corsdemo",
          ),
        );
      } else if (e.response != null) {
        return Left(
          DioFailure(
            "${e.response.statusCode} - ${e.response.statusMessage}",
          ),
        );
      } else {
        return Left(
          DioFailure(
            "${e.message}",
          ),
        );
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on TimeoutException {
      return Left(TimeoutFailure());
    } on Exception catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }
}
