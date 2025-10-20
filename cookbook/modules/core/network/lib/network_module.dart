import 'package:core_network/adapters/http_adapter.dart';
import 'package:core_network/adapters/http_adapter_impl.dart';
import 'package:core_network/adapters/interceptors/session_interceptor.dart';
import 'package:core_network/datasources/auth_data_source.dart';
import 'package:core_network/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

final _getIt = GetIt.I;

void coreNetworkInjection() {
  _getIt.registerSingleton(Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  ));

  _getIt.registerLazySingleton(() => SessionInterceptor(_getIt(), _getIt()));
  _getIt.registerLazySingleton<HttpAdapter>(
    () => HttpAdapterImpl(
      _getIt(),
      _getIt(),
    ),
  );
  _getIt.registerLazySingleton<AuthDataSource>(
      () => ApiAuthDataSourceImpl(adapter: _getIt()));
}
