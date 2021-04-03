part of 'my_apply_jobs_cubit.dart';

class MyApplyJobsState extends Equatable {
  LoadStatus loadStatus;
  LoadStatus deleteApplyStatus;
  List<MyApplyJobEntity> list;
  String message;

  MyApplyJobsState({
    this.loadStatus = LoadStatus.INITIAL,
    this.list,
    this.message,
    this.deleteApplyStatus = LoadStatus.INITIAL,
  });

  MyApplyJobsState copyWith({
    LoadStatus loadStatus,
    String message,
    LoadStatus deleteApplyStatus,
    List<MyApplyJobEntity> list,
  }) {
    return new MyApplyJobsState(
      loadStatus: loadStatus ?? this.loadStatus,
      deleteApplyStatus: deleteApplyStatus ?? this.deleteApplyStatus,
      list: list ?? this.list,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [loadStatus, list,deleteApplyStatus,message];
}
