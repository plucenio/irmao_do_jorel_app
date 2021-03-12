part of 'main_cubit.dart';

class MainState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends MainState {}

class LoadingState extends MainState {}

class SuccessStateCharacters extends MainState {
  final List<Character> list;

  SuccessStateCharacters({@required this.list}) : super();
}

class SuccessStateEpisodes extends MainState {
  final List<Episode> list;

  SuccessStateEpisodes({@required this.list}) : super();
}

class ErrorState extends MainState {
  final String errorMessage;

  ErrorState({@required this.errorMessage}) : super();
}

class ErrorWithSolutionState extends MainState {
  final String errorMessage;
  final String solution;
  final String link;

  ErrorWithSolutionState(
      {@required this.errorMessage, this.solution, this.link})
      : super();
}
