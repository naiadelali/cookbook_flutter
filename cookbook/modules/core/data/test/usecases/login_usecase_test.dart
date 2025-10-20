import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_data/repositories/auth_repository.dart';
import 'package:core_data/usecases/login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class FakeLoginModel extends Fake implements LoginModel {}

void main() {
  late LoginUsecase usecase;
  late AuthRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeLoginModel());
  });

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LoginUsecaseImpl(mockRepository);
  });

  LoginModel loginModel = LoginModel(
    email: "email",
    password: "password",
    // method: LoginMethod.email,
    // clientId: "clientId",
    // clientSecret: "clientSecret",
    // grantType: "grantType",
  );

  SessionModel mockSessionModel = SessionModel();

  group('LoginUseCaseImpl', () {
    test('should return SessionModel', () async {
      // Arrange
      when(() => mockRepository.login(any<LoginModel>()))
          .thenAnswer((_) async => (mockSessionModel, null));

      // Act
      final result = await usecase.call(loginModel);

      // Assert
      expect(result, equals((mockSessionModel, null)));
      verify(() => mockRepository.login(any<LoginModel>())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return AuthFailure', () async {
      // Arrange
      final failure = AuthFailure("server-failure");

      when(() => mockRepository.login(any<LoginModel>()))
          .thenAnswer((_) async => (null, failure));

      // Act
      final result = await usecase.call(loginModel);

      // Assert
      expect(result, equals((null, failure)));
      verify(() => mockRepository.login(any<LoginModel>())).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
