import 'package:core_common/models/session_model.dart';
import 'package:core_common/ui/state/app_state.dart';
import 'package:core_common/ui/state/cubit/app_cubit.dart';
import 'package:core_data/usecases/get_session_usecase.dart';
import 'package:core_data/usecases/logout_usecase.dart';
import 'package:core_data/usecases/refresh_token_usecase.dart';

class AppCubitImpl extends AppCubit<AppState> {
  final GetSessionUsecase _getSessionUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final LogoutUseCase _logoutUseCase;

  AppCubitImpl(
      this._getSessionUseCase, this._refreshTokenUseCase, this._logoutUseCase)
      : super(AppState());

  Future<SessionModel?> getSession() async {
    if (state.session == null) {
      return await _getSessionUseCase.call();
    }

    setSession(state.session!);

    return state.session;
  }

  void setSession(SessionModel session) {
    emit(state.copyWith(sessionModel: session));
  }

  Future<void> refreshToken() async => await _refreshTokenUseCase.call();

  Future<void> signOut() async => await _logoutUseCase.call();
}
