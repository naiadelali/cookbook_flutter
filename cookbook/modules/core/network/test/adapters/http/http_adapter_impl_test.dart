import 'package:core_network/adapters/http_adapter_impl.dart';
import 'package:core_network/adapters/interceptors/session_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {
  @override
  Interceptors get interceptors => Interceptors();
}

class MockCustomInterceptor extends Mock implements SessionInterceptor {}

void main() {
  final mockDio = MockDio();
  final HttpAdapterImpl adapter =
      HttpAdapterImpl(mockDio, MockCustomInterceptor());

  const uri = 'https://lib.com';

  group("HttpAdapterImpl", () {
    group("Get", () {
      final successResponse = Response(
        data: {"key": "success"},
        requestOptions: RequestOptions(),
        statusCode: 200,
      );

      final failureResponse = Response(
        data: {"key": "fail"},
        requestOptions: RequestOptions(),
        statusCode: 400,
      );

      test('on successful request', () async {
        when(
          () => mockDio.get(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => successResponse);

        final response = await adapter.get(uri);

        expect(response.data, {'key': 'success'});
        expect(response.statusCode, 200);
      });

      test('on failure request', () async {
        when(
          () => mockDio.get(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => failureResponse);

        final response = await adapter.get(uri);

        expect(response.data, {'key': 'fail'});
        expect(response.statusCode, 400);
      });
    });
    group("Post", () {
      final successResponse = Response(
        data: {"key": "success"},
        requestOptions: RequestOptions(
          data: {"data": "someData"},
        ),
        statusCode: 200,
      );

      final failureResponse = Response(
        data: {"key": "fail"},
        requestOptions: RequestOptions(
          data: {"data": "someData"},
        ),
        statusCode: 400,
      );
      test('on success request', () async {
        when(
          () => mockDio.post(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
            data: any(named: "data"),
          ),
        ).thenAnswer((_) async => successResponse);

        final response = await adapter.post(uri);

        expect(response.data, {'key': 'success'});
        expect(response.statusCode, 200);
      });
      test('on failure request', () async {
        when(
          () => mockDio.post(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
            data: any(named: "data"),
          ),
        ).thenAnswer((_) async => failureResponse);

        final response = await adapter.post(uri);

        expect(response.data, {'key': 'fail'});
        expect(response.statusCode, 400);
      });
    });
    group("Patch", () {
      final successResponse = Response(
        data: {"key": "success"},
        requestOptions: RequestOptions(),
        statusCode: 200,
      );

      final failureResponse = Response(
        data: {"key": "fail"},
        requestOptions: RequestOptions(),
        statusCode: 400,
      );
      test('on success request', () async {
        when(
          () => mockDio.patch(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => successResponse);

        final response = await adapter.patch(uri);

        expect(response.data, {'key': 'success'});
        expect(response.statusCode, 200);
      });
      test('on failure request', () async {
        when(
          () => mockDio.patch(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => failureResponse);

        final response = await adapter.patch(uri);

        expect(response.data, {'key': 'fail'});
        expect(response.statusCode, 400);
      });
    });
    group("Put", () {
      final successResponse = Response(
        data: {"key": "success"},
        requestOptions: RequestOptions(
          data: {"data": "someData"},
        ),
        statusCode: 200,
      );

      final failureResponse = Response(
        data: {"key": "fail"},
        requestOptions: RequestOptions(
          data: {"data": "someData"},
        ),
        statusCode: 400,
      );
      test('on success request', () async {
        when(
          () => mockDio.put(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => successResponse);

        final response = await adapter.put(uri);

        expect(response.data, {'key': 'success'});
        expect(response.statusCode, 200);
      });
      test('on failure request', () async {
        when(
          () => mockDio.put(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => failureResponse);

        final response = await adapter.put(uri);

        expect(response.data, {'key': 'fail'});
        expect(response.statusCode, 400);
      });
    });
    group("Delete", () {
      final successResponse = Response(
        data: {"key": "success"},
        requestOptions: RequestOptions(
          data: {"data": "someData"},
        ),
        statusCode: 200,
      );

      final failureResponse = Response(
        data: {"key": "fail"},
        requestOptions: RequestOptions(
          data: {"data": "someData"},
        ),
        statusCode: 400,
      );
      test('on success request', () async {
        when(
          () => mockDio.delete(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => successResponse);

        final response = await adapter.delete(uri);

        expect(response.data, {'key': 'success'});
        expect(response.statusCode, 200);
      });
      test('on failure request', () async {
        when(
          () => mockDio.delete(
            any(),
            options: any(named: "options"),
            queryParameters: any(named: "queryParameters"),
          ),
        ).thenAnswer((_) async => failureResponse);

        final response = await adapter.delete(uri);

        expect(response.data, {'key': 'fail'});
        expect(response.statusCode, 400);
      });
    });
  });
}
