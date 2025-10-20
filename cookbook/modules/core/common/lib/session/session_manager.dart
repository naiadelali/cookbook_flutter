import 'package:core_common/models/session_model.dart';

abstract class SessionManager {
  Future<void> saveUserSession(SessionModel session);
  Future<SessionModel?> getUserSession();
  Future<void> deleteUserSession({bool loginExpired = false});
}
