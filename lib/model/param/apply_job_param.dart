import 'package:json_annotation/json_annotation.dart';

part 'apply_job_param.g.dart';


@JsonSerializable()
class ApplyJobParam{

  @JsonKey()
  String userId;

  @JsonKey()
  String jobNewsId;

  ApplyJobParam({this.userId, this.jobNewsId});

  factory ApplyJobParam.fromJson(Map<String, dynamic> json) => _$ApplyJobParamFromJson(json);

  Map<String, dynamic> toJson() => _$ApplyJobParamToJson(this);
}