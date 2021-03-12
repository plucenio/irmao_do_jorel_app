import 'package:equatable/equatable.dart';

abstract class IFailure extends Equatable {
  final String message;

  IFailure({this.message});
}

class DioFailure extends IFailure {
  final String message;
  DioFailure(this.message) : super();

  @override
  List<Object> get props => [];
}

class DioFailureWithSolution extends IFailure {
  final String message;
  final String solution;
  final String link;
  DioFailureWithSolution(
    this.message, {
    this.solution,
    this.link,
  }) : super();

  @override
  List<Object> get props => [];
}

class ServerFailure extends IFailure {
  final String message;
  ServerFailure(this.message) : super();

  @override
  List<Object> get props => [];
}

class TimeoutFailure extends IFailure {
  final String message = "Tempo limite excedido.";
  TimeoutFailure() : super();

  @override
  List<Object> get props => [];
}

class UnexpectedFailure extends IFailure {
  final String message;
  UnexpectedFailure(this.message) : super();

  @override
  List<Object> get props => [];
}
