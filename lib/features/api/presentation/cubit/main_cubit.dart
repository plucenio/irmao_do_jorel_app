import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/character.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/episode.dart';
import 'package:irmao_do_jorel_app/features/api/domain/usecases/jorels_brother_usecase.dart';

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
              emit(ErrorState(errorMessage: failure.message));
            },
            (list) {
              emit(SuccessStateCharacters(list: list));
            },
          );
        },
      );
    } else {
      usecase.getEpisodes().then(
        (result) {
          result.fold(
            (failure) {
              emit(ErrorState(errorMessage: failure.message));
            },
            (list) {
              emit(SuccessStateEpisodes(list: list));
            },
          );
        },
      );
    }
  }
}
