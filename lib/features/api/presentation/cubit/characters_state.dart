part of 'characters_cubit.dart';

class CharactersState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends CharactersState {}

class LoadingState extends CharactersState {}

class SuccessState extends CharactersState {
  final List<Character> list;

  SuccessState({@required this.list}) : super();
}

class ErrorState extends CharactersState {
  final String errorMessage;

  ErrorState({@required this.errorMessage}) : super();
}
