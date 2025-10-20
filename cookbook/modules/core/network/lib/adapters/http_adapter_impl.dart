import 'package:core_network/adapters/http_adapter.dart';
import 'package:core_network/adapters/interceptors/session_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpAdapterImpl implements HttpAdapter {
  final Dio dio;

  /// In case you're using more than one interceptor,
  /// change the type of this variable to [List<CustomInterceptor>]
  final SessionInterceptor sessionInterceptor;

  HttpAdapterImpl(this.dio, this.sessionInterceptor) {
    dio.interceptors.add(sessionInterceptor);
    dio.interceptors.add(
        PrettyDioLogger(
          enabled: kDebugMode,
          error: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
        )
    );
  }

  @override
  Future<Response> delete(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    data,
  }) async {
    final response = await dio.delete(
      uri,
      options: Options(headers: headers),
      queryParameters: params,
      data: data,
    );

    return response;
  }

  @override
  Future<Response> get(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    final response = await dio.get(
      uri,
      options: Options(headers: headers),
      queryParameters: params,
    );

    return response;
  }

  @override
  Future<Response> patch(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    data,
  }) async {
    final response = await dio.patch(
      uri,
      options: Options(headers: headers),
      queryParameters: params,
      data: data,
    );

    return response;
  }

  @override
  Future<Response> post(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    data,
  }) async {
    final response = await dio.post(
      uri,
      options: Options(headers: headers),
      queryParameters: params,
      data: data,
    );

    return response;
  }

  @override
  Future<Response> put(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    data,
  }) async {
    final response = await dio.put(
      uri,
      options: Options(headers: headers),
      queryParameters: params,
      data: data,
    );

    return response;
  }
}
