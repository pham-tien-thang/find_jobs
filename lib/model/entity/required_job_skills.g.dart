// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'required_job_skills.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequiredJobSkill _$RequiredJobSkillFromJson(Map<String, dynamic> json) {
  return RequiredJobSkill(
    id: json['id'] as int,
    skillName: json['skillName'] as String,
  );
}

Map<String, dynamic> _$RequiredJobSkillToJson(RequiredJobSkill instance) =>
    <String, dynamic>{
      'id': instance.id,
      'skillName': instance.skillName,
    };
