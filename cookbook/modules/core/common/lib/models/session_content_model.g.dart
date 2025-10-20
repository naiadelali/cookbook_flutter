// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_content_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionContentModel _$SessionContentModelFromJson(Map<String, dynamic> json) =>
    SessionContentModel(
      accessToken: json['accessToken'] as String?,
      token: json['token'] as String?,
      expiresIn: (json['expiresIn'] as num?)?.toInt(),
      refreshExpiresIn: (json['refreshExpiresIn'] as num?)?.toInt(),
      refreshToken: json['refreshToken'] as String?,
      tokenType: json['tokenType'] as String?,
      notBeforePolicy: (json['notBeforePolicy'] as num?)?.toInt(),
      sessionState: json['sessionState'] as String?,
      scope: json['scope'] as String?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionContentModelToJson(
        SessionContentModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'token': instance.token,
      'expiresIn': instance.expiresIn,
      'refreshExpiresIn': instance.refreshExpiresIn,
      'refreshToken': instance.refreshToken,
      'tokenType': instance.tokenType,
      'notBeforePolicy': instance.notBeforePolicy,
      'sessionState': instance.sessionState,
      'scope': instance.scope,
      'user': instance.user,
    };
