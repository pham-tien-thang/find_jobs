// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyJobEntity _$ApplyJobEntityFromJson(Map<String, dynamic> json) {
  return ApplyJobEntity(
    result: json['result'] as bool,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ApplyJobEntityToJson(ApplyJobEntity instance) =>
    <String, dynamic>{
      'result': instance.result,
      'message': instance.message,
    };
