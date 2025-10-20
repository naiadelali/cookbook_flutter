import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_data/repositories/auth_repository.dart';

abstract class RefreshTokenUseCase {
  Future<(SessionModel?, AuthFailure?)> call();
}

// Note: RefreshTokenUseCase is not implemented for public APIs like ReqRes
// that don't support token refresh. Implement this based on your API requirements.
class RefreshTokenUseCaseImpl implements RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCaseImpl(this._repository);

  @override
  Future<(SessionModel?, AuthFailure?)> call() async {
    // This is a placeholder. Implement based on your API's refresh token endpoint.
    // For now, just return the current session or logout if expired.
    final session = await _repository.getUserSession();
    if (session == null) {
      return (null, AuthFailure("No session found"));
    }
    return (session, null);
  }
}
