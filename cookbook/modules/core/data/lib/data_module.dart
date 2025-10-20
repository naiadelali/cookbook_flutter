import 'package:core_data/repositories/auth_repository.dart';
import 'package:core_data/usecases/get_session_usecase.dart';
import 'package:core_data/usecases/login_usecase.dart';
import 'package:core_data/usecases/logout_usecase.dart';
import 'package:core_data/usecases/refresh_token_usecase.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

final _getIt = GetIt.I;

void coreDataInjection() {
  _getIt.registerLazySingleton<AuthRepository>(
      () => ApiAuthRepositoryImpl(_getIt(), _getIt()));
  _getIt.registerLazySingleton<GetSessionUsecase>(
    () => GetSessionUsecaseImpl(_getIt()),
  );
  _getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecaseImpl(_getIt()));
  _getIt.registerLazySingleton<RefreshTokenUseCase>(
    () => RefreshTokenUseCaseImpl(_getIt()),
  );
  _getIt
      .registerLazySingleton<LogoutUseCase>(() => LogoutUseCaseImpl(_getIt()));
}
