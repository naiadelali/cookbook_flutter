import 'package:shared_dependencies/shared_dependencies.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? id;
  String? keycloakId;
  String? email;
  String? name;

  UserModel(
      {this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.id,
      this.keycloakId,
      this.email,
      this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
