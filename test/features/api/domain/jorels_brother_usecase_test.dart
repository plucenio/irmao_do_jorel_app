import 'package:irmao_do_jorel_app/app_module.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/episode_model.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/character.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/episode.dart';
import 'package:irmao_do_jorel_app/features/api/domain/repositories_interfaces/jorels_brother_repository.dart';
import 'package:irmao_do_jorel_app/features/api/domain/usecases/jorels_brother_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MockRepository extends Mock implements IJorelsBrotherRepository {}

void main() {
  IJorelsBrotherUsecase usecase;
  IJorelsBrotherRepository mockRepository;
  setUp(
    () {
      initModule(AppModule(), changeBinds: [
        Bind<IJorelsBrotherRepository>((i) => MockRepository()),
      ]);
      mockRepository = Modular.get<IJorelsBrotherRepository>();
      usecase = Modular.get<IJorelsBrotherUsecase>();
    },
  );

  group(
    'mock',
    () {
      test(
        'ok',
        () async {
          expect(
              Modular.get<IJorelsBrotherRepository>(), isA<MockRepository>());
        },
      );
    },
  );

  group(
    'getCharacters',
    () {
      var emptyList = <CharacterModel>[];

      var list = <CharacterModel>[
        CharacterModel(nome: 'Personagem 1'),
        CharacterModel(nome: 'Personagem 2'),
        CharacterModel(nome: 'Personagem 3'),
      ];

      test(
        'should return a list of Character when repository returns a list of CharacterModel',
        () async {
          // Arrange
          when(mockRepository.getCharacters())
              .thenAnswer((_) async => dartz.Right(list));
          // Act
          final result = await usecase.getCharacters();
          //Assert
          expect(result, equals(dartz.Right(list)));

          result.fold((l) => null, (r) {
            expect(r, isA<List<Character>>());
          });
        },
      );

      test(
        'should return a list of Character when repository returns an empty list',
        () async {
          // Arrange
          when(mockRepository.getCharacters())
              .thenAnswer((_) async => dartz.Right(emptyList));
          // Act
          final result = await usecase.getCharacters();
          //Assert
          expect(result, equals(dartz.Right(emptyList)));

          result.fold((l) => null, (r) {
            expect(r, isA<List<Character>>());
          });
        },
      );

      test(
        'should return an UnexpectedFailure when an UnexpectedFailure occurs on repository',
        () async {
          // Arrange
          when(mockRepository.getCharacters()).thenAnswer(
              (_) async => dartz.Left(UnexpectedFailure("Failure")));
          // Act
          final result = await usecase.getCharacters();
          //Assert
          expect(result, equals(dartz.Left(UnexpectedFailure("Failure"))));
        },
      );

      test(
        'should return an ServerFailure when an ServerFailure occurs on repository',
        () async {
          // Arrange
          when(mockRepository.getCharacters())
              .thenAnswer((_) async => dartz.Left(ServerFailure("Failure")));
          // Act
          final result = await usecase.getCharacters();
          //Assert
          expect(result, equals(dartz.Left(ServerFailure("Failure"))));
        },
      );

      test(
        'should return an DioFailure when an DioFailure occurs on repository',
        () async {
          // Arrange
          when(mockRepository.getCharacters())
              .thenAnswer((_) async => dartz.Left(DioFailure("Failure")));
          // Act
          final result = await usecase.getCharacters();
          //Assert
          expect(result, equals(dartz.Left(DioFailure("Failure"))));
        },
      );
    },
  );

  group(
    'getEpisodes',
    () {
      var emptyList = <EpisodeModel>[];

      var list = <EpisodeModel>[
        EpisodeModel(nome: 'Episodio 1'),
        EpisodeModel(nome: 'Episodio 2'),
        EpisodeModel(nome: 'Episodio 3'),
      ];

      test(
        'should return a list of Episodes when repository returns a list of EpisodeModel',
        () async {
          // Arrange
          when(mockRepository.getEpisodes())
              .thenAnswer((_) async => dartz.Right(list));
          // Act
          final result = await usecase.getEpisodes();
          //Assert
          expect(result, equals(dartz.Right(list)));

          result.fold((l) => null, (r) {
            expect(r, isA<List<Episode>>());
          });
        },
      );

      test(
        'should return a list of Episode when repository returns an empty list',
        () async {
          // Arrange
          when(mockRepository.getEpisodes())
              .thenAnswer((_) async => dartz.Right(emptyList));
          // Act
          final result = await usecase.getEpisodes();
          //Assert
          expect(result, equals(dartz.Right(emptyList)));

          result.fold((l) => null, (r) {
            expect(r, isA<List<Episode>>());
          });
        },
      );

      test(
        'should return an UnexpectedFailure when an UnexpectedFailure occurs on repository',
        () async {
          // Arrange
          when(mockRepository.getEpisodes()).thenAnswer(
              (_) async => dartz.Left(UnexpectedFailure("Failure")));
          // Act
          final result = await usecase.getEpisodes();
          //Assert
          expect(result, equals(dartz.Left(UnexpectedFailure("Failure"))));
        },
      );

      test(
        'should return an ServerFailure when an ServerFailure occurs on repository',
        () async {
          // Arrange
          when(mockRepository.getEpisodes())
              .thenAnswer((_) async => dartz.Left(ServerFailure("Failure")));
          // Act
          final result = await usecase.getEpisodes();
          //Assert
          expect(result, equals(dartz.Left(ServerFailure("Failure"))));
        },
      );

      test(
        'should return an DioFailure when an DioFailure occurs on repository',
        () async {
          // Arrange
          when(mockRepository.getEpisodes())
              .thenAnswer((_) async => dartz.Left(DioFailure("Failure")));
          // Act
          final result = await usecase.getEpisodes();
          //Assert
          expect(result, equals(dartz.Left(DioFailure("Failure"))));
        },
      );
    },
  );
}
