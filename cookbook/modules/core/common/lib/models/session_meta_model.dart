import 'package:shared_dependencies/shared_dependencies.dart';

part 'session_meta_model.g.dart';

@JsonSerializable()
class SessionMetaModel {
  String? timestamp;
  int? transactionId;

  SessionMetaModel({this.timestamp, this.transactionId});

  factory SessionMetaModel.fromJson(Map<String, dynamic> json) => _$SessionMetaModelFromJson(json);
  Map<String, dynamic> toJson() => _$SessionMetaModelToJson(this);
}
