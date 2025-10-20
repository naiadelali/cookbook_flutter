import 'package:core_common/failures/auth_failure.dart';
import 'package:core_data/usecases/logout_usecase.dart';
import 'package:core_data/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late LogoutUseCase usecase;
  late AuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = LogoutUseCaseImpl(mockRepository);
  });

  group('LogoutUseCaseImpl', () {
    test('should return null', () async {
      // Arrange
      when(() => mockRepository.logout())
          .thenAnswer((_) async => (null, null));

      // Act
      final result = await usecase.call();

      // Assert
      expect(result, equals((null, null)));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return AuthFailure', () async {
      // Arrange
      final failure = AuthFailure("server-failure");

      when(() => mockRepository.logout())
          .thenAnswer((_) async => (null, failure));

      // Act
      final result = await usecase.call();

      // Assert
      expect(result, equals((null, failure)));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
