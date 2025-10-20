import 'package:core_common/models/session_model.dart';
import 'package:core_data/repositories/auth_repository.dart';

abstract class GetSessionUsecase {
  Future<SessionModel?> call();
}

class GetSessionUsecaseImpl implements GetSessionUsecase {
  final AuthRepository _repository;

  GetSessionUsecaseImpl(this._repository);

  @override
  Future<SessionModel?> call() async => await _repository.getUserSession();
}
