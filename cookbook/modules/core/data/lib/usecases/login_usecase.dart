import 'package:core_data/repositories/auth_repository.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_common/failures/auth_failure.dart';

abstract class LoginUsecase {
  Future<(SessionModel?, AuthFailure?)> call(LoginModel model);
}

class LoginUsecaseImpl implements LoginUsecase {
  final AuthRepository _repository;

  LoginUsecaseImpl(this._repository);
  @override
  Future<(SessionModel?, AuthFailure?)> call(LoginModel model) async =>
      await _repository.login(model);
}
