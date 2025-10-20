import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_common/session/session_manager.dart' show SessionManager;
import 'package:core_network/datasources/auth_data_source.dart';

abstract class AuthRepository {
  Future<SessionModel?> getUserSession();

  Future<(void, AuthFailure?)> logout();

  Future<(SessionModel?, AuthFailure?)> login(
    LoginModel loginModel,
  );
}

class ApiAuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  final SessionManager sessionDataSource;

  ApiAuthRepositoryImpl(this.authDataSource, this.sessionDataSource);

  @override
  Future<(SessionModel?, AuthFailure?)> login(LoginModel model) async {
    final response = await authDataSource.login(model);
    if (response.$2 == null) {
      await sessionDataSource.saveUserSession(response.$1!);
    }

    return response;
  }

  @override
  Future<(void, AuthFailure?)> logout() async {
    final session = await sessionDataSource.getUserSession();
    final response = await authDataSource.logout(session?.content?.token);
    await sessionDataSource.deleteUserSession();

    return response;
  }

  @override
  Future<SessionModel?> getUserSession() async {
    final response = await sessionDataSource.getUserSession();
    if (response == null) {
      await sessionDataSource.deleteUserSession();
    }

    return response;
  }
}
