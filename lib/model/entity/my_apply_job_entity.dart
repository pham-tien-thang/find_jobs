import 'package:json_annotation/json_annotation.dart';

part 'my_apply_job_entity.g.dart';

@JsonSerializable()
class MyApplyJobEntity {
  // "jobNewsId": 2,
  // "companyName": "Công ty Monstar Lab Hà Nội",
  // "jobShortDescription": "Thực Tập Sinh Android"
  @JsonKey()
  int jobNewsId;

  @JsonKey()
  String companyName;

  @JsonKey()
  String jobShortDescription;

  MyApplyJobEntity(
      {this.jobNewsId, this.companyName, this.jobShortDescription});

  factory MyApplyJobEntity.fromJson(Map<String, dynamic> json) => _$MyApplyJobEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyApplyJobEntityToJson(this);
}
