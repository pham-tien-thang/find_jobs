import 'package:json_annotation/json_annotation.dart';

part 'apply_job_entity.g.dart';

@JsonSerializable()
class ApplyJobEntity{

  @JsonKey()
  bool result;

  @JsonKey()
  String message;

  ApplyJobEntity({this.result, this.message});

  factory ApplyJobEntity.fromJson(Map<String, dynamic> json) => _$ApplyJobEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyJobEntityToJson(this);
}