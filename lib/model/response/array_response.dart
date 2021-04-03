import 'package:equatable/equatable.dart';
import 'package:find_jobs/model/entity/my_apply_job_entity.dart';

class ArrayResponse<T> extends Equatable{
  final bool result;
  final List<T> data;

  bool get isSuccess{
    return true;
  }

  ArrayResponse({this.result, this.data});

  ArrayResponse copyWith({
    bool result,
    List<T> data,
  }) {
    if ((result == null || identical(result, this.result)) &&
        (data == null || identical(data, this.data))) {
      return this;
    }

    return new ArrayResponse(
      result: result ?? this.result,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [result,data];

  factory ArrayResponse.fromJson(Map<String, dynamic> json) {
    ArrayResponse<T> resultGeneric = ArrayResponse<T>(
      result: json['result'] as bool ?? true,
    );
    if (json['appliedJobArr'] != null) {
      if (json['appliedJobArr'] is String) {
        return resultGeneric.copyWith(
          data: null,
        );
      } else if (json['appliedJobArr'] is List) {
        return resultGeneric.copyWith(
          data: (json['appliedJobArr'] as List)?.map((e) => _objectToFrom<T>(e))?.toList(),
        );
      }
    }
    return resultGeneric;
  }

  static T _objectToFrom<T>(json) {
    switch (T.toString()) {
      case 'MyApplyJobEntity':
        return MyApplyJobEntity.fromJson(json) as T;
      default:
        return json as T;
    }
  }

}