abstract class IFailure {}

class UnexpectedFailure implements IFailure {
  UnexpectedFailure({String message});
}
