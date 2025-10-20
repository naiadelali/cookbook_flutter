import 'package:core_common/models/session_model.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class SignInState extends Equatable {
  final SessionModel? session;
  final String? errorMessage;
  final bool isLoading;

  SignInState({this.session, this.errorMessage, this.isLoading = false});

  @override
  List<Object?> get props => [session, errorMessage, isLoading];

  SignInState copyWith({
    SessionModel? session,
    String? errorMessage,
    bool? isLoading,
  }) {
    return SignInState(
      session: session ?? this.session,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}