abstract class IFailure {
  String message;

  IFailure({this.message});
}

class DioFailure implements IFailure {
  String message;
  DioFailure(this.message) : super();
}

class ServerFailure implements IFailure {
  String message;
  ServerFailure(this.message) : super();
}

class UnexpectedFailure implements IFailure {
  String message;
  UnexpectedFailure(this.message) : super();
}
