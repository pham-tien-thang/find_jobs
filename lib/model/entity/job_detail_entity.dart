import 'package:find_jobs/model/entity/job_new_detail_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'job_detail_entity.g.dart';

@JsonSerializable()
class JobDetailEntity {
  @JsonKey()
  bool result;

  @JsonKey(name: "jobNewsDetails")
  JobNewDetailEntity jobNewDetailEntity;

  JobDetailEntity({this.result, this.jobNewDetailEntity});

  factory JobDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$JobDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$JobDetailEntityToJson(this);
}
