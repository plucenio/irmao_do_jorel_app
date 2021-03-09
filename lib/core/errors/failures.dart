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

class ServerFailure extends IFailure {
  final String message;
  ServerFailure(this.message) : super();

  @override
  List<Object> get props => [];
}

class UnexpectedFailure extends IFailure {
  final String message;
  UnexpectedFailure(this.message) : super();

  @override
  List<Object> get props => [];
}
