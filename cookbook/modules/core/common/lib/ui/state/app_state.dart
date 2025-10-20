import 'package:core_common/models/session_model.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

class AppState extends Equatable {
  final SessionModel? session;

  const AppState({this.session});

  @override
  List<Object?> get props => [];

  AppState copyWith({SessionModel? sessionModel}) {
    return AppState(
      session: sessionModel ?? session,
    );
  }
}
