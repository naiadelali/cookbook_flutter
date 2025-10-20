import 'package:dio/dio.dart';

/// `HttpAdapter` is an abstract class that defines a contract for
/// HTTP client implementations. It declares methods for making
/// HTTP requests: GET, POST, PUT, DELETE, and PATCH.
///
/// Each method returns a `Future<HttpResponse>`, which represents
/// the eventual result of the HTTP request. They all take a `uri` argument,
/// which specifies the URI of the HTTP request, and optional arguments:
/// `headers`, `params`, `data` which allow further customization
/// of the HTTP request.

abstract class HttpAdapter {
  /// Sends a GET request to the specified [uri] and returns the response.
  ///
  /// - [uri]: The URI of the HTTP request.
  /// - [headers]: (Optional) A map of HTTP headers to include in the request.
  /// - [params]: (Optional) A map of query parameters to include in the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await adapter.get(
  ///   'https://example.com',
  ///   headers: {'Accept': 'application/json'},
  /// );
  /// ```
  Future<Response> get(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
  });

  /// Sends a POST request to the specified [uri] with the specified [data] and returns the response.
  ///
  /// - [uri]: The URI of the HTTP request.
  /// - [headers]: (Optional) A map of HTTP headers to include in the request.
  /// - [params]: (Optional) A map of query parameters to include in the request.
  /// - [data]: The body of the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await adapter.post(
  ///   'https://example.com',
  ///   data: {'key': 'value'},
  /// );
  /// ```
  Future<Response> post(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    dynamic data,
  });

  /// Sends a PUT request to the specified [uri] with the specified [data] and returns the response.
  ///
  /// - [uri]: The URI of the HTTP request.
  /// - [headers]: (Optional) A map of HTTP headers to include in the request.
  /// - [params]: (Optional) A map of query parameters to include in the request.
  /// - [data]: The body of the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await adapter.put(
  ///   'https://example.com',
  ///   data: {'key': 'value'},
  /// );
  /// ```
  Future<Response> put(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    dynamic data,
  });

  /// Sends a DELETE request to the specified [uri] and returns the response.
  ///
  /// - [uri]: The URI of the HTTP request.
  /// - [headers]: (Optional) A map of HTTP headers to include in the request.
  /// - [params]: (Optional) A map of query parameters to include in the request.
  /// - [data]: (Optional) The body of the request, if any.
  ///
  /// Example:
  /// ```dart
  /// final response = await adapter.delete('https://example.com');
  /// ```
  Future<Response> delete(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    dynamic data,
  });

  /// Sends a PATCH request to the specified [uri] with the specified [data] and returns the response.
  ///
  /// - [uri]: The URI of the HTTP request.
  /// - [headers]: (Optional) A map of HTTP headers to include in the request.
  /// - [params]: (Optional) A map of query parameters to include in the request.
  /// - [data]: The body of the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await adapter.patch(
  ///   'https://example.com',
  ///   data: {'key': 'value'},
  /// );
  /// ```
  Future<Response> patch(
    String uri, {
    Map<String, String>? headers,
    Map<String, String>? params,
    dynamic data,
  });
}
