import 'package:auth/src/navigation/navigation.dart';
import 'package:auth/src/ui/state/auth_state.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/navigation/app_navigation.dart';
import 'package:core_data/usecases/get_session_usecase.dart';
import 'package:core_data/usecases/login_usecase.dart';
import 'package:core_data/usecases/logout_usecase.dart';
import 'package:core_data/usecases/refresh_token_usecase.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class SignInCubit extends Cubit<SignInState> {
  final LoginUsecase _loginUseCase;
  final RefreshTokenUseCase _refreshTokenUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetSessionUsecase _getSessionUseCase;
  final AuthNavigation _navigation;
  final AppNavigation _appNavigation;

  SignInCubit(
    this._loginUseCase,
    this._refreshTokenUseCase,
    this._logoutUseCase,
    this._getSessionUseCase,
    this._navigation,
    this._appNavigation,
  ) : super(SignInState()) {
    getSessionFromStorage();
  }

  Future<void> getSessionFromStorage() async {
    final session = await _getSessionUseCase.call();

    if (session != null) {
      emit(SignInState(session: session));
      _appNavigation.goToHome();
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    final LoginModel model = LoginModel(
      email: email,
      password: password,
    );

    final result = await _loginUseCase.call(model);

    if (result.$1 != null) {
      emit(SignInState(session: result.$1!));
      _appNavigation.goToHome();
      return;
    }

    emit(SignInState(errorMessage: result.$2!.message));
  }

  Future<void> signOut() async {
    final result = await _logoutUseCase.call();

    if (result.$2 == null) {
      emit(SignInState());
      _navigation.goToAuth();
      return;
    }

    emit(SignInState(errorMessage: result.$2!.message));
    _navigation.goToAuth();
  }

  Future<SignInState> refreshToken() async {
    emit(state.copyWith(isLoading: true));

    final lastSession = state.session;
    final result = await _refreshTokenUseCase.call();

    if (result.$1 != null) {
      final updatedSession = lastSession?.copyWithResponse(result.$1!);
      emit(SignInState(session: updatedSession));
      return state;
    }

    emit(state.copyWith(
      errorMessage: result.$2!.message,
      session: lastSession,
      isLoading: false,
    ));

    return state;
  }

  void goToExamples() => _appNavigation.goToExamples();
}
