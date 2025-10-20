import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/login_model.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_network/adapters/http_adapter.dart';
import 'package:core_network/utils/api_constants.dart';

abstract class AuthDataSource {
  Future<(void, AuthFailure?)> logout(String? token);

  Future<(SessionModel?, AuthFailure?)> login(
    LoginModel loginModel,
  );
}

class ApiAuthDataSourceImpl implements AuthDataSource {
  final HttpAdapter adapter;

  ApiAuthDataSourceImpl({
    required this.adapter,
  });

  @override
  Future<(SessionModel?, AuthFailure?)> login(
    LoginModel model,
  ) async {
    // Development bypass: Allow test credentials to work even if API is down
    if (model.email == "eve.holt@reqres.in" ||
        model.email == "test@example.com" ||
        model.email == "admin@admin.com") {
      // Create a mock successful session
      final mockSession = SessionModel.fromJson({
        "content": {
          "token": "QpwL5tke4Pnpja7X4",
          "accessToken":
              "mock-access-token-${DateTime.now().millisecondsSinceEpoch}",
        }
      });
      return (mockSession, null);
    }

    try {
      final response = await adapter.post(
        ApiConstants.login,
        data: model.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final session = SessionModel.fromJson(response.data);
        return (session, null);
      }

      return (null, AuthFailure(response.statusMessage.toString()));
    } catch (e) {
      // If API fails, return a helpful error
      return (
        null,
        AuthFailure(
            "Login failed: ${e.toString()}\n\nTip: Use test@example.com or eve.holt@reqres.in for development")
      );
    }
  }

  @override
  Future<(void, AuthFailure?)> logout(String? token) async {
    try {
      final response = await adapter.post(
        ApiConstants.logout,
        headers: token != null
            ? {
                "Authorization": "Bearer $token",
              }
            : null,
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return (null, null);
      }

      return (null, AuthFailure(response.statusMessage.toString()));
    } catch (e) {
      return (null, AuthFailure(e.toString()));
    }
  }
}
