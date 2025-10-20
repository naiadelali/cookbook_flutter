import 'package:core_common/failures/auth_failure.dart';
import 'package:core_common/models/session_model.dart';
import 'package:core_data/repositories/auth_repository.dart';
import 'package:core_data/usecases/refresh_token_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/mocks.dart';

void main() {
  late RefreshTokenUseCase usecase;
  late AuthRepository mockRepository;

  SessionModel mockSessionModel = SessionModel();
  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = RefreshTokenUseCaseImpl(mockRepository);
  });

  group('RefreshTokenUseCaseImpl', () {
    test('should return SessionModel when session exists', () async {
      // Arrange
      when(() => mockRepository.getUserSession())
          .thenAnswer((_) async => mockSessionModel);

      // Act
      final result = await usecase.call();

      // Assert
      expect(result.$1, equals(mockSessionModel));
      expect(result.$2, isNull);
      verify(() => mockRepository.getUserSession()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return AuthFailure when no session found', () async {
      // Arrange
      when(() => mockRepository.getUserSession()).thenAnswer((_) async => null);

      // Act
      final result = await usecase.call();

      // Assert
      expect(result.$1, isNull);
      expect(result.$2, isA<AuthFailure>());
      expect(result.$2?.message, "No session found");
      verify(() => mockRepository.getUserSession()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
