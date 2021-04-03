// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_apply_done.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyApplyDone _$MyApplyDoneFromJson(Map<String, dynamic> json) {
  return MyApplyDone(
    result: json['result'] as bool,
    appliedJobArr: (json['appliedJobArr'] as List)
        ?.map((e) => e == null
            ? null
            : MyApplyJobEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MyApplyDoneToJson(MyApplyDone instance) =>
    <String, dynamic>{
      'result': instance.result,
      'appliedJobArr': instance.appliedJobArr,
    };
