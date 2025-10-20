// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_meta_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionMetaModel _$SessionMetaModelFromJson(Map<String, dynamic> json) =>
    SessionMetaModel(
      timestamp: json['timestamp'] as String?,
      transactionId: (json['transactionId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SessionMetaModelToJson(SessionMetaModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'transactionId': instance.transactionId,
    };
