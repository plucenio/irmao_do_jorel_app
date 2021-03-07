abstract class IFailure {
  String message;

  IFailure({this.message});
}

class UnexpectedFailure implements IFailure {
  String message;
  UnexpectedFailure(this.message) : super();
}
