import 'dart:async';

import 'package:dartz/dartz.dart' as dartz;
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular_test/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:irmao_do_jorel_app/app_module.dart';
import 'package:irmao_do_jorel_app/core/errors/exceptions.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/episode_model.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';
import 'package:mockito/mockito.dart';

class MockDatasource extends Mock implements IJorelsBrotherDatasource {}

void main() {
  IJorelsBrotherDatasource mockDatasource;
  IJorelsBrotherRepository repository;

  setUp(() {
    initModule(AppModule(), replaceBinds: [
      Bind<IJorelsBrotherDatasource>((i) => MockDatasource()),
    ]);
    mockDatasource = Modular.get<IJorelsBrotherDatasource>();
    repository = Modular.get<IJorelsBrotherRepository>();
  });

  group(
    "mock",
    () {
      test(
        'ok',
        () {
          //Assert
          expect(mockDatasource, isA<MockDatasource>());
        },
      );
    },
  );

  group(
    'getCharacters',
    () {
      List<CharacterModel> emptyList = [];

      List<CharacterModel> list = [
        CharacterModel(id: 1, nome: "Jorel", descricao: "Descrição")
      ];
      test(
        'should return a list when the datasource return successfully',
        () async {
          // Arrange
          when(mockDatasource.getCharacters()).thenAnswer((_) async => list);
          // Act
          final result = await repository.getCharacters();
          //Assert
          expect(result, equals(dartz.Right(list)));
        },
      );

      test(
        'should return a list when the datasource return null',
        () async {
          // Arrange
          when(mockDatasource.getCharacters()).thenAnswer((_) async => null);
          // Act
          final result = await repository.getCharacters();
          //Assert
          result.fold(
            (l) => null,
            (r) {
              expect(r, equals(emptyList));
            },
          );
        },
      );

      test(
        'should return DioFailure when the datasource return DioError',
        () async {
          // Arrange
          when(mockDatasource.getCharacters()).thenThrow(DioError());
          // Act
          final result = await repository.getCharacters();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                DioFailure(""),
              ),
            ),
          );
        },
      );

      test(
        'should return ServerFailure when the datasource return ServerException',
        () async {
          // Arrange
          when(mockDatasource.getCharacters())
              .thenThrow(ServerException("Server error"));
          // Act
          final result = await repository.getCharacters();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                ServerFailure("Server error"),
              ),
            ),
          );
        },
      );

      test(
        'should return TimeoutFailure when the datasource return TimeoutException',
        () async {
          // Arrange
          when(mockDatasource.getCharacters())
              .thenThrow(TimeoutException("Server error"));
          // Act
          final result = await repository.getCharacters();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                TimeoutFailure(),
              ),
            ),
          );
        },
      );

      test(
        'should return UnexpectedFailure when the datasource return Exception',
        () async {
          // Arrange
          when(mockDatasource.getCharacters())
              .thenThrow(Exception("Server error"));
          // Act
          final result = await repository.getCharacters();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                UnexpectedFailure("Server error"),
              ),
            ),
          );
        },
      );

      test(
        'should return DioFailure when the datasource return DioErrorType.RESPONSE with a 403 as s StatusCode',
        () async {
          // Arrange
          var response = Response(statusCode: 403, statusMessage: "RESPONSE");
          when(mockDatasource.getCharacters()).thenThrow(
            DioError(
              error: "RESPONSE",
              type: DioErrorType.RESPONSE,
              response: response,
            ),
          );
          // Act
          final result = await repository.getCharacters();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                DioFailureWithSolution("403 - RESPONSE"),
              ),
            ),
          );

          result.fold((l) {
            expect(
              l.message,
              equals("403 - RESPONSE"),
            );
            expect(
              (l as DioFailureWithSolution).solution,
              equals("Para resolver o problema solicite permissão neste link:"),
            );
            expect(
              (l as DioFailureWithSolution).link,
              equals("https://cors-anywhere.herokuapp.com/corsdemo"),
            );
          }, (r) => null);
        },
      );

      test(
        'should return DioFailure with link null when the datasource return DioErrorType.RESPONSE with a 401 as StatusCode',
        () async {
          // Arrange
          var response = Response(statusCode: 401, statusMessage: "RESPONSE");
          when(mockDatasource.getEpisodes()).thenThrow(
            DioError(
              error: "RESPONSE",
              type: DioErrorType.RESPONSE,
              response: response,
            ),
          );
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                DioFailure("RESPONSE"),
              ),
            ),
          );

          result.fold((l) {
            expect(
              l.message,
              equals("401 - RESPONSE"),
            );
          }, (r) => null);
        },
      );
    },
  );

  group(
    'getCharacters',
    () {
      List<EpisodeModel> emptyList = [];

      List<EpisodeModel> list = [
        EpisodeModel(id: 1, nome: "Episodio", descricao: "Descrição")
      ];
      test(
        'should return a list when the datasource return successfully',
        () async {
          // Arrange
          when(mockDatasource.getEpisodes()).thenAnswer((_) async => list);
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(result, equals(dartz.Right(list)));
        },
      );

      test(
        'should return a list when the datasource return null',
        () async {
          // Arrange
          when(mockDatasource.getEpisodes()).thenAnswer((_) async => null);
          // Act
          final result = await repository.getEpisodes();
          //Assert
          result.fold((l) => null, (r) {
            expect(r, equals(emptyList));
          });
        },
      );

      test(
        'should return DioFailure when the datasource return DioError',
        () async {
          // Arrange
          when(mockDatasource.getEpisodes()).thenThrow(DioError());
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                DioFailure(""),
              ),
            ),
          );
        },
      );

      test(
        'should return ServerFailure when the datasource return ServerException',
        () async {
          // Arrange
          when(mockDatasource.getEpisodes())
              .thenThrow(ServerException("Server error"));
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                ServerFailure("Server error"),
              ),
            ),
          );
        },
      );

      test(
        'should return UnexpectedFailure when the datasource return Exception',
        () async {
          // Arrange
          when(mockDatasource.getEpisodes())
              .thenThrow(Exception("Server error"));
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                UnexpectedFailure("Server error"),
              ),
            ),
          );
        },
      );

      test(
        'should return UnexpectedFailure when the datasource return Exception',
        () async {
          // Arrange
          when(mockDatasource.getEpisodes())
              .thenThrow(Exception("Server error"));
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                UnexpectedFailure("Server error"),
              ),
            ),
          );
        },
      );

      test(
        'should return DioFailure when the datasource return DioErrorType.RESPONSE with a 403 as StatusCode',
        () async {
          // Arrange
          var response = Response(statusCode: 403, statusMessage: "RESPONSE");
          when(mockDatasource.getEpisodes()).thenThrow(
            DioError(
              error: "RESPONSE",
              type: DioErrorType.RESPONSE,
              response: response,
            ),
          );
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                DioFailureWithSolution("RESPONSE"),
              ),
            ),
          );

          result.fold((l) {
            expect(
              l.message,
              equals("403 - RESPONSE"),
            );
            expect(
              (l as DioFailureWithSolution).solution,
              equals("Para resolver o problema solicite permissão neste link:"),
            );
            expect(
              (l as DioFailureWithSolution).link,
              equals("https://cors-anywhere.herokuapp.com/corsdemo"),
            );
          }, (r) => null);
        },
      );

      test(
        'should return DioFailure with link null when the datasource return DioErrorType.RESPONSE with a 401 as StatusCode',
        () async {
          // Arrange
          var response = Response(statusCode: 401, statusMessage: "RESPONSE");
          when(mockDatasource.getEpisodes()).thenThrow(
            DioError(
              error: "RESPONSE",
              type: DioErrorType.RESPONSE,
              response: response,
            ),
          );
          // Act
          final result = await repository.getEpisodes();
          //Assert
          expect(
            result,
            equals(
              dartz.Left(
                DioFailure("RESPONSE"),
              ),
            ),
          );

          result.fold((l) {
            expect(
              l.message,
              equals("401 - RESPONSE"),
            );
          }, (r) => null);
        },
      );
    },
  );
}
