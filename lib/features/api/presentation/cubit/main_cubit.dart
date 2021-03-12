import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/core/errors/failures.dart';

import '../../domain/entities/character.dart';
import '../../domain/entities/episode.dart';
import '../../domain/usecases/jorels_brother_usecase.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(InitialState());
  IJorelsBrotherUsecase usecase = Modular.get<IJorelsBrotherUsecase>();

  void getData(bool teste) {
    emit(LoadingState());
    if (teste) {
      usecase.getCharacters().then(
        (result) {
          result.fold(
            (failure) {
              if (failure is DioFailureWithSolution) {
                emit(
                  ErrorWithSolutionState(
                    errorMessage: failure.message,
                    solution: failure.solution,
                    link: failure.link,
                  ),
                );
              } else {
                emit(
                  ErrorState(
                    errorMessage: failure.message,
                  ),
                );
              }
            },
            (list) {
              emit(
                SuccessStateCharacters(list: list),
              );
            },
          );
        },
      );
    } else {
      usecase.getEpisodes().then(
        (result) {
          result.fold(
            (failure) {
              if (failure is DioFailureWithSolution) {
                emit(
                  ErrorWithSolutionState(
                    errorMessage: failure.message,
                    solution: failure.solution,
                    link: failure.link,
                  ),
                );
              } else {
                emit(
                  ErrorState(
                    errorMessage: failure.message,
                  ),
                );
              }
            },
            (list) {
              emit(
                SuccessStateEpisodes(list: list),
              );
            },
          );
        },
      );
    }
  }
}
