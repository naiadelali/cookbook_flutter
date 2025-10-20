import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

class FakeSessionModel extends Fake implements SessionModel {}

void main() {
  final mockAuthDataSource = MockAuthDataSource();
  final mockSessionDataSource = MockSessionDataSource();

  setUpAll(() {
    registerFallbackValue(FakeSessionModel());
  });

  final ApiAuthRepositoryImpl repository = ApiAuthRepositoryImpl(
    mockAuthDataSource,
    mockSessionDataSource,
  );

  SessionModel mockSessionModel = SessionModel();

  group("API Auth Repository", () {
    group("login", () {
      final LoginModel model = LoginModel(
        email: "eve.holt@reqres.in",
        password: "cityslicka",
      );

      test('successful', () async {
        when(
          () => mockAuthDataSource.login(model),
        ).thenAnswer(
          (_) async => (SessionModel(), null),
        );

        when(
          () => mockSessionDataSource.saveUserSession(any()),
        ).thenAnswer(
          (_) async => {},
        );

        final (session, failure) = await repository.login(model);

        expect(session, isA<SessionModel>());
        expect(failure, isNull);
      });

      test('failure', () async {
        when(
          () => mockAuthDataSource.login(model),
        ).thenAnswer(
          (_) async => (null, AuthFailure("login failed")),
        );

        final (session, failure) = await repository.login(model);

        expect(session, isNull);
        expect(failure, isA<AuthFailure>());
      });
    });

    group("logout", () {
      test('successful', () async {
        when(
          () => mockSessionDataSource.getUserSession(),
        ).thenAnswer(
          (_) async => mockSessionModel,
        );

        when(
          () => mockAuthDataSource.logout(any()),
        ).thenAnswer(
          (_) async => (null, null),
        );

        when(
          () => mockSessionDataSource.deleteUserSession(),
        ).thenAnswer(
          (_) async => true,
        );

        final (_, failure) = await repository.logout();

        expect(failure, isNull);
      });

      test('failure', () async {
        const message = "Not valid token";

        when(
          () => mockSessionDataSource.getUserSession(),
        ).thenAnswer(
          (_) async => mockSessionModel,
        );

        when(
          () => mockAuthDataSource.logout(any()),
        ).thenAnswer((_) async => (null, AuthFailure(message)));

        when(
          () => mockSessionDataSource.deleteUserSession(),
        ).thenAnswer(
          (_) async => true,
        );

        final (_, failure) = await repository.logout();

        expect(failure, isA<AuthFailure>());
        expect(failure?.message, message);
      });
    });
  });
}
