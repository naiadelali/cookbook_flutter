import 'package:core_common/models/session_model.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

abstract class AppCubit<State> extends Cubit<State> {
  AppCubit(super.initialState);

  Future<SessionModel?> getSession();
  void setSession(SessionModel session);
  Future<void> refreshToken();
  Future<void> signOut();
}