// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_apply_job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyApplyJobEntity _$MyApplyJobEntityFromJson(Map<String, dynamic> json) {
  return MyApplyJobEntity(
    jobNewsId: json['jobNewsId'] as int,
    companyName: json['companyName'] as String,
    jobShortDescription: json['jobShortDescription'] as String,
  );
}

Map<String, dynamic> _$MyApplyJobEntityToJson(MyApplyJobEntity instance) =>
    <String, dynamic>{
      'jobNewsId': instance.jobNewsId,
      'companyName': instance.companyName,
      'jobShortDescription': instance.jobShortDescription,
    };
