import 'package:json_annotation/json_annotation.dart';

part 'required_job_skills.g.dart';


@JsonSerializable()
class RequiredJobSkill{

  @JsonKey()
  int id;

  @JsonKey()
  String skillName;


  RequiredJobSkill({this.id, this.skillName});

  factory RequiredJobSkill.fromJson(Map<String, dynamic> json) => _$RequiredJobSkillFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredJobSkillToJson(this);
}