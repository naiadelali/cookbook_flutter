import 'package:shared_dependencies/shared_dependencies.dart';

part 'login_model.g.dart';

@JsonSerializable()
class LoginModel {
  final String email;
  final String password;
  // final String clientId;
  // final String clientSecret;
  // final String grantType;
  // final LoginMethod method;

  LoginModel({
    required this.email,
    required this.password,
    // required this.method,
    // required this.clientId,
    // required this.clientSecret,
    // this.grantType = "password",
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}
