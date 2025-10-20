import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_network/adapters/http_adapter.dart';
import 'package:core_network/datasources/auth_data_source.dart';
import 'package:core_network/utils/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  final HttpAdapter mockAdapter = MockHttpAdapter() as HttpAdapter;
  final ApiAuthDataSourceImpl dataSource = ApiAuthDataSourceImpl(
    adapter: mockAdapter,
  );

  final Map<String, dynamic> sessionModelJson = {
    "content": {
      "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
    }
  };

  group("API Auth DataSource", () {
    const token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9";

    group("login", () {
      final LoginModel model = LoginModel(
        email: "eve.holt@reqres.in",
        password: "cityslicka",
      );

      test('successful', () async {
        when(
          () => mockAdapter.post(
            ApiConstants.login,
            data: model.toJson(),
          ),
        ).thenAnswer(
          (_) async => Response(
            data: sessionModelJson,
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        );

        final (session, failure) = await dataSource.login(model);

        expect(session, isA<SessionModel>());
        expect(session?.content?.token, "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9");
        expect(failure, isNull);
      });

      test('failure', () async {
        when(
          () => mockAdapter.post(
            ApiConstants.login,
            data: model.toJson(),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 400,
          ),
        );

        final (session, failure) = await dataSource.login(model);

        expect(session, isNull);
        expect(failure, isA<AuthFailure>());
      });
    });

    group("logout", () {
      test('successful', () async {
        when(
          () => mockAdapter.post(
            ApiConstants.logout,
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 200,
          ),
        );

        final (_, failure) = await dataSource.logout(token);

        expect(failure, isNull);
      });

      test('failure', () async {
        const message = "Not valid token";

        when(
          () => mockAdapter.post(
            ApiConstants.logout,
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(),
            statusCode: 400,
            statusMessage: message,
          ),
        );

        final (_, failure) = await dataSource.logout(token);

        expect(failure, isA<AuthFailure>());
        expect(failure?.message, message);
      });
    });
  });
}
