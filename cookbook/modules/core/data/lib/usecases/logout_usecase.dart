import 'package:core_common/failures/auth_failure.dart';
import 'package:core_data/repositories/auth_repository.dart';

abstract class LogoutUseCase {
  Future<(void, AuthFailure?)> call();
}

class LogoutUseCaseImpl implements LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCaseImpl(this._repository);
  @override
  Future<(void, AuthFailure?)> call() async =>
      await _repository.logout();
}
