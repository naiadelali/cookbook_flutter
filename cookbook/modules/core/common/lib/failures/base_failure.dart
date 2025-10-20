abstract class BaseFailure {
  final String message;

  BaseFailure(this.message);

  @override
  String toString() => message;
}
