import 'package:core_common/models/session_content_model.dart';
import 'package:core_common/models/session_meta_model.dart';
import 'package:shared_dependencies/shared_dependencies.dart';

part 'session_model.g.dart';

@JsonSerializable()
class SessionModel {
  SessionMetaModel? meta;
  SessionContentModel? content;

  SessionModel({this.meta, this.content});

  SessionModel copyWithResponse(SessionModel? response) {
    return SessionModel(
      meta: meta,
      content: content?.copyWithResponse(response?.content),
    );
  }

  factory SessionModel.fromJson(Map<String, dynamic> json) => _$SessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$SessionModelToJson(this);
}
