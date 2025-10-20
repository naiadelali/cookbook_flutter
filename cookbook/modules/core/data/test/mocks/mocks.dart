import 'package:core_common/session/session_manager.dart';
import 'package:core_data/repositories/auth_repository.dart';
import 'package:core_network/datasources/auth_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockSessionDataSource extends Mock implements SessionManager {}
