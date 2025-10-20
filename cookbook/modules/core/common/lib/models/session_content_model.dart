import 'package:core_common/models/user_model.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

part 'session_content_model.g.dart';

@JsonSerializable()
class SessionContentModel {
  String? accessToken;
  String? token;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;
  UserModel? user;

  SessionContentModel({
    this.accessToken,
    this.token,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
    this.user,
  });

  factory SessionContentModel.fromJson(Map<String, dynamic> json) =>
      _$SessionContentModelFromJson(json);
  Map<String, dynamic> toJson() => _$SessionContentModelToJson(this);

  SessionContentModel copyWithResponse(SessionContentModel? response) {
    return SessionContentModel(
      accessToken: response?.accessToken ?? accessToken,
      token: response?.token ?? token,
      expiresIn: response?.expiresIn ?? expiresIn,
      refreshExpiresIn: response?.refreshExpiresIn ?? refreshExpiresIn,
      refreshToken: response?.refreshToken ?? refreshToken,
      tokenType: response?.tokenType ?? tokenType,
      notBeforePolicy: response?.notBeforePolicy ?? notBeforePolicy,
      sessionState: response?.sessionState ?? sessionState,
      scope: response?.scope ?? scope,
      user: user,
    );
  }
}
