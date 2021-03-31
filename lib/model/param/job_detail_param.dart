import 'package:json_annotation/json_annotation.dart';

part 'job_detail_param.g.dart';

@JsonSerializable()
class JobDetailParam{

  @JsonKey()
  String jobNewsId;

  JobDetailParam({this.jobNewsId});

  factory JobDetailParam.fromJson(Map<String, dynamic> json) => _$JobDetailParamFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailParamToJson(this);
}