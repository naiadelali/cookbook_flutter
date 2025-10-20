import 'package:core_common/models/session_model.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class HomeState extends Equatable {
  final String? errorMessage;
  final SessionModel? session;
  final bool isLoading;

  const HomeState({this.session, this.errorMessage, this.isLoading = false});

  @override
  List<Object?> get props => [ errorMessage, isLoading, session];

  HomeState copyWith({
    String? errorMessage,
    bool? isLoading,
    SessionModel? session,
  }) {
    return HomeState(
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      session: session ?? this.session,
    );
  }
}
