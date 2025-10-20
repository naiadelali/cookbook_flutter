import 'package:core_network/adapters/http_adapter.dart';
import 'package:core_network/datasources/auth_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDataSource extends Mock implements AuthDataSource {}

class MockHttpAdapter extends Mock implements HttpAdapter {}
