// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobDetailEntity _$JobDetailEntityFromJson(Map<String, dynamic> json) {
  return JobDetailEntity(
    result: json['result'] as bool,
    jobNewDetailEntity: json['jobNewDetailEntity'] == null
        ? null
        : JobNewDetailEntity.fromJson(
            json['jobNewDetailEntity'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$JobDetailEntityToJson(JobDetailEntity instance) =>
    <String, dynamic>{
      'result': instance.result,
      'jobNewDetailEntity': instance.jobNewDetailEntity,
    };
