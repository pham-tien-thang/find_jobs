import 'package:find_jobs/model/entity/my_apply_job_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_apply_done.g.dart';

@JsonSerializable()
class MyApplyDone{

  @JsonKey()
  bool result;

  @JsonKey()
  List<MyApplyJobEntity> appliedJobArr;

  MyApplyDone({this.result, this.appliedJobArr});

  MyApplyDone copyWith({
    bool result,
    List<MyApplyJobEntity> appliedJobArr,
  }) {
    return new MyApplyDone(
      result: result ?? this.result,
      appliedJobArr: appliedJobArr ?? this.appliedJobArr,
    );
  }

  factory MyApplyDone.fromJson(Map<String, dynamic> json) => _$MyApplyDoneFromJson(json);

  Map<String, dynamic> toJson() => _$MyApplyDoneToJson(this);
}