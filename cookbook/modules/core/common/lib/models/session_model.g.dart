// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
      meta: json['meta'] == null
          ? null
          : SessionMetaModel.fromJson(json['meta'] as Map<String, dynamic>),
      content: json['content'] == null
          ? null
          : SessionContentModel.fromJson(
              json['content'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionModelToJson(SessionModel instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'content': instance.content,
    };
