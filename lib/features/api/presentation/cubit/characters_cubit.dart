import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:irmao_do_jorel_app/features/api/domain/entities/character.dart';
import 'package:irmao_do_jorel_app/features/api/domain/usecases/jorels_brother_usecase.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(InitialState());
  IJorelsBrotherUsecase usecase = Modular.get<IJorelsBrotherUsecase>();

  void getCharacters() {
    emit(LoadingState());
    usecase.getCharacters().then(
      (result) {
        result.fold(
          (failure) {
            emit(ErrorState(errorMessage: failure.message));
          },
          (list) {
            emit(SuccessState(list: list));
          },
        );
      },
    );
  }
}
