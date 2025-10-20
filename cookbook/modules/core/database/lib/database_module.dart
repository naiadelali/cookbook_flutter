import 'package:core_common/session/session_manager.dart';
import 'package:core_database/adapters/storage_adapter.dart';
import 'package:core_database/datasources/session_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_dependencies/shared_dependencies.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _getIt = GetIt.I;

Future<void> coreDatabaseInjection() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  _getIt.registerSingleton(sharedPreferences);
  _getIt.registerSingleton(FlutterSecureStorage());
  _getIt.registerLazySingleton<StorageAdapter>(() => StorageAdapterImpl(_getIt(), _getIt()));
  _getIt.registerLazySingleton<SessionManager>(() => SessionDataSourceImpl(_getIt(), _getIt()));
}
