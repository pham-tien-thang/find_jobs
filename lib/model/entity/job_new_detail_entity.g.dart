// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_new_detail_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobNewDetailEntity _$JobNewDetailEntityFromJson(Map<String, dynamic> json) {
  return JobNewDetailEntity(
    jobNewsId: json['jobNewsId'] as int,
    ownerName: json['ownerName'] as String,
    avatarUrl: json['avatarUrl'] as String,
    status: json['statusName'] as String,
    typeOfWorkName: json['typeOfWorkName'] as String,
    companyName: json['companyName'] as String,
    jobShortDescription: json['jobShortDescription'] as String,
    salaryInVnd: json['salaryInVnd'] as int,
    jobDescription: json['jobDescription'] as String,
    subdistrictName: json['subdistrictName'] as String,
    districtName: json['districtName'] as String,
    stateProvinceName: json['stateProvinceName'] as String,
    detailAddress: json['detailAddress'] as String,
    requiredNumberYearsOfExperiences:
        json['requiredNumberYearsOfExperiences'] as int,
    jobTitleName: json['jobTitleName'] as String,
    companySizeByNumberEmployees: json['companySizeByNumberEmployees'] as int,
    companyWebsite: json['companyWebsite'] as String,
    companyEmail: json['companyEmail'] as String,
    companyPhoneNumber: json['companyPhoneNumber'] as String,
    requiredJobSkills: (json['requiredJobSkills'] as List)
        ?.map((e) => e == null
            ? null
            : RequiredJobSkill.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$JobNewDetailEntityToJson(JobNewDetailEntity instance) =>
    <String, dynamic>{
      'jobNewsId': instance.jobNewsId,
      'ownerName': instance.ownerName,
      'statusName': instance.status,
      'avatarUrl': instance.avatarUrl,
      'typeOfWorkName': instance.typeOfWorkName,
      'companyName': instance.companyName,
      'jobShortDescription': instance.jobShortDescription,
      'salaryInVnd': instance.salaryInVnd,
      'jobDescription': instance.jobDescription,
      'subdistrictName': instance.subdistrictName,
      'districtName': instance.districtName,
      'stateProvinceName': instance.stateProvinceName,
      'detailAddress': instance.detailAddress,
      'requiredNumberYearsOfExperiences':
          instance.requiredNumberYearsOfExperiences,
      'jobTitleName': instance.jobTitleName,
      'companySizeByNumberEmployees': instance.companySizeByNumberEmployees,
      'companyWebsite': instance.companyWebsite,
      'companyEmail': instance.companyEmail,
      'companyPhoneNumber': instance.companyPhoneNumber,
      'requiredJobSkills': instance.requiredJobSkills,
    };
