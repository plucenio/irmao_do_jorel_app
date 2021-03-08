import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:irmao_do_jorel_app/app_module.dart';
import 'package:irmao_do_jorel_app/core/errors/exceptions.dart';
import 'package:irmao_do_jorel_app/features/api/data/datasources_interfaces/jorels_brother_datasource.dart';
import 'package:irmao_do_jorel_app/features/api/data/models/character_model.dart';
import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../fixtures/fixture_reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  MockDio mockDio;
  setUp(
    () {
      initModules([
        AppModule(),
      ], changeBinds: [
        Bind<Dio>((i) => MockDio()),
      ]);
      mockDio = Modular.get<Dio>();
    },
  );

  group(
    'mock',
    () {
      test(
        'ok',
        () async {
          //Assert
          expect(Modular.get<Dio>(), isA<MockDio>());
          // Arrange
        },
      );
    },
  );

  group(
    'getCharacters',
    () {
      test(
        'Should return a Exception '
        'when status code is between 201 and 299',
        () async {
          for (var i = 201; i < 300; i++) {
            // Arrange
            when(mockDio.get(any))
                .thenAnswer((_) async => Response(data: "", statusCode: i));

            //Assert
            expect(() async {
              // Act
              await Modular.get<IJorelsBrotherDatasource>().getCharacters();
            }, throwsA(TypeMatcher<ServerException>()));
          }
        },
      );

      test(
        'Should return a DioError '
        'when MockDio return DioError',
        () async {
          // Arrange
          when(mockDio.get(any)).thenThrow(
            DioError(),
          );

          //Assert
          expect(() async {
            // Act
            await Modular.get<IJorelsBrotherDatasource>().getCharacters();
          }, throwsA(TypeMatcher<DioError>()));
        },
      );

      test(
        'Should return a CharacterModel list when gets data',
        () async {
          // Arrange
          when(mockDio.get(any)).thenAnswer((_) async => Response(
              data: jsonDecode(fixtureReader("character_model.json")),
              statusCode: 200));
          // Act
          final result =
              await Modular.get<IJorelsBrotherDatasource>().getCharacters();
          //Assert
          expect(result, isA<List<CharacterModel>>());
        },
      );

      test(
        'Should return a FormatException when gets an empty string',
        () async {
          // Arrange
          when(mockDio.get(any)).thenAnswer(
              (_) async => Response(data: jsonDecode(""), statusCode: 200));
          // Act
          //Assert
          expect(() async {
            // Act
            await Modular.get<IJorelsBrotherDatasource>().getCharacters();
          }, throwsA(TypeMatcher<FormatException>()));
        },
      );

      test(
        'Should return a EmptyResultException when gets an empty json',
        () async {
          // Arrange
          when(mockDio.get(any)).thenAnswer(
              (_) async => Response(data: jsonDecode("{}"), statusCode: 200));
          // Act
          //Assert
          expect(() async {
            // Act
            await Modular.get<IJorelsBrotherDatasource>().getCharacters();
          }, throwsA(TypeMatcher<EmptyResultException>()));
        },
      );
    },
  );
}
