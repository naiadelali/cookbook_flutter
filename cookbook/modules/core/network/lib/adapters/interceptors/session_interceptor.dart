import 'dart:async';

import 'package:core_common/session/session_manager.dart';
import 'package:core_common/utils/env.dart';
import 'package:dio/dio.dart';
import 'package:synchronized/synchronized.dart';

/// To add a custom interceptor in your [HttpAdapter]
/// Add these lines to your constructor function
/// ```dart
/// _dio.interceptors.add(CustomInterceptor());
/// ```
///
/// In case you're using multiple interceptors, use the cascade operator, e.g.:
///
/// ```dart
/// _dio.interceptors
/// ..add(CustomInterceptor())
/// ..add(SessionInterceptor());
/// ```
///
/// or use the Dio's method `addAll`, e.g.:
/// ```dart
/// _dio.interceptors.addAll([CustomInterceptor(), SessionInterceptor()]);
/// ```
///
/// The methods still call the super constructors in case there is more than
/// one interceptor
class SessionInterceptor extends Interceptor {
  final Dio dio;
  final SessionManager sessionManager;
  final Lock _mutex = Lock();

  SessionInterceptor(this.sessionManager, this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers = await headerBuilder(options);
    super.onRequest(options, handler);
  }

  /// Use this method to apply changes to your header.
  /// E.g.:
  /// ```dart
  /// headers["accept"] = 'application/json';
  /// headers["Authorization"] = 'Bearer $token';
  /// ```
  Future<Map<String, dynamic>> headerBuilder(RequestOptions request) async {
    var token = (await sessionManager.getUserSession())?.content?.accessToken;
    final Map<String, dynamic> headers = request.headers;
    if (token != null) {
      headers["authorization"] = 'Bearer $token';
    }
    return headers;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_mutex.locked) {
      sessionManager.deleteUserSession(loginExpired: true);
      return handler.next(err);
    }
    try {
      return await _mutex.synchronized(() async {
        if ((err.response?.statusCode == 401 ||
                err.response?.statusCode == 403) &&
            err.requestOptions.path.contains(Env.baseUrl)) {
          // Token expired or unauthorized, logout user
          await sessionManager.deleteUserSession(loginExpired: true);
          return handler.next(err);
        }
        return handler.next(err);
      }, timeout: Duration(seconds: 40));
    } on TimeoutException {
      sessionManager.deleteUserSession(loginExpired: true);
      return handler.next(err);
    }
  }
}
